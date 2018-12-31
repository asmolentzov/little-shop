require 'rails_helper'

describe 'as a logged in user' do
  context 'default user' do
    it 'should be able to log out' do
      user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: '12343', email: 'email1@aol.com', password: 'password1')

      visit login_path

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button 'Log In'

      visit profile_path

      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Successfully Logged Out")
      expect(page).to_not have_link("Log Out")
    end

    it 'should have an empty shopping cart when logged out' do
      user = create(:user)
      item_1 = create(:item)

      visit login_path

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button 'Log In'

      visit item_path(item_1.id)

      click_on "Add item"

      expect(current_path).to eq(items_path)

      within '#nav' do

        expect(page).to have_content("Cart: 1")

      end

      visit profile_path

      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Successfully Logged Out")
      expect(page).to_not have_link("Log Out")

      within '#nav' do

        expect(page).to have_content("Cart: 0")

      end
    end
  end
  context 'merchant user' do
    it 'should be able to log out' do
      user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: '12345', email: 'email1@aol.com', password: 'password1', role: 1)

      visit login_path

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button 'Log In'

      visit dashboard_path

      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Successfully Logged Out")
      expect(page).to_not have_link("Log Out")
    end
  end
  context 'admin user' do
    it 'should be able to log out' do
      user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: '12345', email: 'email1@aol.com', password: 'password1', role: 2)

      visit login_path

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button 'Log In'

      visit items_path

      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Successfully Logged Out")
      expect(page).to_not have_link("Log Out")
    end
  end
end
