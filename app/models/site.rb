class Site < ApplicationRecord
    validates :name, presence: true
    VALID_DOMAIN_REGEX = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
    validates :domain, presence: true, format: { with: VALID_DOMAIN_REGEX }
    validates :port, presence:true, uniqueness: true
end
