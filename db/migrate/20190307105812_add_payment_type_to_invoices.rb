class AddPaymentTypeToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_reference :invoices, :payment_type, foreign_key: true
  end
end
