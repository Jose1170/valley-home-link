class AddDetailsToJobRequests < ActiveRecord::Migration[8.1]
  def change
    add_column :job_requests, :service_category_id, :integer
    add_column :job_requests, :address_id, :integer
    add_column :job_requests, :customer_id, :integer
  end
end
