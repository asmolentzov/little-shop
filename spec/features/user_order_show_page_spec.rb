require 'rails_helper'

describe 'USER ORDER SHOW PAGE' do
  context 'As a registered user' do
    it 'shows information about an order, when linked from my profile page' do

      user_1 = create(:user)
      order_1 = create(:order, user: user_1)

      order_item_1 = create(:fulfilled_order_item, order: order_1, quantity: 1, order_price: 100)
      order_item_2 = create(:fulfilled_order_item, order: order_1, quantity: 2, order_price: 200)
      order_item_3 = create(:fulfilled_order_item, order: order_1, quantity: 3, order_price: 300)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit profile_path

      click_link "Order: #{order_1.id}"

      expect(current_path).to eq("/profile/orders/#{order_1.id}")

      expect(page).to have_content("Order: #{order_1.id}")
      expect(page).to have_content("Placed on: #{order_1.created_at}")
      expect(page).to have_content("Last update: #{order_1.updated_at}")
      expect(page).to have_content("Status: #{order_1.status}")

      within "#order-item-#{order_item_1.id}" do
        expect(page).to have_content("Item: #{order_item_1.item.name}")
        expect(page).to have_content("Description: #{order_item_1.item.description}")
        expect(page).to have_css("img[src*='#{order_item_1.item.image_link}']")
        expect(page).to have_content("Quantity: #{order_item_1.quantity}")
        expect(page).to have_content("Order Price: #{order_item_1.order_price}")
        expect(page).to have_content("Subtotal: #{order_item_1.order_price * order_item_1.quantity}")
      end

      expect(page).to have_content("Total items in order: 6")
      expect(page).to have_content("Grand total: $14.00")
    end
  end
end
