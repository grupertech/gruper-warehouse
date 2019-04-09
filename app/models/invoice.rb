class Invoice < ApplicationRecord
  before_save :calculate_invoice, :calculate_invoice_after_tax
  after_create :invoice_number_invoice
  after_create :invoice_shipping
  after_create :invoice_status

  belongs_to :customer
  belongs_to :payment_type
  has_many :payments, dependent: :destroy
  has_many :invoice_details, inverse_of: :invoice, dependent: :destroy
  accepts_nested_attributes_for :invoice_details, reject_if: :all_blank, allow_destroy: true

  scope :invoice_this_month, -> { where(created_at: Time.now.beginning_of_month..(Time.now.end_of_month)) }
  scope :invoice_this_week, -> { where(created_at: Time.now.beginning_of_week(start_day = :monday)..Time.now.end_of_week(end_day = :sunday)) }
  scope :invoice_today, -> { where(created_at: Date.today) }
  scope :invoice_paid, -> { where(status: 'paid') }
  scope :invoice_pending, -> { where(status: 'pending') }
  scope :invoice_cancel, -> { where(status: 'cancel') }
  
  validates :invoice_date, presence: true

  def invoice_number_invoice
    self.update(number_invoice: 'INV' + Date.today.strftime("%d%m%Y") + id.to_s.rjust(5, '0'))
  end

  def invoice_shipping
    self.update(shipping: '#' + Date.today.strftime("%d%m%Y") + id.to_s.rjust(5, '0'))
  end

  def invoice_status
    self.update(status: 'pending')
  end

  private
    def calculate_invoice
      self.subtotal = 0

      self.invoice_details.each do |i|
        unless i.marked_for_destruction?
          self.subtotal += (i.qty * i.cost)
        end
      end
    end

    def calculate_invoice_after_tax
      self.grand_total = 0

      self.invoice_details.each do |i|
        unless i.marked_for_destruction?
          self.grand_total += (((i.cost * i.tax.rate) / 100 * i.qty) + i.cost * i.qty)
        end
      end
    end
end