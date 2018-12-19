class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates_presence_of :title, :body, :rating

  def self.newest
    Review.order("created_at DESC")
  end

  def self.oldest
    Review.order("created_at ASC")
  end
end
