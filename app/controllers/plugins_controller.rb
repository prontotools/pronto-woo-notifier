require "http"

class PluginsController < ApplicationController
  before_action :set_plugin, only: [:show, :edit, :update, :destroy]

  # GET /plugins
  # GET /plugins.json
  def index
    @plugins = Plugin.all
    @pluins
  end

  # GET /plugins/1
  # GET /plugins/1.json
  def show
  end

  # GET /plugins/new
  def new
    @plugin = Plugin.new
  end

  # GET /plugins/1/edit
  def edit
  end

  # POST /plugins
  # POST /plugins.json
  def create
    @plugin = Plugin.new(plugin_params)

    respond_to do |format|
      if @plugin.save
        format.html { redirect_to @plugin, notice: 'Plugin was successfully created.' }
        format.json { render :show, status: :created, location: @plugin }
      else
        format.html { render :new }
        format.json { render json: @plugin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plugins/1
  # PATCH/PUT /plugins/1.json
  def update
    respond_to do |format|
      if @plugin.update(plugin_params)
        format.html { redirect_to @plugin, notice: 'Plugin was successfully updated.' }
        format.json { render :show, status: :ok, location: @plugin }
      else
        format.html { render :edit }
        format.json { render json: @plugin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plugins/1
  # DELETE /plugins/1.json
  def destroy
    @plugin.destroy
    respond_to do |format|
      format.html { redirect_to plugins_url, notice: 'Plugin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sync
    url = "http://prontotools.pi.bypronto.com/api/pronto/get_all_woocommerce_plugins_and_latest_version/"
    response = HTTP.get(url)
    redirect_to plugins_url and return unless response.status.success?
    all_plugins = response.parse['plugins']
    all_plugins.each do |name, version|
        Plugin.find_or_initialize_by(name: name).update_attributes(
          {latest_version: version}
        )
    end
    respond_to do |format|
      flash[:success] = "All Plugins was successfully updated lastest version." 
      format.html { redirect_to plugins_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plugin
      @plugin = Plugin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plugin_params
      params.require(:plugin).permit(:name, :latest_version)
    end
end
