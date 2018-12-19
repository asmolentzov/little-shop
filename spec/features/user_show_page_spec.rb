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
  end
end

# As a registered user
# When I visit my profile page
# I see a link to edit my profile data
# When I click on the link to edit my profile data
# Then my current URI route is "/profile/edit"
# I see a form like the registration page
# The form contains all of my user information
# The password fields are blank and can be left blank
# I can change any or all of the information
# When I submit the form
# Then I am returned to my profile page
# And I see a flash message telling me that my data is updated
# And I see my updated information