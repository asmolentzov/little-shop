require 'rails_helper'
describe 'nav' do
  context 'as a registered user' do
    it 'sees a nav bar with appropriate links ' do
      visit items_path
      within '#nav' do
        click_on "Home"
      end

      expect(current_path).to eq(root_path)

      within '#nav' do
        click_on "Items"
      end

      expect(current_path).to eq(items_path)

      within '#nav' do
        click_on "Merchants"
      end

      expect(current_path).to eq(merchants_path)

      within '#nav' do
        click_on "Cart"
      end

      expect(current_path).to eq(cart_path)

      within '#nav' do
        click_on "Log In"
      end

      expect(current_path).to eq(login_path)

      within '#nav' do
        click_on "Register"
      end

      expect(current_path).to eq(registration_path)
    end
  end
end
