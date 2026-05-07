class Booking < ApplicationRecord
  belongs_to :job_request
  belongs_to :user

  validates :scheduled_at, presence: true, on: :update
  validate :meeting_cannot_be_in_the_past, if: -> { scheduled_at.present? }

  enum :booking_status, { pending: 0, confirmed: 1, completed: 2, cancelled: 3 }

  private

  def meeting_cannot_be_in_the_past
    if scheduled_at < Date.today
      errors.add(:scheduled_at, "Can't be before today")
    end
  end

  validates :job_request_id, :user_id, presence: true
end
