require 'rails_helper'

describe 'As a visitor to the site' do
  describe 'when I visit the login path' do
    context 'as a default user' do
      it 'should let me log in and send me to my profile page' do
        user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: 'ZIP1', email: 'email1@aol.com', password: 'password1')

        visit login_path

        fill_in :email, with: user.email
        fill_in :password, with: user.password
        click_button 'Log In'

        expect(current_path).to eq(profile_path)
        expect(page).to have_content("Logged In Successfully")
      end
    end
    context 'as a merchant user' do
      it 'should let me log in and send me to my dashboard page' do
        user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 1)

        visit login_path

        fill_in :email, with: user.email
        fill_in :password, with: user.password
        click_button 'Log In'

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("Logged In Successfully")
      end
    end
    context 'as an admin user' do
      it 'should let me log in and send me to the home page' do
        user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 2)

        visit login_path

        fill_in :email, with: user.email
        fill_in :password, with: user.password
        click_button 'Log In'

        expect(current_path).to eq(root_path)
        expect(page).to have_content("Logged In Successfully")
      end
    end
    context 'as an already-logged-in default user' do
      it 'should redirect me to my profile page' do
        user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: 'ZIP1', email: 'email1@aol.com', password: 'password1')

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit login_path

        expect(current_path).to eq(profile_path)
        expect(page).to have_content("You are already logged in")
      end
    end
    context 'as an already-logged-in merchant user' do
      it 'should redirect me to my profile page' do
        user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 1)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit login_path

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("You are already logged in")
      end
    end
    context 'as an already-logged-in admin user' do
      it 'should redirect me to my profile page' do
        user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 2)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit login_path

        expect(current_path).to eq(root_path)
        expect(page).to have_content("You are already logged in")
      end
    end
    context 'as a visitor' do
      it 'should not let me log in with invalid credentials' do
        user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1', zip: 'ZIP1', email: 'email1@aol.com', password: 'password1')
        wrong_password = 'pass'
        visit login_path

        fill_in :email, with: user.email
        fill_in :password, with: wrong_password
        click_button "Log In"

        expect(current_path).to eq(login_path)
        expect(page).to have_content('Credentials Incorrect')
      end
    end
  end
end
