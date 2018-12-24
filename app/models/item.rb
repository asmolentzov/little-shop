class Item < ApplicationRecord
  validates_presence_of :name, :image_link, :inventory, :description,
                        :current_price, :enabled, :user_id

  belongs_to :user

  has_many :order_items
  has_many :orders, through: :order_items

  def avg_fulfill_time
    self.order_items.where(fulfilled: true).average("order_items.updated_at - order_items.created_at").to_i
  end

  def self.top_five_popular
    select("items.*, sum(order_items.id) AS total_orders")
          .joins(:order_items)
          .where("order_items.fulfilled = ?", true)
          .group(:id).order("total_orders DESC")
          .limit(5)
  end
  def self.bottom_five_popular
    select("items.*, sum(order_items.id) AS total_orders")
          .joins(:order_items)
          .where("order_items.fulfilled = ?", true)
          .group(:id).order("total_orders ASC")
          .limit(5)
  end
end
