class Item < ApplicationRecord
  validates_presence_of :name, :image_link, :inventory, :description,
                        :current_price, :enabled, :user_id

  belongs_to :user

  has_many :order_items
  has_many :orders, through: :order_items

  def avg_fulfill_time
    self.order_items.where(fulfilled: true).average("order_items.updated_at - order_items.created_at").to_i
  end
end
