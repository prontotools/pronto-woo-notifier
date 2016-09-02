class Plugin < ApplicationRecord
    has_many :plugin_trackers
    has_many :sites, through: :plugin_trackers

    validates :name, presence: true
    validates :latest_version, presence: true
end
