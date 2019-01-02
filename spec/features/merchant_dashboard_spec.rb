require 'rails_helper'

describe 'as a merchant' do
  context 'when i visit my dashboard' do
    it 'sees a link to my items' do
      merchant_1 = User.create(name: 'Argellica Jones', street: '9 Slider Ave', city: 'Smithtown', state: 'PA',
        zip: '76390', email: 'Jonesey@aol.com', password: '123456789', role: 1, enabled: true)
      merchant_2 = User.create(name: 'Holden Butts', street: '5607 E County Rd.', city: 'Smithtown', state: 'PA',
          zip: '21154', email: 'Butts1045@aol.com', password: 'abc123', role: 1, enabled: true)

      item_1 = Item.create(name: 'Highscreen 386DX', user: merchant_1, inventory: 1,
          current_price: 347500, enabled: true, image_link: 'highscreen-386dx.jpg', description: 'Now with 512K RAM!')
      item_2 = Item.create(name: 'Apple Macintosh IIC', user: merchant_1, inventory: 2,
          current_price: 224500, enabled: true, image_link: 'apple-maciic.jpg', description: 'Awesome Speed and Power in a Mac')
      item_3 = Item.create(name: 'Timex-Sinclair 1000', user: merchant_2 , inventory: 1,
          current_price: 370000, enabled: true, image_link: 'timex-sinclair1000.jpg', description: 'Takes a Licking and Keeps on Ticking')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

      visit '/dashboard'

      expect(page).to have_link("My Items")
      expect(page).to_not have_link("Edit Profile")


      click_on "My Items"

      expect(current_path).to eq("/dashboard/items")

      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_1.current_price)
      expect(page).to have_content(item_1.description)
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_2.current_price)
      expect(page).to have_content(item_2.description)
      expect(page).to_not have_content(item_3.name)
      expect(page).to_not have_content(item_3.current_price)
      expect(page).to_not have_content(item_3.description)

    end
    it 'shows merchant statistics' do
      merchant_1 = create(:merchant)
      #All items belong to merchant_1. Total inventory = 300
      item_1 = create(:item, inventory: 1, user: merchant_1)
      item_2 = create(:item, inventory: 2, user: merchant_1)
      item_3 = create(:item, inventory: 3, user: merchant_1)
      item_4 = create(:item, inventory: 4, user: merchant_1)
      item_5 = create(:item, inventory: 50, user: merchant_1)
      item_6 = create(:item, inventory: 60, user: merchant_1)
      item_7 = create(:item, inventory: 70, user: merchant_1)
      item_8 = create(:item, inventory: 110, user: merchant_1)
      #Users from 6 states & 6 cities. Identical city names from two states.
      user_1 = create(:user, city: 'Manhattan', state: 'KS')
      user_2 = create(:user, city: 'Manhattan', state: 'KS')
      user_3 = create(:user, city: 'Manhattan', state: 'NY')
      user_4 = create(:user, city: 'Buttermilk', state: 'KS')
      user_5 = create(:user, city: 'Brigham', state: 'UT')
      user_6 = create(:user, city: 'Austin', state: 'NV')
      user_7 = create(:user, city: 'Smackover', state: 'AK')

      #User_1 orders - Manhattan, KS -- 2nd shipped to city, 1st state
      order_1 = create(:fulfilled_order, user: user_1)
        create(:fulfilled_order_item, order: order_1, item: item_1, quantity: 1, order_price: 100)
        create(:fulfilled_order_item, order: order_1, item: item_2, quantity: 2, order_price: 200)

      #User_2 orders - Manhattan, KS -- ANOTHER Manhattan, KS
      order_2 = create(:fulfilled_order, user: user_2)
        create(:fulfilled_order_item, order: order_2, item: item_1, quantity: 1, order_price: 100)
        create(:fulfilled_order_item, order: order_2, item: item_2, quantity: 2, order_price: 300)
      order_3 = create(:fulfilled_order, user: user_2)
        create(:fulfilled_order_item, order: order_3, item: item_3, quantity: 3, order_price: 300)
      order_4 = create(:fulfilled_order, user: user_2)
        create(:fulfilled_order_item, order: order_4, item: item_4, quantity: 1, order_price: 400)

      #User_3 orders - Manhattan, NY -- Top shipped-to city, 2nd state
      order_5 = create(:fulfilled_order, user: user_3)
        create(:fulfilled_order_item, order: order_5, item: item_1, quantity: 1, order_price: 100)
        create(:fulfilled_order_item, order: order_5, item: item_2, quantity: 2, order_price: 200)
      order_6 = create(:fulfilled_order, user: user_3)
        create(:fulfilled_order_item, order: order_6, item: item_3, quantity: 3, order_price: 300)
      order_7 = create(:fulfilled_order, user: user_3)
        create(:fulfilled_order_item, order: order_7, item: item_4, quantity: 1, order_price: 400)
      order_8 = create(:fulfilled_order, user: user_3)
        create(:fulfilled_order_item, order: order_8, item: item_5, quantity: 2, order_price: 500)
      order_9 = create(:fulfilled_order, user: user_3)
        create(:fulfilled_order_item, order: order_9, item: item_6, quantity: 3, order_price: 600)

      #User_4 orders - Buttermilk, KS -- 3rd shipped to city
      order_10 = create(:fulfilled_order, user: user_4)
        create(:fulfilled_order_item, order: order_10, item: item_1, quantity: 1, order_price: 100)
        create(:fulfilled_order_item, order: order_10, item: item_2, quantity: 2, order_price: 200)
      order_11 = create(:fulfilled_order, user: user_4)
        create(:fulfilled_order_item, order: order_11, item: item_3, quantity: 2, order_price: 300)
      order_12 = create(:fulfilled_order, user: user_4)
        create(:fulfilled_order_item, order: order_12, item: item_4, quantity: 1, order_price: 400)

      #User_5 orders - Brigham, UT
      order_13 = create(:fulfilled_order, user: user_5)
        create(:fulfilled_order_item, order: order_13, item: item_1, quantity: 1, order_price: 100)
        create(:fulfilled_order_item, order: order_13, item: item_2, quantity: 2, order_price: 200)
        create(:fulfilled_order_item, order: order_13, item: item_3, quantity: 3, order_price: 300)
        create(:fulfilled_order_item, order: order_13, item: item_4, quantity: 1, order_price: 400)
        create(:fulfilled_order_item, order: order_13, item: item_5, quantity: 3, order_price: 550)
        create(:fulfilled_order_item, order: order_13, item: item_6, quantity: 3, order_price: 650)
        create(:fulfilled_order_item, order: order_13, item: item_7, quantity: 1, order_price: 13467)
        create(:fulfilled_order_item, order: order_13, item: item_8, quantity: 1, order_price: 57500)

      #User_6 orders - Austin, NV -- 3rd shipped-to state
      order_14 = create(:fulfilled_order, user: user_6)
        create(:fulfilled_order_item, order: order_14, item: item_1, quantity: 2, order_price: 100)
        create(:fulfilled_order_item, order: order_14, item: item_2, quantity: 2, order_price: 200)
      order_15 = create(:fulfilled_order, user: user_6)
        create(:fulfilled_order_item, order: order_15, item: item_7, quantity: 3, order_price: 12200)

      #User_7 orders - Smackover, AK
      order_16 = create(:fulfilled_order, user: user_7)
        create(:fulfilled_order_item, order: order_16, item: item_8, quantity: 2, order_price: 57500)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

      visit dashboard_path
      expect(page).to have_content("MERCHANT STATISTICS")

      within "#statistics" do
        expect(page).to have_content("Top 5 items by quantity:\n#{item_2.name} #{item_3.name} #{item_1.name} #{item_6.name} #{item_5.name}")
        expect(page).to have_content("Sold 52 items, which is 17% of your total inventory")
        expect(page).to have_content("Top 3 shipment states:\nKS NY NV")
        expect(page).to have_content("Top 3 shipment cities:\nManhattan, NY Manhattan, KS Buttermilk, KS")
        expect(page).to have_content("User with the most orders: #{user_3.name}")
        expect(page).to have_content("User buying the most items: #{user_5.name}")
        expect(page).to have_content("Three highest spending users:\n#{user_7.name} #{user_5.name} #{user_6.name}")
      end
    end
  end
end
