require 'rails_helper'
describe 'nav' do
  context 'as a registered user' do

    before(:each) do
      @user = User.create(name: "user_1", password: "test", street: "street", city: "city", state: "CO", zip: "80219", email: "email", role: 0, enabled: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

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
    end

    it 'sees a nav bar with user specific links' do


      visit root_path

      within "#nav" do
        click_link 'Profile'
      end

      expect(current_path).to eq(profile_path)

      within "#nav" do
        click_link 'Orders'
      end

      expect(current_path).to eq(profile_orders_path)

      within "#nav" do
        click_link 'Log Out'
      end

      expect(current_path).to eq(root_path)

    end

    it 'does not see visitor specific links' do


      visit root_path

      within "#nav" do
        expect(page).to_not have_content("Log In")
        expect(page).to_not have_content("Register")
      end

    end

    it 'sees text about logged in' do


      visit root_path

      within "#nav" do
        expect(page).to have_content("Logged in as #{@user.name}")
      end

    end
  end
end
