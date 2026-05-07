class CreateJobRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :job_requests do |t|
      t.string :job_title
      t.text :job_description
      t.integer :job_status

      t.timestamps
    end
  end
end
