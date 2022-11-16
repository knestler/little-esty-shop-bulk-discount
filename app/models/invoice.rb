class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_one :merchant, through: :items
  has_many :bulk_discounts, through: :merchant

  validates_presence_of :status

  enum status: ["in progress", "cancelled", "completed"]

  def self.uniq_invoices
    distinct
  end

  def my_total_revenue
    invoice_items.sum('unit_price * quantity')
  end

  def my_total_revenue_formatter
    "%.2f" % my_total_revenue
  end

  def self.incomplete_invoices
    joins(:invoice_items).where("invoice_items.status != ?", 2).distinct.order(:created_at)
  end

  def discounted_amount
    invoice_items.joins(item: [merchant: :bulk_discounts])
    .select('MAX(invoice_items.unit_price * invoice_items.quantity * bulk_discounts.percentage_discount/100.00) as max_discount')
    .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
    .sum(&:max_discount)
  end

  def discounted_revenue
    my_total_revenue - discounted_amount
  end
end
