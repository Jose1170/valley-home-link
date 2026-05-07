class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.references :job_request, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :booking_status

      t.timestamps
    end
  end
end
