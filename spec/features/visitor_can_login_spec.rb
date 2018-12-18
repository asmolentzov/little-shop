require 'rails_helper'

describe 'As a visitor to the site' do
  describe 'when I visit the login path' do
    context 'as a default user' do
      it 'should let me log in and send me to my profile page' do
        user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: 'ZIP1', email: 'email1@aol.com', password: 'password1')
        
        visit login_path
        
        fill_in :email, with: user.email
        fill_in :password, with: user.password
        click_on 'Log In'
        
        expect(current_path).to eq(profile_path)
      end
    end
    context 'as a merchant user' do
      it 'should let me log in and send me to my dashboard page' do
        user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 1)
        
        visit login_path
        
        fill_in :email, with: user.email
        fill_in :password, with: user.password
        click_on 'Log In'
        
        expect(current_path).to eq(dashboard_path)
      end
    end
    context 'as an admin user' do
      it 'should let me log in and send me to the home page' do
        user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 2)
        
        visit login_path
        
        fill_in :email, with: user.email
        fill_in :password, with: user.password
        click_on 'Log In'
        
        expect(current_path).to eq(root_path)
      end
    end
  end
end