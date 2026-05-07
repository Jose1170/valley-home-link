class ProviderService < ApplicationRecord
  belongs_to :provider, class_name: "User", foreign_key: "provider_id"
  belongs_to :service_category
end
