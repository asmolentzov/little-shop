require 'rails_helper'

describe 'USER SHOW PAGE' do
  context 'As a registered user' do
    it 'shows user profile information' do
      user_1 = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
        zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 0, enabled: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit profile_path

      expect(page).to have_content(user_1.name)
      expect(page).to have_content(user_1.street)
      expect(page).to have_content(user_1.city)
      expect(page).to have_content(user_1.state)
      expect(page).to have_content(user_1.zip)
      expect(page).to have_content(user_1.email)

      expect(page).to have_link('Edit Profile')

      expect(page).to_not have_content(user_1.password)
    end

    it 'allows me to go to a form to edit my data that has all my data pre-entered' do
      user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
        zip: 'ZIP1', email: 'email1@aol.com', password: 'password1')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit profile_path

      click_link "Edit Profile"

      expect(current_path).to eq(profile_edit_path)

      expect(find_field("user[name]").value).to eq(user.name)
      expect(find_field("user[street]").value).to eq(user.street)
      expect(find_field("user[city]").value).to eq(user.city)
      expect(find_field("user[state]").value).to eq(user.state)
      expect(find_field("user[zip]").value).to eq(user.zip)
      expect(find_field("user[email]").value).to eq(user.email)
      expect(find_field("user[password]").value).to eq(nil)
    end
    it 'allows me to edit some of my information' do
      old_name = 'User One'
      old_city = 'City One'
      user = User.create(name: old_name, street: 'Street One', city: old_city, state: 'State1',
        zip: 'ZIP1', email: 'email1@aol.com', password: 'password1')

        new_name = 'NEW NAME'
        new_city = 'NEW CITY'
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit profile_edit_path

      fill_in :user_name, with: new_name
      fill_in :user_city, with: new_city

      click_button 'Submit'
      expect(current_path).to eq(profile_path)
      expect(page).to have_content('You have updated your profile')
      expect(page).to have_content(new_name)
      expect(page).to have_content(new_city)
      expect(page).to have_content(user.street)
      expect(page).to have_content(user.state)
      expect(page).to have_content(user.zip)
      expect(page).to have_content(user.email)
      expect(page).to_not have_content(old_name)
      expect(page).to_not have_content(old_city)
    end
    it 'allows me to edit all of my information' do
      old_name = 'User One'
      old_street = 'Street One'
      old_city = 'City One'
      old_state = 'State1'
      old_zip = 'ZIP1'
      old_email = 'email1@aol.com'
      user = User.create(name: old_name, street: old_street, city: old_city, state: old_state,
        zip: old_zip, email: old_email, password: 'password1')

      new_name = 'NEW NAME'
      new_street = 'New Street'
      new_city = 'NEW CITY'
      new_state = 'New State'
      new_zip = 'zip2'
      new_email = 'email2@aol.com'

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit profile_edit_path

      fill_in :user_name, with: new_name
      fill_in :user_street, with: new_street
      fill_in :user_city, with: new_city
      fill_in :user_state, with: new_state
      fill_in :user_zip, with: new_zip
      fill_in :user_email, with: new_email
      click_button 'Submit'

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('You have updated your profile')
      expect(page).to have_content(new_name)
      expect(page).to have_content(new_city)
      expect(page).to have_content(new_street)
      expect(page).to have_content(new_state)
      expect(page).to have_content(new_zip)
      expect(page).to have_content(new_email)
      expect(page).to_not have_content(old_name)
      expect(page).to_not have_content(old_street)
      expect(page).to_not have_content(old_city)
      expect(page).to_not have_content(old_state)
      expect(page).to_not have_content(old_zip)
      expect(page).to_not have_content(old_email)
    end
    it 'does not allow me to leave fields blank' do
      user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
        zip: 'ZIP1', email: 'email1@aol.com', password: 'password1')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit profile_edit_path

      fill_in :user_name, with: ''
      click_button 'Submit'

      expect(current_path).to eq(profile_edit_path)
      expect(page).to have_content('Required fields are missing')
      expect(find_field("user[name]").value).to eq(user.name)
      expect(find_field("user[street]").value).to eq(user.street)
      expect(find_field("user[city]").value).to eq(user.city)
      expect(find_field("user[state]").value).to eq(user.state)
      expect(find_field("user[zip]").value).to eq(user.zip)
      expect(find_field("user[email]").value).to eq(user.email)
      expect(find_field("user[password]").value).to eq(nil)
    end
    it 'should not see a link to upgrade' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit(profile_path(user))

      expect(page).to_not have_link('Upgrade to Merchant')
    end
  end
end
