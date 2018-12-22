require 'rails_helper'

describe 'As a visitor to the app' do
  context 'Main home page' do

    it 'sees a nav bar with appropriate links' do
      visit root_path

      within '#nav' do
        expect(page).to have_link("Home")
        expect(page).to have_link("Items")
        expect(page).to have_link("Merchants")
        expect(page).to have_link("Cart")
        expect(page).to have_link("Log In")
        expect(page).to have_link("Register")
      end
    end
    it 'should direct to home page' do
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
    it 'should see number of items in cart' do
      item_1 = create(:item)
      item_2 = create(:item)
      
      visit items_path

      within "#nav" do
        expect(page).to have_content("Cart: 0") 
      end
      
      within "#item-#{item_1.id}" do
        click_button('Add item')
      end
      
      within "#nav" do
        expect(page).to have_content("Cart: 1") 
      end
      
      within "#item-#{item_2.id}" do
        click_button('Add item')
        click_button('Add item')
      end
      
      within "#nav" do
        expect(page).to have_content("Cart: 3") 
      end
    end
    it 'should not be able to navigate to any profile path' do
      visit root_path
      
      within "#nav" do
        expect(page).to_not have_content("Profile")
      end
      
      visit profile_path
      
      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist")
      
      visit profile_orders_path
      expect(page.status_code).to eq(404)
    end
    it 'should not be able to navigate to any dashboard path' do
      visit root_path
      
      within "#nav" do
        expect(page).to_not have_content("Dashboard")
      end
      
      visit dashboard_path
      
      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist")
    end
    it 'should not be able to navigate to any admin path' do
      visit root_path
      
      within "#nav" do
        expect(page).to_not have_content("All Users")
      end
      
      visit admin_users_path
      
      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
