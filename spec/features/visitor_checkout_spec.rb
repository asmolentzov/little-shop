require 'rails_helper'

describe 'As a visitor' do
  describe 'when I add items to my cart and I visit my cart page' do
    it 'should see a message telling me to register or login to checkout' do
      item_1 = create(:item)
      item_2 = create(:item)

      visit items_path

      within("#item-#{item_1.id}") do
        click_button 'Add item'
      end

      visit cart_path

      expect(page).to have_content('You must register or log in to checkout')
      expect(page).to have_link('register')
      expect(page).to have_link('log in')
    end
  end
end
