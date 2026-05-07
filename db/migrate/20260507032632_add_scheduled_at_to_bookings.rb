class AddScheduledAtToBookings < ActiveRecord::Migration[8.1]
  def change
    add_column :bookings, :scheduled_at, :datetime
  end
end
