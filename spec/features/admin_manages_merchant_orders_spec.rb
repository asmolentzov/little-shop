require 'rails_helper'

describe 'As an admin user' do
  before(:each) do
    @merchant = create(:merchant)
    @item = create(:item, user: @merchant)
    
    @admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end
  describe 'when I visit a merchant profile page' do
    it 'can click on the items link and see what the merchant sees' do
      item_2 = create(:item, user: @merchant)
      item_3 = create(:disabled_item, user: @merchant)
      
      visit admin_merchant_path(@merchant)
      
      click_link 'My Items'
      
      expect(current_path).to eq(admin_merchant_items_path(@merchant))
      expect(page).to have_link(@item.name)
      expect(page).to have_link(item_2.name)
      expect(page).to have_link(item_3.name)
      expect(page).to have_link('Add New Item')
      
      within "#item-#{@item.id}" do
        expect(page).to have_link 'Edit this item'
        expect(page).to have_link 'Delete this item'
        expect(page).to have_link 'Disable this item'
      end
      
      within "#item-#{item_3.id}" do
        expect(page).to have_link 'Enable this item'
      end
    end
  end
  
  describe 'when I visit the admin merchant items page' do
    it 'allows me to add a new item' do
      visit admin_merchant_items_path(@merchant)
      
      click_on('Add New Item')

      expect(current_path).to eq("admin/merchants/#{@merchant.id}/items/new")
      expect(current_path).to eq(new_admin_item_path)

      fill_in :item_name, with: 'item_1'
      fill_in :item_description, with: 'this is a great item_1'
      fill_in :item_image_link, with: 'https://picsum.photos/200'
      fill_in :item_current_price, with: 3000
      fill_in :item_inventory, with: 1
      click_on('Create Item')

      expect(current_path).to eq(admin_merchant_items_path(@merchant))
      expect(page).to have_content('Your new item has been created')

      item_1 = Item.all.first

      within("#item-#{item_1.id}") do
        expect(page).to have_content(item_1.id)
        expect(page).to have_content(item_1.name)
        expect(page).to have_css("img[src*='#{item_1.image_link}']")
        expect(page).to_not have_css("img[src*='https://picsum.photos/200/300?image=0']")
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