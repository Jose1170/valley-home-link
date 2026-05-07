class CreateProviderServices < ActiveRecord::Migration[8.1]
  def change
    create_table :provider_services do |t|
      t.references :provider, null: false, foreign_key: true
      t.references :service_category, null: false, foreign_key: true
      t.decimal :base_price
      t.integer :status

      t.timestamps
    end
  end
end
