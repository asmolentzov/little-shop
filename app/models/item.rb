class Item < ApplicationRecord
  validates_presence_of :name, :image_link, :description,
                        :current_price, :user_id
  validates :enabled, inclusion: {in: [true, false]}
  validates :inventory, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :current_price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  belongs_to :user

  has_many :order_items
  has_many :orders, through: :order_items

  before_validation :set_default_image

  def avg_fulfill_time
    self.order_items.where(fulfilled: true)
        .average("order_items.updated_at - order_items.created_at")
        .to_i
  end

  def self.five_popular(var)
    select("items.*, sum(order_items.id) AS total_orders")
          .joins(:order_items)
          .where("order_items.fulfilled = ?", true)
          .group(:id)
          .order("total_orders #{var}")
          .limit(5)
  end

  def self.enabled_items
    Item.where(enabled: true)
  end

  def set_default_image
    if self.image_link == ""
      self.image_link = "https://picsum.photos/200/300?image=0"
    else
      self.image_link
    end
  end
end
