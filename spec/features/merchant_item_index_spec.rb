require 'rails_helper'

describe 'as a merchant user' do
  context 'when I visit /dashboard/items' do
    it 'should see a link to add an item, and I see each item I have, along with information for each item' do
      merch1 = create(:merchant)
      merch2 = create(:merchant)
      item_1 = create(:item, user: merch1)
      item_2 = create(:item, user: merch1)
      item_3 = create(:item, user: merch2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merch1)

      visit '/dashboard/items'

      within("#item-#{item_1.id}") do
        expect(page).to have_content(item_1.id)
        expect(page).to have_content(item_1.name)
        expect(page).to have_css("img[src*='#{item_1.image_link}']")
        expect(page).to have_content(item_1.current_price)
        expect(page).to have_content(item_1.inventory)
        expect(page).to have_link('Edit this item')
        expect(page).to have_link('Disable this item')
        expect(page).to_not have_link('Enable this item')
      end

      within("#item-#{item_2.id}") do
        expect(page).to have_content(item_2.id)
        expect(page).to have_content(item_2.name)
        expect(page).to have_css("img[src*='#{item_2.image_link}']")
        expect(page).to have_content(item_2.current_price)
        expect(page).to have_content(item_2.inventory)
        expect(page).to have_link('Edit this item')
        expect(page).to have_link('Disable this item')
        expect(page).to_not have_link('Enable this item')
      end

      expect(page).to_not have_content(item_3.id)
      expect(page).to_not have_content(item_3.name)
      expect(page).to_not have_css("img[src*='#{item_3.image_link}']")
      expect(page).to_not have_content(item_3.current_price)
    end
    it 'should see a link to delete the item if no user has ordered the item' do
      merch = create(:merchant)
      item_1 = create(:item, user: merch)
      fulfilled_1 = create(:fulfilled_order_item, item: item_1)
      item_2 = create(:item, user: merch)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merch)

      visit '/dashboard/items'

      within("#item-#{item_1.id}") do
        expect(page).to have_content(item_1.id)
        expect(page).to have_content(item_1.name)
        expect(page).to have_css("img[src*='#{item_1.image_link}']")
        expect(page).to have_content(item_1.current_price)
        expect(page).to have_content(item_1.inventory)
        expect(page).to have_link('Edit this item')
        expect(page).to have_link('Disable this item')
        expect(page).to_not have_link('Delete this item')
        expect(page).to_not have_link('Enable this item')
      end

      within("#item-#{item_2.id}") do
        expect(page).to have_content(item_2.id)
        expect(page).to have_content(item_2.name)
        expect(page).to have_css("img[src*='#{item_2.image_link}']")
        expect(page).to have_content(item_2.current_price)
        expect(page).to have_content(item_2.inventory)
        expect(page).to have_link('Edit this item')
        expect(page).to have_link('Disable this item')
        expect(page).to have_link('Delete this item')
        expect(page).to_not have_link('Enable this item')
      end
    end
    
    it 'should allow me to delete items' do
      merchant = create(:merchant)
      visit login_path
      fill_in :email, with: merchant.email
      fill_in :password, with: merchant.password
      click_button 'Log In'
      
      item_1 = create(:item, user: merchant)
      item_2 = create(:item, user: merchant)
      item_3 = create(:item, user: merchant)
      
      visit dashboard_items_path
      
      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_3.name)
      within "#item-#{item_1.id}" do
        click_on 'Delete this item' 
      end
      
      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("Item ##{item_1.id} has been deleted")
      expect(page).to_not have_content(item_1.name)
      expect(page).to_not have_content(item_1.description)
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_3.name)
    end
  end
end
