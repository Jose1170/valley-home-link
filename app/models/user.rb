class User < ApplicationRecord
    has_secure_password

    enum :role, { customer: 0, provider: 1, admin: 2 }

    validates :username, presence: true, uniqueness: true
    validates :role, presence: true

    has_many :job_requests, foreign_key: :customer_id, dependent: :destroy
    has_many :addresses, dependent: :destroy
end
