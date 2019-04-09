class CreateCompanyInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :company_infos do |t|
      t.string :name_company
      t.string :npwp
      t.string :website
      t.string :image
      t.string :address
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :country
      t.string :name_person
      t.string :phone_one
      t.string :phone_two
      t.string :email
      t.string :fax
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
