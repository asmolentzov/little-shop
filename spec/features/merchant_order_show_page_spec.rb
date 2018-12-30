require 'rails_helper'

describe 'As a merchant' do
  include ActionView::Helpers::NumberHelper
  
  context 'when I visit an order show page' do
    it 'shows information about the customer and my items that are being purchased' do
      merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      item_1 = create(:item, user: merchant)
      item_2 = create(:item, user: merchant)
      
      item_3 = create(:item)
      item_4 = create(:item, user: merchant)
      
      customer = create(:user)
      order = create(:order, user: customer)
      create(:fulfilled_order_item, order: order, item: item_1)
      create(:unfulfilled_order_item, order: order, item: item_2)
      create(:fulfilled_order_item, order: order, item: item_3)
      
      visit dashboard_orders_path(order)
      
      within "#customer-info" do
        expect(page).to have_content("Name: #{customer.name}")
        expect(page).to have_content("Address: #{customer.street} #{customer.city} #{customer.state} #{customer.zip}")
      end
      
      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_2.name)
      expect(page).to_not have_content(item_3.name)
      expect(page).to_not have_content(item_4.name)
      expect(page).to_not have_css("#item-#{item_3.id}")
      expect(page).to_not have_css("#item-#{item_4.id}")
      expect(page).to have_css("#item-#{item_1.id}")
      expect(page).to have_css("#item-#{item_2.id}")
    end
    
    it 'should should information about my items on the page' do
      merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      item_1 = create(:item, user: merchant)
      item_2 = create(:item, user: merchant)
      
      order = create(:order)
      oi_1 = create(:fulfilled_order_item, order: order, item: item_1)
      oi_2 = create(:unfulfilled_order_item, order: order, item: item_2)
      
      visit dashboard_orders_path(order)
      
      within "#item-#{item_1.id}" do
        expect(page).to have_link("#{item_1.name}")
        expect(page).to have_css("img[src='#{item_1.image_link}']")
        expect(page).to have_content("Price: #{number_to_currency(item_1.current_price / 100)}")
        expect(page).to have_content("Quantity: #{oi_1.quantity}")
        click_link "#{item_1.name}"
      end
      expect(current_path).to eq(item_path(item_1))
      
      visit dashboard_orders_path(order)
      
      within "#item-#{item_2.id}" do
        expect(page).to have_link("#{item_2.name}")
        expect(page).to have_css("img[src='#{item_2.image_link}']")
        expect(page).to have_content("Price: #{number_to_currency(item_2.current_price / 100)}")
        expect(page).to have_content("Quantity: #{oi_2.quantity}")
        click_link "#{item_2.name}"
      end
      expect(current_path).to eq(item_path(item_2))
    end
    
    it 'should not let a non-merchant see the above info' do
      merchant = create(:merchant)
      item_1 = create(:item, user: merchant)
      item_2 = create(:item, user: merchant)
      order = create(:order)
      oi_1 = create(:fulfilled_order_item, order: order, item: item_1)
      oi_2 = create(:unfulfilled_order_item, order: order, item: item_2)
      
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      visit dashboard_orders_path(order)
      
      expect(page.status_code).to eq(404)
      expect(page).to_not have_content(item_1.name)
      expect(page).to_not have_content(item_2.name)
    end
  end
end