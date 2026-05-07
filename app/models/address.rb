class Address < ApplicationRecord
  belongs_to :user, optional: true
  has_many :job_requests
end