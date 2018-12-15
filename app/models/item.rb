class Item < ApplicationRecord
  validates_presence_of :name, :image_link, :inventory, :description,
                        :current_price, :enabled, :user_id

  belongs_to :user

  has_many :order_items
  has_many :orders, through: :order_items
end
