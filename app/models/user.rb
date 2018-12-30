class User < ApplicationRecord
  validates_presence_of :name, :street, :city, :state, :zip,
                        :email, :role
  validates_presence_of :password, if: :password
  validates :enabled, inclusion: {in: [true, false]}
  validates_uniqueness_of :email

  has_many :orders
  has_many :items

  has_secure_password

  enum role: [:default, :merchant, :admin]

  def self.enabled_merchants
    where("role = ? AND enabled = ?", 1, true)
  end

  def self.default_users
    where(role: :default)
  end

  def self.merchants_by_quantity
    joins(items: :order_items)
    .where(enabled: true)
    .where("order_items.fulfilled = ?", true)
    .group(:id)
    .select("users.*, count(order_items.id) AS quantity")
    .order("quantity DESC")
    .limit(3)
  end

  def self.merchants_by_price
    joins(items: :order_items)
    .where(enabled: true)
    .where("order_items.fulfilled = ?", true)
    .group(:id)
    .select("users.*, sum(order_items.order_price) AS total")
    .order("total DESC")
    .limit(3)
  end

  def self.merchants_by_time
    joins(items: :order_items)
    .where(enabled: true)
    .where("order_items.fulfilled = ?", true)
    .group(:id)
    .select("users.*, avg(order_items.updated_at - order_items.created_at) AS average_f_time")
    .order("average_f_time ASC")
  end

  def self.top_states
    joins(:orders)
    .where("orders.status = ?", 1)
    .group(:state)
    .select("users.state, count(orders.id) AS state_count")
    .order("state_count DESC")
    .limit(3)
    .map(&:state)
  end

  def self.top_cities
    joins(:orders)
    .where("orders.status = ?", 1)
    .group(:city)
    .group(:state)
    .select("users.city, users.state, count(orders.id) AS city_count")
    .order("city_count DESC")
    .limit(3)
    .map { |user| [user.city, user.state] }
  end

  ### MERCHANT INSTANCE METHODS ###

  def merchant_pending_orders
    Order.joins(:items)
    .where("items.user_id = ?", self.id)
    .where(status: :pending)
    .group(:id)
  end
  def merchant_top_five_items
    self.items
    .joins(:order_items)
    .group(:id)
    .select("items.*, SUM(order_items.quantity) AS item_count")
    .order("item_count DESC")
    .limit(5)
  end
  def merchant_units_sold
    units = OrderItem.joins(:item)
    .where("items.user_id = ?", self.id)
    .sum(:quantity)
    units ? units : 0
  end
  def merchant_units_inventory
    units = Item.where("items.user_id = ?", self.id)
    .sum(:inventory)
    units ? units : 0
  end
  def merchant_percent_sold
    inventory = merchant_units_inventory
    return 0 if inventory == 0
    ((merchant_units_sold.to_f / inventory).round(2) * 100).to_i
  end
  def merchant_top_states
  end
  def merchant_top_cities
  end
  def merchant_top_order_user
    #Order.joins(order_items: :item)
    #.where("items.user_id = ?", self.id)
    #.group(:user_id)
    #.select("orders.*, COUNT(orders.id) AS orders_placed")
    #.order("orders_placed DESC")
    #.first.user
  end
  def merchant_top_units_user
    User.joins(orders: [order_items: :item])
    .where("items.user_id = ?", self.id)
    .group(:id)
    .select("users.*, SUM(order_items.quantity) AS units_purchased")
    .order("units_purchased DESC")
    .first
  end
  def merchant_highest_spending_users
    User.joins(orders: [order_items: :item])
    .where("items.user_id = ?", self.id)
    .group(:id)
    .select("users.*, SUM(order_items.quantity * order_items.order_cost) AS units_purchased")
    .order("units_purchased DESC")
    .first
  end

end
