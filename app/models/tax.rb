class Tax < ApplicationRecord
  has_many :invoice_details, dependent: :destroy
  has_many :purchase_details, dependent: :destroy
  
  validates :name, :rate, presence: true
end