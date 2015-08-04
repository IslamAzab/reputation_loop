class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :state
      t.string :city
      t.string :zip

      t.timestamps null: false
    end
  end
end
