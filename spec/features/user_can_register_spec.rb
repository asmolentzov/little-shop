require 'rails_helper'

describe 'as a visitor, when I visit /' do
  describe 'and I click on the register link' do
    it 'takes me to a page with a registration form' do
      visit root_path

      click_on 'Register'

      expect(current_path).to eq(registration_path)
    end
    describe 'when I fill out the form and click submit' do
      it 'logs me in and takes me to my profile page' do
        visit registration_path

        fill_in :user_name, with: "User One"
        fill_in :user_street, with: "Street One"
        fill_in :user_city, with: "City One"
        fill_in :user_state, with: "State One"
        fill_in :user_zip, with: "ZIP1"
        fill_in :user_email, with: "email1@aol.com"
        fill_in :user_password, with: "password1"
        click_on 'Sign Up'


        expect(current_path).to eq(profile_path)
        expect(page).to have_content('You are now registered and logged in.')


      end
    end
    
    describe 'when I fill out the form and click submit with previously used email address' do
      it 'does not log me in and displays flash message and form is represents form with previous data' do

        User.create(name: 'Quindarius Gooch', street: '24 Paso Robles', city: 'Santa Fe', state: 'NM',
          zip: '90674', email: 'email1@aol.com', password: 'password', role: 0, enabled: false)

        visit registration_path

        fill_in :user_name, with: "User One"
        fill_in :user_street, with: "Street One"
        fill_in :user_city, with: "City One"
        fill_in :user_state, with: "State One"
        fill_in :user_zip, with: "ZIP1"
        fill_in :user_email, with: "email1@aol.com"
        fill_in :user_password, with: "password1"
        click_on 'Sign Up'


        expect(current_path).to eq(registration_path)
        expect(page).to have_content('Email address is already in use')
        expect(page).to have_content("User One")
        expect(page).to have_content("Street One")
        expect(page).to have_content("City One")
        expect(page).to have_content("State One")
        expect(page).to have_content("ZIP1")
        expect(page).to_not have_content("email1@aol.com")
        expect(page).to_not have_content("password1")

      end
    end
  end
end
