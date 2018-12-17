require 'rails_helper'
describe 'nav' do
  context 'as a registered user' do
    it 'sees a nav bar with the same of links as visitor' do


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

    it 'sees a nav bar with user specific links' do
      user = User.create(name: "user_1", password: "test", street: "street", city: "city", state: "CO", zip: "80219", email: "email", role: 0, enabled: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      within "#nav" do
        click_link 'Profile'
      end

      expect(current_path).to eq(user_path(user))

      within "#nav" do
        click_link 'Orders'
      end

      expect(current_path).to eq(user_orders_path(user))

      within "#nav" do
        click_link 'Log Out'
      end

      expect(current_path).to eq(root_path)

    end
  end
end
