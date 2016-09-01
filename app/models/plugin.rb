class Plugin < ApplicationRecord
    validates :name, presence: true
    validates :lastest_version, presence: true
end
