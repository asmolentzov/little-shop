require 'rails_helper'

describe 'as a merchant user' do
  context "when I visit one of my order's show pages" do
    it 'should show me a fulfill button if I have enough inventory, and a red error message if I do not' do
      merch = create(:merchant)
      user = create(:user)
      item_1 = create(:item, inventory: 3)
      item_2 = create(:item, inventory: 3)
      item_3 = create(:item, inventory: 3)
      order_1 = create(:order, user: user)
      order_item_1 = create(:unfulfilled_order_item, item: item_1, quantity: 3, order: order_1)
      order_item_2 = create(:unfulfilled_order_item, item: item_2, quantity: 4, order: order_1)
      order_item_3 = create(:unfulfilled_order_item, item: item_3, quantity: 1, order: order_1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merch)

      visit dashboard_path

      expect(page).to have_link("Order##{Order_1.id}")
      click_on("Order##{Order_1.id}")

      
    end
  end
end
