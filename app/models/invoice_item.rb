class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: { pending: 0, packaged: 1, shipped: 2 }

  validates :quantity, :unit_price, :status, :presence => true
  validates :quantity, :unit_price, :numericality => true

  def self.uniq_invoice_items
    distinct
  end

  # def self.discounted_invoice_item
  #   joins(item: {merchant: :bulk_discounts})
  #   .select('invoice_item.unit_price * invoice_item.quantity * bulk_discounts.percentage_discount')
  #   .where('invoice_item.quantity >= bulk_discounts.quantity_threshold')
  #   .group(:id)
  #   .sum(&:bulk_discounts)
  #   require 'pry'; binding.pry


  #   joins(item: [merchant: :bulk_discounts])
  #   .select('max(invoice_item.unit_price * invoice_item.quantity * bulk_discounts.percentage_discount) as max_discount')
  #   .where('invoice_item.quantity >= bulk_discounts.quantity_threshold')
  #   .group(:id)
  #   .sum(&:max_discount)
  # end
  
  # def highest_discount
  #   bulk_discounts.joins(merchant: [item: :invoice_items])
  #   .where('discounted_invoice_item.quantity >= bulk_discounts.quantity_threshold')
  #   .group('bulk_discounts.id')
  # end


  # def self.discounted_revenue
  #   my_total_revenue - highest_discount
  #   require 'pry'; binding.pry
  # end
end
