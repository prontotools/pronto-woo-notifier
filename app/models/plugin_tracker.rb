class PluginTracker < ApplicationRecord
    belongs_to :site
    belongs_to :plugin

    validates :site, presence: true
    validates :plugin, presence: true
    validates :current_version, presence: true
end
