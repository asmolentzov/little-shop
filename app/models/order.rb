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
    .group(:id)
  end

  def update_status_if_fulfilled
    pending_order_items = OrderItem
      .where("order_id = ?", self.id)
      .where("fulfilled = false")
    if pending_order_items == []
      Order.find(self.id).update(status: "fulfilled")
    end
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

  def merchant_items_value(merchant_id)
    items
    .where("items.user_id = ?", merchant_id)
    .sum("order_items.order_price")
  end

  def merchant_items_with_quantity(merchant_id)
    items = self.items.where("items.user_id = ?", merchant_id)
    item_ids = items.map {|item| item.id}
    order_items = self.order_items.where("order_items.item_id IN (?)", (item_ids))
    order_items.map do |order_item|
      [order_item, Item.find_by(id: order_item.item_id), order_item.quantity]
    end
  end
end
