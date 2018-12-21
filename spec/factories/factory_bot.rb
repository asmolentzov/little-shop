FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@aol.com" }
    sequence(:password) { |n| "password-#{n}" }
    sequence(:name) { |n| "User #{n}" }
    sequence(:street) { |n| "Address #{n}" }
    sequence(:city) { |n| "city #{n}" }
    sequence(:state) { |n| "state #{n}" }
    sequence(:zip) { |n| "zip #{n}" }
  end
  
  factory :merchant, class: User do
    sequence(:email) { |n| "merchant_#{n}@aol.com" }
    sequence(:password) { |n| "password-#{n}" }
    sequence(:name) { |n| "Merchant #{n}" }
    sequence(:street) { |n| "Address #{n}" }
    sequence(:city) { |n| "city #{n}" }
    sequence(:state) { |n| "state #{n}" }
    sequence(:zip) { |n| "zip #{n}" }
    role { 1 }
  end
  
  factory :admin, class: User do
    sequence(:email) { |n| "admin_#{n}@aol.com" }
    sequence(:password) { |n| "password-#{n}" }
    sequence(:name) { |n| "Admin #{n}" }
    sequence(:street) { |n| "Address #{n}" }
    sequence(:city) { |n| "city #{n}" }
    sequence(:state) { |n| "state #{n}" }
    sequence(:zip) { |n| "zip #{n}" }
    role { 2 }
  end
  
  factory :item do
    sequence(:name) { |n| "Item #{n}" }
    sequence(:image_link) { |n| "#{n}.jpg" }
    sequence(:inventory) { |n| n }
    sequence(:description) { |n| "A lovely example of an item#{n}" }
    sequence(:current_price) { |n| n * 100 }
    enabled { true }
    merchant 
  end
end