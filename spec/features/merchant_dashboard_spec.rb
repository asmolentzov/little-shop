require 'rails_helper'

describe 'as a merchant' do
  include ActionView::Helpers::NumberHelper
  
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

      visit dashboard_path

      expect(page).to have_link("My Items")
      expect(page).to_not have_link("Edit Profile")


      click_on "My Items"

      expect(current_path).to eq("/dashboard/items")
      expect(current_path).to eq(dashboard_items_path)
      
      within "#item-#{item_1.id}" do
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(number_to_currency(item_1.current_price / 100))
        expect(page).to have_content(item_1.description)
      end
      
      within "#item-#{item_2.id}" do
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(number_to_currency(item_2.current_price / 100))
        expect(page).to have_content(item_2.description)
      end

      expect(page).to_not have_content(item_3.name)
      expect(page).to_not have_content(number_to_currency(item_3.current_price / 100))
      expect(page).to_not have_content(item_3.description)
    end
  end
end
