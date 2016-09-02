class PluginTracker < ApplicationRecord
    belongs_to :site
    belongs_to :plugin

    validates :current_version, presence: true
end
