class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.text :note
      t.string :status
      t.string :created_at
      t.string :updated_at

      t.timestamps
    end
  end
end
