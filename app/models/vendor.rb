class Vendor < ApplicationRecord
  has_many :purchases, dependent: :destroy
  validates :name, :email, :company, :phone_number, :address, :country, presence: true
end