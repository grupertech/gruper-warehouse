class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  validates :name, :email, :company, :phone_number, :address, :country, presence: true
end