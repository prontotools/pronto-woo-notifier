class SitesController < InheritedResources::Base

  private

    def site_params
      params.require(:site).permit(:name, :domain, :port)
    end
end

