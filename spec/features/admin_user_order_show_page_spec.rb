require 'rails_helper'

describe 'As an admin user' do
  describe  'when I visit a default users order show page' do
    it 'sees the same order information a user would' do
      user_1 = create(:user)
      order_1 = create(:order, user: user_1)
      admin = create(:admin)

      order_item_1 = create(:fulfilled_order_item, order: order_1, quantity: 1, order_price: 100)
      order_item_2 = create(:fulfilled_order_item, order: order_1, quantity: 2, order_price: 200)
      order_item_3 = create(:fulfilled_order_item, order: order_1, quantity: 3, order_price: 300)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_order_path(order_1)

      expect(current_path).to eq("/admin/orders/#{order_1.id}")

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
        expect(page).to have_content("Subtotal: $1.00")
      end
      within "#order-item-#{order_item_2.id}" do
        expect(page).to have_content("Item: #{order_item_2.item.name}")
        expect(page).to have_content("Description: #{order_item_2.item.description}")
        expect(page).to have_css("img[src*='#{order_item_2.item.image_link}']")
        expect(page).to have_content("Quantity: #{order_item_2.quantity}")
        expect(page).to have_content("Order Price: #{order_item_2.order_price}")
        expect(page).to have_content("Subtotal: $4.00")
      end
      within "#order-item-#{order_item_3.id}" do
        expect(page).to have_content("Item: #{order_item_3.item.name}")
        expect(page).to have_content("Description: #{order_item_3.item.description}")
        expect(page).to have_css("img[src*='#{order_item_3.item.image_link}']")
        expect(page).to have_content("Quantity: #{order_item_3.quantity}")
        expect(page).to have_content("Order Price: #{order_item_3.order_price}")
        expect(page).to have_content("Subtotal: $9.00")
      end

      expect(page).to have_content("Total items in order: 6")
      expect(page).to have_content("Grand total: $14.00")

    end

    it 'can cancel an order' do
      merch = create(:merchant)
      admin = create(:admin)
      user_1 = create(:user)

      order_1 = create(:order, user: user_1)

      item_1 = create(:item, inventory: 10, user: merch)
      item_2 = create(:item, inventory: 10, user: merch)
      item_3 = create(:item, inventory: 10, user: merch)


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      order_item_1 = create(:fulfilled_order_item, order: order_1, item: item_1,  quantity: 1, order_price: 100)
      order_item_2 = create(:fulfilled_order_item, order: order_1, item: item_2, quantity: 2, order_price: 200)
      order_item_3 = create(:fulfilled_order_item, order: order_1, item: item_3,  quantity: 3, order_price: 300)


      visit admin_order_path(order_1)

      expect(page).to have_link("Cancel Order")

      click_on "Cancel Order"

      expect(current_path).to eq(admin_user_path(user_1))
      expect(page).to have_content("Your order has been cancelled")

      within "#order-#{order_1.id}" do
        expect(page).to have_content("Status: cancelled")
        order_1.order_items.each do |item|
          expect(item.fulfilled).to eq(false)
          expect(Item.find(item.item_id).inventory).to eq(10)
        end
      end
    end
  end
end
