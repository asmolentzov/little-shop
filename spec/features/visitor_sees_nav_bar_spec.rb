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
  end
end