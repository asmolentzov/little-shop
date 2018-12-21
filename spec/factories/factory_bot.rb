FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@aol.com" }
    sequence(:password) { |n| "password-#{n}" }
    sequence(:name) { |n| "User #{n}" }
    sequence(:street) { |n| "Address #{n}" }
    sequence(:city) { |n| "city #{n}" }
    sequence(:state) { |n| "state #{n}" }
    sequence(:zip) { |n| "zip #{n}" }
    
    factory :merchant do
      sequence(:email) { |n| "merchant_#{n}@aol.com" }
      sequence(:name) { |n| "Merchant #{n}" }
      role { 1 }
    end
    
    factory :admin do
      sequence(:email) { |n| "admin_#{n}@aol.com" }
      sequence(:name) { |n| "Admin #{n}" }
      role { 2 }
    end
  end
  
  factory :item do
    sequence(:name) { |n| "Item #{n}" }
    sequence(:image_link) { |n| "https://picsum.photos/#{n}" }
    sequence(:inventory) { |n| n }
    sequence(:description) { |n| "A lovely example of an item#{n}" }
    sequence(:current_price) { |n| n * 100 }
    enabled { true }
    association :user, factory: :merchant
  end
  
  factory :order do
    
  end
end