class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
