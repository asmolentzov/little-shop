require 'rails_helper'

describe 'As a registered merchant' do
  describe 'when I want to edit an item' do
    before(:each) do
      @merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
      
      @item = create(:item, user: @merchant)
    end
    it 'I can visit a page to edit an item' do      
      visit dashboard_items_path
      
      within "#item-#{@item.id}" do
        click_on 'Edit this item'
      end
      
      expect(current_path).to eq(edit_dashboard_item_path(@item))
      expect(current_path).to eq("/dashboard/items/#{@item.id}/edit")
      
      expect(find_field("item[name]").value).to eq(@item.name)
      expect(find_field("item[description]").value).to eq(@item.description)
      expect(find_field("item[image_link]").value).to eq(@item.image_link)
      expect(find_field("item[current_price]").value).to eq(@item.current_price.to_s)
      expect(find_field("item[inventory]").value).to eq(@item.inventory.to_s)
    end
    
    it 'lets me edit any information' do
      visit edit_dashboard_item_path(@item)
      
      new_name = "New Name!"
      
      fill_in :item_name, with: new_name
      click_button 'Update Item' 
      
      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("Item ##{@item.id} has been updated")
      
      within "#item-#{@item.id}" do
        expect(page).to have_content(new_name)
        expect(page).to have_content(@item.description)
        expect(page).to have_css("img[src='#{@item.image_link}']")
        expect(page).to have_content(@item.current_price)
        expect(page).to have_content(@item.inventory)
        expect(page).to have_link("Disable this item")
      end
      expect(Item.find(@item.id).enabled).to eq(true)
    end
    
    it 'lets me edit all information' do
      visit edit_dashboard_item_path(@item)
      
      new_name = "New Name!"
      new_desc = "Cool"
      new_img = "https://picsum.photos/200/300"
      new_price = 400
      new_inventory = 12
      
      fill_in :item_name, with: new_name
      fill_in :item_description, with: new_desc
      fill_in :item_image_link, with: new_img
      fill_in :item_current_price, with: new_price
      fill_in :item_inventory, with: new_inventory
      click_button 'Update Item' 
      
      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("Item ##{@item.id} has been updated")
      
      within "#item-#{@item.id}" do
        expect(page).to have_content(new_name)
        expect(page).to have_content(new_desc)
        expect(page).to have_css("img[src='#{new_img}']")
        expect(page).to have_content(new_price)
        expect(page).to have_content(new_inventory)
        expect(page).to have_link("Disable this item")
      end
      expect(Item.find(@item.id).enabled).to eq(true)
    end
    
    it 'will have certain restrictions for editing information' do
      visit edit_dashboard_item_path(@item)
      
      
    end
  end
end