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
      
      fill_in :item_name, with: nil
      click_button 'Update Item'
      
      expect(page).to have_content("Name can't be blank")
      expect(@item.name).to_not eq(nil)
      expect(find_field("item[name]").value).to eq(@item.name)
      expect(find_field("item[description]").value).to eq(@item.description)
      expect(find_field("item[image_link]").value).to eq(@item.image_link)
      expect(find_field("item[current_price]").value).to eq(@item.current_price.to_s)
      expect(find_field("item[inventory]").value).to eq(@item.inventory.to_s)
      
      fill_in :item_description, with: nil
      click_button 'Update Item'
      expect(page).to have_content("Description can't be blank")
      expect(@item.description).to_not eq(nil)
      expect(find_field("item[description]").value).to eq(@item.description)
      
      fill_in :item_current_price, with: nil
      click_button 'Update Item'
      expect(page).to have_content("Current price can't be blank")
      expect(@item.current_price).to_not eq(nil)
      expect(find_field("item[current_price]").value).to eq(@item.current_price.to_s)
      
      fill_in :item_current_price, with: '$10'
      click_button 'Update Item'
      expect(page).to have_content("Current price is not a number")
      expect(@item.current_price).to_not eq('$10')
      expect(find_field("item[current_price]").value).to eq(@item.current_price.to_s)
      
      fill_in :item_current_price, with: -200
      click_button 'Update Item'
      expect(page).to have_content("Current price must be greater than or equal to 0")
      expect(@item.current_price).to_not eq(-200)
      expect(find_field("item[current_price]").value).to eq(@item.current_price.to_s)
      
      fill_in :item_inventory, with: 0
      click_button 'Update Item'
      expect(page).to have_content("Item ##{@item.id} has been updated")
      
      visit edit_dashboard_item_path(@item)
      @item = Item.find(@item.id)
      
      fill_in :item_inventory, with: -4
      click_button 'Update Item'
      expect(page).to have_content("Inventory must be greater than or equal to 0")
      expect(@item.inventory).to_not eq(-4)
      expect(find_field("item[inventory]").value).to eq(@item.inventory.to_s)
      
      fill_in :item_inventory, with: nil
      click_button 'Update Item'
      expect(page).to have_content("Inventory is not a number")
      expect(@item.inventory).to_not eq(nil)
      expect(find_field("item[inventory]").value).to eq(@item.inventory.to_s)
    end
    
    it 'will let the image field be blank and replace with placeholder image' do
      visit edit_dashboard_item_path(@item)
      
      fill_in :item_image_link, with: nil
      click_button 'Update Item'
      expect(page).to have_content("Item ##{@item.id} has been updated")
      expect(current_path).to eq(dashboard_items_path)
      within "#item-#{@item.id}" do
        expect(page).to have_css("img[src*='https://picsum.photos/200/300?image=0']")
      end
    end
    
    it 'will keep an items disabled state when updating' do
      disabled_item = create(:disabled_item, user: @merchant)
      visit edit_dashboard_item_path(disabled_item)
      new_name = "New!"
      
      fill_in :item_name, with: new_name
      click_button 'Update Item'
      
      expect(page).to have_content("Item ##{disabled_item.id} has been updated")
      expect(current_path).to eq(dashboard_items_path)
      within "#item-#{disabled_item.id}" do
        expect(page).to have_content(new_name)
        expect(page).to have_content('Enable this item')
      end
      expect(disabled_item.enabled).to eq(false)
    end
  end
end