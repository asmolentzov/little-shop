require 'rails_helper'

describe 'As a merchant' do
  context 'when I visit an order show page' do
    it 'shows information about the customer and my items that are being purchased' do
      merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      item_1 = create(:item, user: merchant)
      item_2 = create(:item, user: merchant)
      
      item_3 = create(:item)
      
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
      expect(page).to_not have_css("#item-#{item_3.id}")
      expect(page).to have_css("#item-#{item_1.id}")
      expect(page).to have_css("#item-#{item_2.id}")
    end
  end
end