class CreateServiceCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :service_categories do |t|
      t.string :name
      t.integer :status

      t.timestamps
    end
  end
end
