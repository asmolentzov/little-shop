require 'rails_helper'

describe 'As an admin user' do
  include ActionView::Helpers::NumberHelper
  
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

      expect(current_path).to eq("/admin/merchants/#{@merchant.id}/items/new")
      expect(current_path).to eq(new_admin_merchant_item_path(@merchant))

      fill_in :item_name, with: 'item_1'
      fill_in :item_description, with: 'this is a great item_1'
      fill_in :item_image_link, with: 'https://picsum.photos/200'
      fill_in :item_current_price, with: 3000
      fill_in :item_inventory, with: 1
      click_on('Create Item')

      expect(current_path).to eq(admin_merchant_items_path(@merchant))
      expect(page).to have_content('Your new item has been created')

      item_1 = Item.last
      expect(item_1.name).to eq('item_1')
      expect(item_1.description).to eq('this is a great item_1')
      
      within("#item-#{item_1.id}") do
        expect(page).to have_content(item_1.id)
        expect(page).to have_content(item_1.name)
        expect(page).to have_css("img[src*='#{item_1.image_link}']")
        expect(page).to_not have_css("img[src*='https://picsum.photos/200/300?image=0']")
        expect(page).to have_content(number_to_currency(item_1.current_price / 100.0))
        expect(page).to have_content(item_1.inventory)
        expect(page).to have_link('Edit this item')
        expect(page).to have_link('Disable this item')
        expect(page).to have_link('Delete this item')
        expect(page).to_not have_link('Enable this item')
      end
    end
    
    it 'does not allow me to create a new item if required fields are missing' do
      visit admin_merchant_items_path(@merchant)
      
      click_on('Add New Item')
      
      # Check for all fields blank
      click_on('Create Item')

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("Current price can't be blank")
      expect(page).to have_content("Inventory is not a number")

      # Check for negative inventory, fields filled in
      fill_in :item_name, with: 'item_1'
      fill_in :item_description, with: 'this is a great item_1'
      fill_in :item_current_price, with: 3000
      fill_in :item_inventory, with: -1
      click_on('Create Item')

      expect(page).to have_content('Inventory must be greater than or equal to 0')
      expect(find_field("item[name]").value).to eq("item_1")
      expect(find_field("item[description]").value).to eq("this is a great item_1")
      expect(find_field("item[current_price]").value).to eq("3000")
      
      # Check for negative price
      fill_in :item_current_price, with: -400
      click_on 'Create Item'
      
      expect(page).to have_content('Current price must be greater than or equal to 0')
    end
    
    it 'allows me to edit all information on an item' do
      visit admin_merchant_items_path(@merchant)
      
      within "#item-#{@item.id}" do
        click_on 'Edit this item'
      end
      
      expect(current_path).to eq(edit_admin_merchant_item_path(@merchant, @item))
      expect(current_path).to eq("/admin/merchants/#{@merchant.id}/items/#{@item.id}/edit")
      
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
      
      expect(current_path).to eq(admin_merchant_items_path(@merchant))
      expect(page).to have_content("Item ##{@item.id} has been updated")
      
      within "#item-#{@item.id}" do
        expect(page).to have_content(new_name)
        expect(page).to have_content(new_desc)
        expect(page).to have_css("img[src='#{new_img}']")
        expect(page).to have_content(number_to_currency(new_price / 100.0))
        expect(page).to have_content(new_inventory)
        expect(page).to have_link("Disable this item")
      end
      expect(Item.find(@item.id).enabled).to eq(true)
    end
    
    it 'will have certain restrictions for editing information' do
      visit edit_admin_merchant_item_path(@merchant, @item)
      
      fill_in :item_name, with: nil
      click_button 'Update Item'
      
      expect(page).to have_content("Name can't be blank")
      expect(@item.name).to_not eq(nil)
      expect(find_field("item[name]").value).to eq(@item.name)
      
      fill_in :item_description, with: nil
      click_button 'Update Item'
      expect(page).to have_content("Description can't be blank")
      expect(@item.description).to_not eq(nil)
      expect(find_field("item[description]").value).to eq(@item.description)
      
      fill_in :item_current_price, with: -200
      click_button 'Update Item'
      expect(page).to have_content("Current price must be greater than or equal to 0")
      expect(@item.current_price).to_not eq(-200)
      expect(find_field("item[current_price]").value).to eq(@item.current_price.to_s)
      
      fill_in :item_inventory, with: 0
      click_button 'Update Item'
      expect(page).to have_content("Item ##{@item.id} has been updated")
      
      visit edit_admin_merchant_item_path(@merchant, @item)
      @item = Item.find(@item.id)
      
      fill_in :item_inventory, with: -4
      click_button 'Update Item'
      expect(page).to have_content("Inventory must be greater than or equal to 0")
      expect(@item.inventory).to_not eq(-4)
      expect(find_field("item[inventory]").value).to eq(@item.inventory.to_s)
    end
    
    it 'will let the image field be blank and replace with placeholder image' do
      visit edit_admin_merchant_item_path(@merchant, @item)
      
      fill_in :item_image_link, with: nil
      click_button 'Update Item'
      expect(page).to have_content("Item ##{@item.id} has been updated")
      expect(current_path).to eq(admin_merchant_items_path(@merchant))
      within "#item-#{@item.id}" do
        expect(page).to have_css("img[src*='https://picsum.photos/200/300?image=0']")
      end
    end
    
    it 'will keep an items disabled state when updating' do
      disabled_item = create(:disabled_item, user: @merchant)
      visit edit_admin_merchant_item_path(@merchant, disabled_item)
      
      new_name = "New!"
      
      fill_in :item_name, with: new_name
      click_button 'Update Item'
      
      expect(page).to have_content("Item ##{disabled_item.id} has been updated")
      expect(current_path).to eq(admin_merchant_items_path(@merchant))
      within "#item-#{disabled_item.id}" do
        expect(page).to have_content(new_name)
        expect(page).to have_content('Enable this item')
      end
      expect(disabled_item.enabled).to eq(false)
    end
    
    it 'should allow me to delete items' do
      item_2 = create(:item, user: @merchant)
      item_3 = create(:item, user: @merchant)
      
      visit admin_merchant_items_path(@merchant)
      
      expect(page).to have_content(@item.name)
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_3.name)
      within "#item-#{@item.id}" do
        click_on 'Delete this item'
      end

      expect(current_path).to eq(admin_merchant_items_path(@merchant))
      expect(page).to have_content("Item ##{@item.id} has been deleted")
      expect(page).to_not have_content(@item.name)
      expect(page).to_not have_content(@item.description)
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_3.name)
    end
    
    it 'should allow me to disable and enable items' do
      visit admin_merchant_items_path(@merchant)

      within("#item-#{@item.id}") do
       expect(page).to have_link('Disable this item')
       click_on('Disable this item')
      end

      expect(current_path).to eq(admin_merchant_items_path(@merchant))
      expect(page).to have_content("#{@item.name} is no longer for sale.")
      @item = Item.find(@item.id)
      expect(@item.enabled).to eq(false)
      
      within("#item-#{@item.id}") do
        expect(page).to have_content(@item.id)
        expect(page).to have_content('This item is disabled')
        expect(page).to_not have_content('This item is enabled')
        expect(page).to have_content(@item.name)
        expect(page).to have_css("img[src*='#{@item.image_link}']")
        expect(page).to have_content(number_to_currency(@item.current_price / 100.0))
        expect(page).to have_content(@item.inventory)
        expect(page).to have_link('Edit this item')
        expect(page).to have_link('Enable this item')
        expect(page).to_not have_link('Disable this item')
        expect(page).to have_link('Delete this item')
      end
      
      within("#item-#{@item.id}") do
       click_on('Enable this item')
      end
      
      expect(current_path).to eq(admin_merchant_items_path(@merchant))
      expect(page).to have_content("#{@item.name} is now available for sale.")
      @item = Item.find(@item.id)
      expect(@item.enabled).to eq(true)
      
      within("#item-#{@item.id}") do
        expect(page).to have_content(@item.id)
        expect(page).to_not have_content('This item is disabled')
        expect(page).to have_content('This item is enabled')
        expect(page).to have_content(@item.name)
        expect(page).to have_css("img[src*='#{@item.image_link}']")
        expect(page).to have_content(number_to_currency(@item.current_price / 100.0))
        expect(page).to have_content(@item.inventory)
        expect(page).to have_link('Edit this item')
        expect(page).to_not have_link('Enable this item')
        expect(page).to have_link('Disable this item')
        expect(page).to have_link('Delete this item')
      end
    end
    
    it 'should show me a fulfill button if I have enough inventory, and a red error message if I do not' do
      admin = create(:admin)
      merchant = create(:merchant)
      user = create(:user)
      item_1 = create(:item, inventory: 6, user: merchant)
      item_2 = create(:item, inventory: 3, user: merchant)
      order_1 = create(:order, user: user)
      order_item_1 = create(:unfulfilled_order_item, item: item_1, quantity: 3, order: order_1)
      order_item_2 = create(:unfulfilled_order_item, item: item_2, quantity: 4, order: order_1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchant_order_path(merchant, order_1)

      within("#item-#{item_1.id}") do
        expect(page).to have_link('Fulfill')
        expect(page).to_not have_content('Cannot Fulfill!')
        expect(page).to_not have_css('p.cannot_fulfill')
        click_on('Fulfill')
      end

      expect(page).to have_content("Order item ##{order_item_1.id} has been fulfilled!")

      merchant = User.find(merchant.id)

      expect(merchant.items.where(id: item_1.id).first.inventory).to be(3)

      within("#item-#{item_1.id}") do
        expect(page).to_not have_link('Fulfill')
        expect(page).to have_content('Already Fulfilled!')
        expect(page).to_not have_content('Cannot Fulfill!')
        expect(page).to_not have_css('p.cannot_fulfill')
      end

      within("#item-#{item_2.id}") do
        expect(page).to_not have_link('Fulfill')
        expect(page).to have_content('Cannot Fulfill!')
        expect(page).to have_css('p.cannot_fulfill')
      end
    end
    it 'I fulfill the final item in the order, and the order status changes to Complete' do
      admin = create(:admin)
      merchant = create(:merchant)
      other_merchant = create(:merchant)
      user = create(:user)

      item_1 = create(:item, inventory: 6, user: merchant)
      item_2 = create(:item, inventory: 3, user: merchant)
      item_3 = create(:item, user: other_merchant)

      order = create(:order, user: user)
      order_item_1 = create(:unfulfilled_order_item, item: item_1, quantity: 1, order: order)
      order_item_2 = create(:unfulfilled_order_item, item: item_2, quantity: 2, order: order)
      order_item_3 = create(:fulfilled_order_item, item: item_3, quantity:1, order: order)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchant_order_path(merchant, order)
      within("#item-#{item_1.id}") do
        click_on('Fulfill')
      end
      ##Fulfillitng only one of two outstanding order items should not complete the order
      expect(Order.find(order.id).status).to eq('pending')

      within("#item-#{item_2.id}") do
        click_on('Fulfill')
      end
      ##The order should be completed only on completing both order items
      expect(Order.find(order.id).status).to eq('fulfilled')
    end
  end
end