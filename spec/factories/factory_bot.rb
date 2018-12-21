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
    
    factory :disabled_item do
      enabled { false }
    end
  end
  
  factory :order do
    status { 'pending' }
    user
    
    factory :fulfilled_order do
      status { 'fulfilled' }
    end
    
    factory :cancelled_order do
      status { 'cancelled' }
    end
  end
  
  factory :order_item do
    order
    item
    sequence(:quantity) { |n| n }
    sequence(:order_price) { |n| n * 100 }
    
    factory :fulfilled_order_item do
      fulfilled { true }
    end
    
    factory :unfulfilled_order_item do
      fulfilled { false }
    end
  end
end