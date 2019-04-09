class FixColumnNameOnInvoices < ActiveRecord::Migration[5.2]
  def change
    rename_column :invoices, :reference, :number_invoice
  end
end
