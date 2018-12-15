require 'rails_helper'
# 
# - a link to return to the welcome / home page of the application ("/")
# - a link to browse all items for sale ("/items")
# - a link to see all merchants ("/merchants")
# - a link to my shopping cart ("/cart")
# - a link to log in ("/login")
# - a link to the user registration page ("/register")
# Next to the shopping cart link I see a count of the items in my cart

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
    end
    it 'should direct to the items page' do
      visit root_path
      
      within '#nav' do
        click_on "Items"
      end
      
      expect(current_path).to eq(items_path)
    end
    it 'should direct to the merchants page' do
      visit root_path
      
      within '#nav' do
        click_on "Merchants"
      end
      
      expect(current_path).to eq(merchants_path)
    end
    it 'should direct to the cart page' do
      visit root_path
      
      within '#nav' do
        click_on "Cart"
      end
      
      expect(current_path).to eq(cart_path)
    end
    it 'should direct to the login page' do
      visit root_path
      
      within '#nav' do
        click_on "Log In"
      end
      
      expect(current_path).to eq(login_path)
    end
    it 'should direct to the register page' do
      visit root_path
      
      within '#nav' do
        click_on "Register"
      end
      
      expect(current_path).to eq(new_user_path)
    end
  end
end