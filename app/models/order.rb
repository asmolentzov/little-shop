class Order < ApplicationRecord
  validates_presence_of :status, :user_id

  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  enum status: [:pending, :fulfilled, :cancelled]

  def self.biggest_orders
    joins(:order_items)
    .where(status: 1)
    .where("order_items.fulfilled = ?", true)
    .select("orders.*, count(order_items.id) AS item_count")
    .group(:id)
    .order("item_count DESC")
    .limit(3)
  end
  
  def self.merchant_pending_orders(merchant_id)
    joins(:items)
    .where("items.user_id = ?", merchant_id)
    .where(status: :pending)
  end

  def item_quantity
    OrderItem.where(order_id: id).sum(:quantity)
  end

  def grand_total
    OrderItem.where(order_id: id).sum("quantity * order_price")
  end
  
  def merchant_items_quantity(merchant_id)
    items
    .where("items.user_id = ?", merchant_id)
    .count
  end

end
