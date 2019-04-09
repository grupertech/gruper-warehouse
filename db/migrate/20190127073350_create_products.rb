class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :name
      t.decimal :price
      t.integer :qty
      t.string :status
      t.text :description
      t.string :weight
      t.string :length
      t.string :high
      t.string :wide
      t.json :images
      t.string :created_by
      t.string :updated_by
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
