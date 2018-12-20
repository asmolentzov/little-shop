require 'rails_helper'
include ActionView::Helpers::TextHelper



RSpec.describe "When a user visitor visits their cart show page with items in cart" do
  it "displays the items in their cart" do
    user_1 = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
    zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 0, enabled: true)
    #Merchant User
    merchant = User.create(name: 'User Five', street: 'Street Five', city: 'City Five', state: 'State5',
    zip: 'ZIP5', email: 'email5@aol.com', password: 'password5', role: 1, enabled: true)
    #Item belonging to Mercant
    item_1 = Item.create(name: 'IBM PCXT 5160', user: merchant, inventory: 3,
    current_price: 399500, enabled: true, image_link: 'ibm-pcxt5160.jpg', description: 'Yesterday in personal computing technology')
    item_2 = Item.create(name: 'IBM PCXT 5161', user: merchant, inventory: 3,
    current_price: 400000, enabled: true, image_link: 'ibm-pcxt5160.jpg', description: 'The latest in personal computing technology')

    cart = Cart.new()

    cart.add_item(item_1)
    cart.add_item(item_2)
    cart.add_item(item_2)
    subtotal_1 = item_1.price * cart.contents[item_1.id.to_s]
    subtotal_2 = item_2.price * cart.contents[item_2.id.to_s]
    quantity_1 = cart.contents[item_1.id.to_s]
    quantity_2 = cart.contents[item_2.id.to_s]

    visit cart_path

    within "#item-#{item_1.id}" do
      expect(page).to have_content(item_1.name)
      expect(page).to have_css("img[src*='#{item_1.image_link}'")
      expect(page).to have_content(item_1.merchant.name)
      expect(page).to have_content(item_1.price)
      expect(page).to have_content("Quantity: #{quantity_1}")
      expect(page).to have_content("Subtotal: #{number_to_currency(subtotal_1)}")

      expect(page).to_not have_content(item_2.name)
    end
    within "#item-#{item_2.id}" do
      expect(page).to have_content(item_2.name)
      expect(page).to have_css("img[src*='#{item_2.image_link}'")
      expect(page).to have_content(item_2.merchant.name)
      expect(page).to have_content(item_2.price)
      expect(page).to have_content("Quantity: #{quantity_2}")
      expect(page).to have_content("Subtotal: #{number_to_currency(subtotal_2)}")

      expect(page).to_not have_content(item_1.name)
    end

    expect(page).to have_content("Grand total: #{number_to_currency(subtotal_1 + subtotal_2)}")

  end
end
