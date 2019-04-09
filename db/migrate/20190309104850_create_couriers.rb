class CreateCouriers < ActiveRecord::Migration[5.2]
  def change
    create_table :couriers do |t|
      t.string :code
      t.string :name
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
