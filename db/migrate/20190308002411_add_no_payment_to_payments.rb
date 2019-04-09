class AddNoPaymentToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :number_payment, :string
  end
end
