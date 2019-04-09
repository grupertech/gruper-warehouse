class CreatePurchaseDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_details do |t|
      t.references :product, foreign_key: true
      t.references :tax, foreign_key: true
      t.belongs_to :purchase, index: true
      t.decimal :cost
      t.integer :qty
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
