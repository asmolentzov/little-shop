class User < ApplicationRecord
  validates_presence_of :name, :street, :city, :state, :zip,
                        :email, :password, :role, :enabled
  validates :email, uniqueness: {message: 'Email address is already in use'}

  has_many :orders
  has_many :items

  has_secure_password

  enum role: [:default, :merchant, :admin]
end
