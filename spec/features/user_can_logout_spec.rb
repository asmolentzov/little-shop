require 'rails_helper'

describe 'as a logged in user' do
  context 'default user' do
    it 'should be able to log out' do
      user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: 'ZIP1', email: 'email1@aol.com', password: 'password1')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit profile_path

      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Successfully Logged Out")
    end
  end
  context 'merchant user' do
    it 'should be able to log out' do
      user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Successfully Logged Out")
    end
  end
  context 'admin user' do
    it 'should be able to log out' do
      user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit items_path

      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Successfully Logged Out")
    end
  end
end
