require 'rails_helper'

describe 'As a visitor' do
  describe 'when I add items to my cart and I visit my cart page' do
    it 'should see a message telling me to register or login to checkout' do
      item_1 = create(:item)

      visit items_path

      within("#item-#{item_1.id}") do
        click_button 'Add item'
      end

      visit cart_path

      expect(page).to have_content('You must register or log in to checkout')
      expect(page).to have_link('register')
      expect(page).to have_link('log in')

      click_on 'register'
      expect(current_path).to eq(registration_path)

      visit cart_path

      click_on 'log in'
      expect(current_path).to eq(login_path)
    end
    it 'should not show the register or login message if I am logged in' do
      item_1 = create(:item)
      user_1 = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit items_path

      within("#item-#{item_1.id}") do
        click_button 'Add item'
      end

      visit cart_path

      expect(page).to_not have_content('You must register or log in to checkout')
      expect(page).to_not have_link('register')
      expect(page).to_not have_link('log in')
    end
  end
end
