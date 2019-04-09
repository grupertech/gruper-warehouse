class AddInvoiceIdToPayments < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :invoice, foreign_key: true
  end
end
