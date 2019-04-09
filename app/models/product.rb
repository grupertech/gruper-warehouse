class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  belongs_to :unit
  has_many :invoice_details, dependent: :destroy
  has_many :purchase_details, dependent: :destroy

  mount_uploaders :images, ProductUploader

  validates :name, :qty, :price, :weight, :length, :high, :wide, presence: true

  # Total price and tax will be calculated on invoice
  # this method could be sample calculation
  # def total_price
  #   ((self.price * self.tax.rate) / 100 * self.qty) + self.price * self.qty
  # end
end