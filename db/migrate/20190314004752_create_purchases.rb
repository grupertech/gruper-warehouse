class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.date :purchase_date
      t.string :number_purchase
      t.references :vendor, foreign_key: true
      t.string :shipping
      t.string :status
      t.references :payment_type, foreign_key: true
      t.decimal :subtotal
      t.decimal :grand_total
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
