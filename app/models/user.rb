class User < ApplicationRecord
  validates_presence_of :name, :street, :city, :state, :zip,
                        :email, :password, :role, :enabled

  has_many :orders
  has_many :items
end
