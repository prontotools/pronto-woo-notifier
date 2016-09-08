class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all
    @contexts = []
    @sites.each do |site|
      need_update = false
      installed_plugins = site.plugin_trackers.all
      installed_plugins.each do |installed_plugin|
        if installed_plugin.current_version != installed_plugin.plugin.latest_version
          need_update = true
          break
        end
      end
      @contexts << {site: site, need_update: need_update}
    end
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    @plugin_trackers = @site.plugin_trackers.all
  end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)

    respond_to do |format|
      if @site.save
        flash[:success] = 'Site was successfully created.'
        format.html { redirect_to @site}
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        flash[:success] = "Site was successfully updated."
        format.html { redirect_to @site }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sync_all
    sites = Site.all
    sites.each do |site|
      url = URI.join(site.domain, "/api/pronto/get_active_woocommerce_plugins_and_version/")
      response = HTTP.get(url)
      next unless response.status.success?
      all_plugins = response.parse['plugins']
      all_plugins.each do |name, version|
        plugin = Plugin.find_by(name: name)
        site.plugin_trackers.find_or_initialize_by(
          plugin: plugin
        ).update_attributes({current_version: version})
      end
    end
    respond_to do |format|
      flash[:success] = 'All Plugins version was successfully updated for each site.'
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end

  def sync_each
    site = set_site
    url = URI.join(site.domain, "/api/pronto/get_active_woocommerce_plugins_and_version/")
    response = HTTP.get(url)
    redirect_to site_url and return unless response.status.success?
    all_plugins = response.parse['plugins']
    all_plugins.each do |name, version|
      plugin = Plugin.find_by(name: name)
      site.plugin_trackers.find_or_initialize_by(
        plugin: plugin
      ).update_attributes({current_version: version})
    end
    respond_to do |format|
      flash[:success] = "All Plugins version was successfully updated for #{site.name}."
      format.html { redirect_to site_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:name, :domain, :port, :database_name)
    end
end
