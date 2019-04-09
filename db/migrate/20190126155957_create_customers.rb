class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :company
      t.string :phone_number
      t.string :address
      t.string :country
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
