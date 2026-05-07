class AddProviderToJobRequests < ActiveRecord::Migration[8.1]
  def change
    add_column :job_requests, :provider_id, :integer
  end
end
