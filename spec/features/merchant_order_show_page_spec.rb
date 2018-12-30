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
    it 'should show me a red error message if I do not have enough inventory' do
      merch = create(:merchant)
      user = create(:user)
      item_1 = create(:item, inventory: 3, user: merch)
      item_2 = create(:item, inventory: 3, user: merch)
      order_1 = create(:order, user: user)
      order_item_1 = create(:unfulfilled_order_item, item: item_1, quantity: 3, order: order_1)
      order_item_2 = create(:unfulfilled_order_item, item: item_2, quantity: 4, order: order_1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merch)

      visit dashboard_orders_path(order_1)
      
      within("#item-#{item_2.id}") do
        expect(page).to_not have_link('Fulfill')
        expect(page).to have_content('Cannot Fulfill!')
        expect(page).to have_css('p.cannot_fulfill')
      end
      within("#item-#{item_1.id}") do
        expect(page).to_not have_content('Cannot Fulfill!')
        expect(page).to_not have_css('p.cannot_fulfill')
      end
    end
    it 'should show me a fulfill button if I have enough inventory, and a red error message if I do not' do
      merch = create(:merchant)
      user = create(:user)
      item_1 = create(:item, inventory: 6, user: merch)
      item_2 = create(:item, inventory: 3, user: merch)
      order_1 = create(:order, user: user)
      order_item_1 = create(:unfulfilled_order_item, item: item_1, quantity: 3, order: order_1)
      order_item_2 = create(:unfulfilled_order_item, item: item_2, quantity: 4, order: order_1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merch)

      visit dashboard_orders_path(order_1)

      within("#item-#{item_1.id}") do
        expect(page).to have_link('Fulfill')
        expect(page).to_not have_content('Cannot Fulfill!')
        expect(page).to_not have_css('p.cannot_fulfill')
        click_on('Fulfill')
      end

      expect(page).to have_content("Order item ##{order_item_1.id} has been fulfilled!")

      merchant = User.find(merch.id)

      expect(merchant.items.where(id: item_1.id).first.inventory).to be(3)

      within("#item-#{item_1.id}") do
        expect(page).to_not have_link('Fulfill')
        expect(page).to have_content('Already Fulfilled!')
        expect(page).to_not have_content('Cannot Fulfill!')
        expect(page).to_not have_css('p.cannot_fulfill')
      end

      within("#item-#{item_2.id}") do
        expect(page).to_not have_link('Fulfill')
        expect(page).to have_content('Cannot Fulfill!')
        expect(page).to have_css('p.cannot_fulfill')
      end
    end
  end
end
