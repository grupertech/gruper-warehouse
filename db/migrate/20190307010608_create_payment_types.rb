class CreatePaymentTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_types do |t|
      t.string :name
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
