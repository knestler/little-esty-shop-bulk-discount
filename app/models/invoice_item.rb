class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item


  enum status: { pending: 0, packaged: 1, shipped: 2 }

  validates :quantity, :unit_price, :status, :presence => true
  validates :quantity, :unit_price, :numericality => true

  def self.uniq_invoice_items
    distinct
  end

  def discount_used
    item.merchant.bulk_discounts.best_discount(quantity)
  end 

end
