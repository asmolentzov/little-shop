class User < ApplicationRecord
  validates_presence_of :name, :street, :city, :state, :zip,
                        :email, :password, :role, :enabled
  validates :email, uniqueness: true

  has_many :orders
  has_many :items

  has_secure_password

  enum role: [:default, :merchant, :admin]

  def self.enabled_merchants
    where("role = ? AND enabled = ?", 1, true)
  end
end
