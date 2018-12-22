class User < ApplicationRecord
  validates_presence_of :name, :street, :city, :state, :zip,
                        :email, :role
  validates_presence_of :password, if: :password
  validates :enabled, inclusion: {in: [true, false]}
  validates :email, uniqueness: true

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
    .map(&:state)
  end

  def enabled_toggle
    enabled ? self.update(enabled: false) : self.update(enabled: true)
  end
end
