require 'rails_helper'

describe 'as a merchant user' do
  context 'when I click on the add new item link' do
    it 'should see a link to add a new item. when I click it, I am taken to a new item page with a form where I can create a new item' do
      merch = create(:merchant)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merch)

      visit dashboard_items_path
      expect(page).to have_link('Add New Item')
      click_on('Add New Item')

      expect(current_path).to eq('/dashboard/items/new')

      fill_in :item_name, with: 'item_1'
      fill_in :item_description, with: 'this is a great item_1'
      fill_in :item_image_link, with: 'https://picsum.photos/200'
      fill_in :item_current_price, with: 3000
      fill_in :item_inventory, with: 1
      click_on('Create Item')

      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content('Your new item has been created')

      item_1 = Item.all.first

      within("#item-#{item_1.id}") do
        expect(page).to have_content(item_1.id)
        expect(page).to have_content(item_1.name)
        expect(page).to have_css("img[src*='#{item_1.image_link}']")
        expect(page).to have_content(item_1.current_price)
        expect(page).to have_content(item_1.inventory)
        expect(page).to have_link('Edit this item')
        expect(page).to have_link('Disable this item')
        expect(page).to have_link('Delete this item')
        expect(page).to_not have_link('Enable this item')
      end
    end
    it 'should not let me create a new item without required fields filled out' do
      merch = create(:merchant)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merch)

      visit dashboard_items_path

      expect(page).to have_link('Add New Item')

      click_on('Add New Item')

      expect(current_path).to eq('/dashboard/items/new')

      fill_in :item_name, with: 'item_1'
      fill_in :item_description, with: 'this is a great item_1'
      fill_in :item_image_link, with: 'https://picsum.photos/200'
      fill_in :item_inventory, with: 1
      click_on('Create Item')

      expect(current_path).to eq('/dashboard/items/new')
      expect(page).to have_content("Current price can't be blank")
    end
    it 'I can create a new item without an image and a placeholder image will display' do
      merch = create(:merchant)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merch)

      visit dashboard_items_path

      expect(page).to have_link('Add New Item')

      click_on('Add New Item')

      expect(current_path).to eq('/dashboard/items/new')

      fill_in :item_name, with: 'item_1'
      fill_in :item_description, with: 'this is a great item_1'
      fill_in :item_current_price, with: 3000
      fill_in :item_inventory, with: 1
      click_on('Create Item')

      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content('Your new item has been created')

      item_1 = Item.all.first

      within("#item-#{item_1.id}") do
        expect(page).to have_content(item_1.id)
        expect(page).to have_content(item_1.name)
        expect(page).to have_css("img[src*='https://picsum.photos/200/300?image=0']")
        expect(page).to have_content(item_1.current_price)
        expect(page).to have_content(item_1.inventory)
        expect(page).to have_link('Edit this item')
        expect(page).to have_link('Disable this item')
        expect(page).to have_link('Delete this item')
        expect(page).to_not have_link('Enable this item')
      end
    end
  end
end
