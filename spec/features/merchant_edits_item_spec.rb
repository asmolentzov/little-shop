require 'rails_helper'

describe 'As a registered merchant' do
  describe 'when I want to edit an item' do
    it 'I can visit a page to edit an item' do
      merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      
      item = create(:item, user: merchant)
      
      visit dashboard_items_path
      
      within "#item-#{item.id}" do
        click_on 'Edit this item'
      end
      
      expect(current_path).to eq(dashboard_items_edit(item))
      expect(current_path).to eq("/dashboard/items/#{item.id}/edit")
      
      expect(find_field("item[name]").value).to eq(item.name)
      expect(find_field("item[description]".value)).to eq(item.description)
      expect(find_field("item[image_link]".value)).to eq(item.image_link)
      expect(find_field("item[current_price]".value)).to eq(item.current_price)
      expect(find_field("item[inventory]".value)).to eq(item.inventory)
    end
  end
end