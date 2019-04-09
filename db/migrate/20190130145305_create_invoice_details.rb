class CreateInvoiceDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_details do |t|
      t.references :product, foreign_key: true
      t.references :tax, foreign_key: true
      t.belongs_to :invoice, index: true
      t.decimal :cost
      t.integer :qty
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
