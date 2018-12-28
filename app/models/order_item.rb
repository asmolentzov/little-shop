class OrderItem < ApplicationRecord
  validates_presence_of :order_id, :item_id, :quantity, :order_price
  validates :fulfilled, inclusion: {in: [true, false]}

  belongs_to :order
  belongs_to :item

  def subtotal
    quantity * order_price
  end
end
