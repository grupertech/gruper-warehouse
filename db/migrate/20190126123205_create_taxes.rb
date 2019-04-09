class CreateTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :taxes do |t|
      t.string :name
      t.decimal :rate
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
