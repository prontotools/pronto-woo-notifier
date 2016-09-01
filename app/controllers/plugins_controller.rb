class PluginsController < InheritedResources::Base

  private

    def plugin_params
      params.require(:plugin).permit(:name, :lastest_version)
    end
end

