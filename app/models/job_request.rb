class JobRequest < ApplicationRecord
  enum :job_status, { open: 0, assigned: 1, completed: 2 }, default: :open

  belongs_to :customer, class_name: "User", foreign_key: "customer_id", optional: true
  belongs_to :provider, class_name: "User", foreign_key: "provider_id", optional: true
  belongs_to :service_category, optional: true
  belongs_to :address, optional: true, inverse_of: :job_requests

  has_one :booking, dependent: :destroy

  before_validation :assign_address_user

  accepts_nested_attributes_for :address, reject_if: ->(attributes) { attributes['street_address'].blank? && attributes['city'].blank? }

  private

  def assign_address_user
    if address.present? && address.user_id.nil?
      address.user_id = customer_id || current_user&.id
    end
  end
end