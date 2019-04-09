class Payment < ApplicationRecord
  belongs_to :invoice, optional: true
  belongs_to :purchase, optional: true
  after_create :payment_invoice_status, :payment_purchase_status
  after_create :payment_number_payment
  before_save :update_payment_invoice_status, :update_payment_purchase_status
  
  validates :amount, presence: true

  # Update for Payment Invoice
  def update_payment_invoice_status
    if self.invoice.present?
      if self.status == 'confirmed'
        self.invoice.update(status: 'paid')
      elsif self.status == 'paid partially' && self.amount != self.invoice.grand_total
        self.invoice.update(status: 'paid partially')
      elsif self.status == 'paid partially' && self.amount == self.invoice.grand_total
        self.invoice.update(status: 'paid off (paid partially)')
      elsif self.status == 'pending'
        self.invoice.update(status: 'pending')
      elsif self.status == 'cancel'
        self.invoice.update(status: 'cancel')
      end
    end
  end

  def payment_invoice_status
    if self.invoice.present?
      if self.status.nil? && self.amount == self.invoice.grand_total
        self.update(status: 'pending')
      elsif self.status.nil? && self.amount != self.invoice.grand_total
        self.update(status: 'paid partially')
      end
    end
  end

  # Update for Payment Purchase
  def update_payment_purchase_status
    if self.purchase.present?
      if self.status == 'confirmed'
        self.purchase.update(status: 'paid')
      elsif self.status == 'paid partially' && self.amount != self.purchase.grand_total
        self.purchase.update(status: 'paid partially')
      elsif self.status == 'paid partially' && self.amount == self.purchase.grand_total
        self.purchase.update(status: 'paid off (paid partially)')
      elsif self.status == 'pending'
        self.purchase.update(status: 'pending')
      elsif self.status == 'cancel'
        self.purchase.update(status: 'cancel')
      end
    end
  end

  def payment_purchase_status
    if self.purchase.present?
      if self.status.nil? && self.amount == self.purchase.grand_total
        self.update(status: 'pending')
      elsif self.status.nil? && self.amount != self.purchase.grand_total
        self.update(status: 'paid partially')
      end
    end
  end
  
  def payment_number_payment
    self.update(number_payment: 'PYM' + Date.today.strftime("%d%m%Y") + id.to_s.rjust(5, '0'))
  end
end