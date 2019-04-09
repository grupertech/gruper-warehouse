class PurchaseDetail < ApplicationRecord
  belongs_to :product
  belongs_to :tax
  belongs_to :purchase

  before_save :update_product_qty
  
  validates :cost, :qty, presence: true

  def total_price
    self.cost * self.qty
  end

  def tax_per_product
    self.tax.rate / 100 * self.cost
  end

  def tax_all_product
    (self.tax.rate / 100 * self.cost) * self.qty
  end

  private
    def update_product_qty
      self.product.update(qty: (self.product.qty + self.qty))
    end
end