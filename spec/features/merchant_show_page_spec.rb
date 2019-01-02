require 'rails_helper'

describe 'as a merchant user' do
  include ActionView::Helpers::NumberHelper
  
  context 'when I visit my dashboard' do
    it 'should show me my profile data, but I cannot edit it' do
      merch = create(:merchant)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merch)

      visit dashboard_path

      expect(page).to have_content(merch.name)
      expect(page).to have_content(merch.street)
      expect(page).to have_content(merch.city)
      expect(page).to have_content(merch.state)
      expect(page).to have_content(merch.zip)
      expect(page).to have_content(merch.email)
      expect(page).to have_link('My Items')
      expect(page).to_not have_link('Edit Profile')
    end
    
    it 'should show me a list of pending orders containing my items' do
      merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      
      # Pending order with one item from the merchant and one not
      order_1 = create(:order)
      item_1 = create(:item, user: merchant)
      create(:unfulfilled_order_item, order: order_1, item: item_1)
      create(:unfulfilled_order_item, order: order_1) 
      
      # Pending order with no items from merchant
      order_2 = create(:order)
      create(:unfulfilled_order_item, order: order_2)
      
      # Pending order with 2 items from merchant
      order_3 = create(:order)
      item_2 = create(:item, user: merchant)
      item_4 = create(:item, user: merchant)
      create(:fulfilled_order_item, order: order_3, item: item_2)
      create(:fulfilled_order_item, order: order_3, item: item_4)
      
      # Fulfilled order item with item from merchant
      order_4 = create(:fulfilled_order)
      item_3 = create(:item, user: merchant)
      create(:fulfilled_order_item, order: order_4, item: item_3)     
      
      visit dashboard_path
      
      within "#pending-order-#{order_1.id}" do
        expect(page).to have_link("Order ##{order_1.id}")
        expect(page).to have_content("Placed on: #{order_1.created_at.strftime('%B %d, %Y')}")
        
        expect(page).to have_content("My items in order: #{order_1.merchant_items_quantity(merchant.id)}")
        expect(page).to have_content("My items value: #{number_to_currency(order_1.merchant_items_value(merchant.id) / 100)}")
        click_link "Order ##{order_1.id}"
      end
      
      expect(current_path).to eq(dashboard_order_path(order_1))
      expect(current_path).to eq("/dashboard/orders/#{order_1.id}")
      
      visit dashboard_path
      
      expect(page).to_not have_css("#pending-order-#{order_2.id}")
      expect(page).to_not have_css("#pending-order-#{order_4.id}")
      
      within "#pending-order-#{order_3.id}" do
        expect(page).to have_link("Order ##{order_3.id}")
        expect(page).to have_content("Placed on: #{order_3.created_at.strftime('%B %d, %Y')}")
        
        expect(page).to have_content("My items in order: #{order_3.merchant_items_quantity(merchant.id)}")
        expect(page).to have_content("My items value: #{number_to_currency(order_3.merchant_items_value(merchant.id) / 100)}")
        click_link "Order ##{order_3.id}"
      end
      
      expect(current_path).to eq(dashboard_order_path(order_3))
      
      
    end
  end
end
