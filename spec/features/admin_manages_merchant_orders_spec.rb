require 'rails_helper'

describe 'As an admin user' do
  describe 'when I visit a merchant profile page' do
    before(:each) do
      @merchant = create(:merchant)
      @item = create(:item, user: @merchant)
      
      @admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end
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
end