require 'rails_helper'

describe 'as a visitor, when I visit /' do
  describe 'and I click on the register link' do
    it 'takes me to a page with a registration form' do
      visit '/'

      click_on 'Register'

      expect(current_path).to eq(registration_path)
    end
    describe 'when I fill out the form and click submit' do
      it 'logs me in and takes me to my profile page' do
        visit registration_path

        fill_in :user_name, with: "User One"
        fill_in :user_street, with: "Street One"
        fill_in :user_city, with: "City One"
        fill_in :user_zip, with: "ZIP1"
        fill_in :user_email, with: "email1@aol.com"
        fill_in :user_password, with: "password1"
        click_on 'Register'

        user = User.all.last

        expect(current_path).to eq(profile_path(user))
        expect(current_user.name).to eq(user.name)
        expect(flash[:success]).to match(/You are now registered and logged in.*/)
      end
    end
  end
end
