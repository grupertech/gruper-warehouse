class Purchase < ApplicationRecord
  before_save :calculate_purchase, :calculate_purchase_after_tax
  after_create :purchase_number_purchase
  after_create :purchase_shipping
  after_create :purchase_status

  belongs_to :vendor
  belongs_to :payment_type
  has_many :payments, dependent: :destroy
  has_many :purchase_details, inverse_of: :purchase, dependent: :destroy
  accepts_nested_attributes_for :purchase_details, reject_if: :all_blank, allow_destroy: true

  scope :purchase_this_month, -> { where(created_at: Time.now.beginning_of_month..(Time.now.end_of_month)) }
  scope :purchase_this_week, -> { where(created_at: Time.now.beginning_of_week(start_day = :monday)..Time.now.end_of_week(end_day = :sunday)) }
  scope :purchase_today, -> { where(created_at: Date.today) }
  scope :purchase_paid, -> { where(status: 'paid') }
  scope :purchase_pending, -> { where(status: 'pending') }
  scope :purchase_cancel, -> { where(status: 'cancel') }

  validates :purchase_date, presence: true

  def purchase_number_purchase
    self.update(number_purchase: 'PCS' + Date.today.strftime("%d%m%Y") + id.to_s.rjust(5, '0'))
  end

  def purchase_shipping
    self.update(shipping: '#' + Date.today.strftime("%d%m%Y") + id.to_s.rjust(5, '0'))
  end

  def purchase_status
    self.update(status: 'pending')
  end

  private
    def calculate_purchase
      self.subtotal = 0

      self.purchase_details.each do |i|
        unless i.marked_for_destruction?
          self.subtotal += (i.qty * i.cost)
        end
      end
    end

    def calculate_purchase_after_tax
      self.grand_total = 0

      self.purchase_details.each do |i|
        unless i.marked_for_destruction?
          self.grand_total += (((i.cost * i.tax.rate) / 100 * i.qty) + i.cost * i.qty)
        end
      end
    end
end