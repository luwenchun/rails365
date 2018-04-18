class Admin::SiteInfo < ApplicationRecord
  include IdentityCache
  cache_index :key, unique: true
  validates :value, presence: true
end
