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
        click_on 'Submit'


        expect(current_path).to eq(profile_path)
        expect(page).to have_content('You are now registered and logged in.')


      end
    end

    describe 'when I fill out the form and click submit with previously used email address' do
      it 'does not log me in and displays flash message and form is represents form with previous data' do

        User.create(name: 'Quindarius Gooch', street: '24 Paso Robles', city: 'Santa Fe', state: 'NM',
          zip: '90674', email: 'email1@aol.com', password: 'password', role: 0, enabled: true)

        visit registration_path

        fill_in :user_name, with: "User One"
        fill_in :user_street, with: "Street One"
        fill_in :user_city, with: "City One"
        fill_in :user_state, with: "State One"
        fill_in :user_zip, with: "ZIP1"
        fill_in :user_email, with: "email1@aol.com"
        fill_in :user_password, with: "password1"
        click_on 'Submit'

        expect(page).to have_content('Email address is already in use')
        expect(find_field("user[name]").value).to eq("User One")
        expect(find_field("user[street]").value).to eq("Street One")
        expect(find_field("user[city]").value).to eq("City One")
        expect(find_field("user[state]").value).to eq("State One")
        expect(find_field("user[zip]").value).to eq("ZIP1")
        expect(find_field("user[password]").value).to eq(nil)
        expect(find_field("user[email]").value).to eq(nil)
      end
    end
    describe 'when I fill out the form and click submit with previously used email address' do
      it 'does not log me in and displays flash message and form is represents form with previous data' do

        User.create(name: 'Quindarius Gooch', street: '24 Paso Robles', city: 'Santa Fe', state: 'NM',
          zip: '90674', email: 'email1@aol.com', password: 'password', role: 0, enabled: true)

        visit registration_path

        fill_in :user_name, with: "User One"
        fill_in :user_street, with: "Street One"
        fill_in :user_city, with: "City One"
        fill_in :user_state, with: "State One"
        fill_in :user_zip, with: "ZIP1"
        fill_in :user_email, with: "email1@aol.com"
        fill_in :user_password, with: "password1"
        click_on 'Sign Up'

        expect(page).to have_content('Email address is already in use')
        expect(find_field("user[name]").value).to eq("User One")
        expect(find_field("user[street]").value).to eq("Street One")
        expect(find_field("user[city]").value).to eq("City One")
        expect(find_field("user[state]").value).to eq("State One")
        expect(find_field("user[zip]").value).to eq("ZIP1")
        expect(find_field("user[password]").value).to eq(nil)
        expect(find_field("user[email]").value).to eq(nil)
      end
    end
    describe 'when I fill out the form and click submit with an empty field' do
      it 'does not log me in and displays flash message and form is represents form with previous data' do
        visit registration_path

        fill_in :user_name, with: "User One"
        fill_in :user_street, with: "Street One"
        fill_in :user_city, with: "City One"
        fill_in :user_state, with: "State One"
        fill_in :user_email, with: "email1@aol.com"
        fill_in :user_password, with: "password1"
        click_on 'Sign Up'

        expect(page).to have_content('Required fields are missing')
        expect(find_field("user[name]").value).to eq("User One")
        expect(find_field("user[street]").value).to eq("Street One")
        expect(find_field("user[city]").value).to eq("City One")
        expect(find_field("user[state]").value).to eq("State One")
        expect(find_field("user[email]").value).to eq("email1@aol.com")

        expect(find_field("user[zip]").value).to eq("")
        expect(find_field("user[password]").value).to eq(nil)
      end
    end
  end
end
