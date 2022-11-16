class BulkDiscount <ApplicationRecord
belongs_to :merchant
  
validates :percentage_discount, :quantity_threshold, :presence => true, :numericality => true

  def self.best_discount(quantity)
    where("quantity_threshold <= ?", quantity)
    .order(percentage_discount: :asc)
    .last
  end
end