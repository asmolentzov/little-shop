require 'rails_helper'

describe 'as a visitor' do
  context 'when I visit /merchants' do
    it 'should see all active merchants and their info' do
      user_1 = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
        zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 1)
      user_2 = User.create(name: 'User Two', street: 'Street Two', city: 'City Two', state: 'State2',
        zip: 'ZIP2', email: 'email2@aol.com', password: 'password2', role: 1, enabled: false, created_at: 2.days.ago)
      user_3 = User.create(name: 'User Three', street: 'Street Three', city: 'City Three', state: 'State3',
        zip: 'ZIP3', email: 'email3@aol.com', password: 'password3', role: 1)
      user_4 = User.create(name: 'User Four', street: 'Street Four', city: 'City Four', state: 'State4',
        zip: 'ZIP4', email: 'email4@aol.com', password: 'password4', created_at: 4.days.ago)
        
      visit merchants_path

      expect(page).to have_content(user_1.name)
      expect(page).to have_content(user_1.city)
      expect(page).to have_content(user_1.state)
      expect(page).to have_content(user_1.created_at)
      expect(page).to_not have_content(user_2.name)
      expect(page).to_not have_content(user_2.city)
      expect(page).to_not have_content(user_2.state)
      expect(page).to_not have_content(user_2.created_at)
      expect(page).to have_content(user_3.name)
      expect(page).to have_content(user_3.city)
      expect(page).to have_content(user_3.state)
      expect(page).to have_content(user_3.created_at)
    end
    
    it 'should show an area with statistics showing top merchants by price and quantity' do
      merchant_1 = create(:merchant)
      4.times do
        create(:fulfilled_order_item, item: create(:item, user: merchant_1),  order_price: 500)
      end
      
      merchant_2 = create(:merchant)
      create(:fulfilled_order_item, item: create(:item, user: merchant_2), order_price: 4000)
      create(:fulfilled_order_item, item: create(:item, user: merchant_2), order_price: 5000)
      
      merchant_3 = create(:merchant)
      
      merchant_4 = create(:merchant)
      3.times do
        create(:fulfilled_order_item, item: create(:item, user: merchant_4),  order_price: 100)
      end
      create(:unfulfilled_order_item, item: create(:item, user: merchant_4))
      create(:unfulfilled_order_item, item: create(:item, user: merchant_4))
      
      merchant_5 = create(:merchant)
      create(:fulfilled_order_item, item: create(:item, user: merchant_5), order_price: 10000)
      
      top_merchants_quantity = "\n#{merchant_1.name}\n#{merchant_4.name}\n#{merchant_2.name}"
      top_merchants_price = "\n#{merchant_5.name}\n#{merchant_2.name}\n#{merchant_1.name}"
      
      visit merchants_path
      
      within "#statistics" do
        expect(page).to have_content("Top Merchants by Quantity:#{top_merchants_quantity}")
        expect(page).to have_content("Top Merchants by Price:#{top_merchants_price}")
        expect(page).to_not have_content(merchant_3.name)
      end
    end
    it 'should show stats about top and bottom three merchants in terms of fulfillment time' do
      merchant_1 = create(:merchant)
      create(:fulfilled_order_item, item: create(:item, user: merchant_1), created_at: 1.day.ago)
      create(:fulfilled_order_item, item: create(:item, user: merchant_1), created_at: 1.hour.ago)
      
      merchant_2 = create(:merchant)
      create(:fulfilled_order_item, item: create(:item, user: merchant_2), created_at: 2.hours.ago)
      create(:fulfilled_order_item, item: create(:item, user: merchant_2), created_at: 2.hours.ago)
      
      merchant_3 = create(:merchant)
      create(:fulfilled_order_item, item: create(:item, user: merchant_3), created_at: 2.days.ago)
      create(:fulfilled_order_item, item: create(:item, user: merchant_3), created_at: 3.days.ago)
      create(:fulfilled_order_item, item: create(:item, user: merchant_3), created_at: 3.days.ago)
      
      merchant_4 = create(:merchant)
      create(:fulfilled_order_item, item: create(:item, user: merchant_4), created_at: 4.days.ago)
      
      fastest_merchants = "\n#{merchant_2.name}\n#{merchant_1.name}\n#{merchant_3.name}"
      slowest_merchants = "\n#{merchant_4.name}\n#{merchant_3.name}\n#{merchant_1.name}"
      
      visit merchants_path
      
      within "#statistics" do
        expect(page).to have_content("Merchants with Fastest Fulfillment Times:#{fastest_merchants}")
        expect(page).to have_content("Merchants with Slowest Fulfillment Times:#{slowest_merchants}")
        
      end
      
    end
  end
end
