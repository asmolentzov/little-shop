class Order < ApplicationRecord
  validates_presence_of :status, :user_id

  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  enum status: [:pending, :fulfilled, :cancelled]
end
