class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.date :invoice_date
      t.string :reference
      t.references :customer, foreign_key: true
      t.string :shipping
      t.string :status
      t.decimal :subtotal
      t.decimal :grand_total
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
