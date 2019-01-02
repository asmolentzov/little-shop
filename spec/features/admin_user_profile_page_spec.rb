require 'rails_helper'

describe 'As an admin user' do
  describe  'when I visit a default user profile page' do
    it 'should see the same information that a user sees' do
      user_1 = create(:user)
      user_2 = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

      visit admin_user_path(user_1)

      expect(page).to have_content(user_1.name)
      expect(page).to have_content(user_1.street)
      expect(page).to have_content(user_1.city)
      expect(page).to have_content(user_1.state)
      expect(page).to have_content(user_1.zip)
      expect(page).to have_content(user_1.email)

      expect(page).to have_link('Edit Profile')
      expect(page).to_not have_link("My Items")

      expect(page).to_not have_content(user_1.password)
    end

    it 'shows me that users order data' do
      user_1 = create(:user)
      admin = create(:admin)

      order_1 = create(:order, user: user_1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(user_1)

      expect(page).to have_content("Order: #{order_1.id}")
      expect(page).to have_content("Placed on: #{order_1.created_at}")
      expect(page).to have_content("Last update: #{order_1.updated_at}")
      expect(page).to have_content("Status: #{order_1.status}")

    end
  end

  describe 'when i visit the user_path of a merchant' do
    it 'i am redirected to merchant_path' do
    admin = create(:admin)
    merchant = create(:merchant)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_user_path(merchant.id)

    expect(current_path).to eq(admin_merchant_path(merchant.id))

    expect(page).to have_link("My Items")
    end
  end

  describe 'when i visit the merchant_path of a user who is not a merchant' do
    it 'i am redirected to the user_path' do
    admin = create(:admin)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_merchant_path(user.id)

    expect(current_path).to eq(admin_user_path(user.id))

    expect(page).to_not have_link("My Items")
    expect(page).to have_link("Upgrade to Merchant")
    end
  end

  describe  'when I visit a merchant user profile page' do
    it 'should see the same information that a user sees' do
      user_1 = create(:merchant)
      user_2 = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

      visit admin_user_path(user_1)

      expect(page).to have_content(user_1.name)
      expect(page).to have_content(user_1.street)
      expect(page).to have_content(user_1.city)
      expect(page).to have_content(user_1.state)
      expect(page).to have_content(user_1.zip)
      expect(page).to have_content(user_1.email)

      expect(page).to have_link('My Items')
      expect(page).to_not have_link("Edit Profile")

      expect(page).to_not have_content(user_1.password)
    end
  end

  describe 'I should see a link to upgrade the user account to a merchant account' do
    it 'should upgrade the user to a merchant' do
      admin = create(:admin)
      user_1 = create(:user)
      user_2 = create(:merchant)

      #confirming default user cannot access path to upgrade a user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      visit admin_user_path(user_1)
      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist")

      #confirming merchant user cannot access path to upgrade a user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)
      visit admin_user_path(user_1)
      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(user_1)

      expect(page).to have_link('Upgrade to Merchant')
      click_on('Upgrade to Merchant')
      expect(current_path).to eq(admin_merchant_path(user_1))

      updated_user = User.find(user_1.id)
      expect(updated_user.role).to eq('merchant')
      expect(page).to have_content('This user has been upgraded.')

      #the upgraded user is now a merchant and can visit their dashboard path
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(updated_user)
      visit dashboard_path
      expect(page).to have_link('My Items')
    end

  end

  describe 'I see a link to edit' do
    it 'allows admin to edit all user information' do
      old_name = 'User One'
      old_street = 'Street One'
      old_city = 'City One'
      old_state = 'State1'
      old_zip = '54321'
      old_email = 'email1@aol.com'

      user_1 = User.create(name: old_name, street: old_street, city: old_city, state: old_state,
        zip: 12345, email: old_email, password: 'password1')

      new_name = 'NEW NAME'
      new_street = 'New Street'
      new_city = 'NEW CITY'
      new_state = 'New State'
      new_zip = '12345'
      new_email = 'email2@aol.com'

      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(user_1)

      click_link 'Edit Profile'

      fill_in :user_name, with: new_name
      fill_in :user_street, with: new_street
      fill_in :user_city, with: new_city
      fill_in :user_state, with: new_state
      fill_in :user_zip, with: new_zip
      fill_in :user_email, with: new_email

      click_button 'Submit'

      expect(current_path).to eq(admin_user_path(user_1))

      expect(page).to have_content('Profile Updated')
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

    it 'does not allow admin to leave fields blank' do
      user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
        zip: '12345', email: 'email1@aol.com', password: 'password1')

      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(user)

      click_link 'Edit Profile'

      fill_in :user_name, with: ''

      click_button 'Submit'

      user = User.find(user.id)
      expect(page).to have_content("Name can't be blank")
      expect(find_field("user[name]").value).to eq(user.name)
      expect(find_field("user[street]").value).to eq(user.street)
      expect(find_field("user[city]").value).to eq(user.city)
      expect(find_field("user[state]").value).to eq(user.state)
      expect(find_field("user[zip]").value).to eq(user.zip)
      expect(find_field("user[email]").value).to eq(user.email)
      expect(find_field("user[password]").value).to eq(nil)

      fill_in :user_street, with: ''
      fill_in :user_city, with: ''
      fill_in :user_state, with: ''
      fill_in :user_zip, with: ''
      click_button 'Submit'

      user = User.find(user.id)
      expect(page).to have_content("Street can't be blank")
      expect(page).to have_content("City can't be blank")
      expect(page).to have_content("State can't be blank")
      expect(page).to have_content("Zip can't be blank")
    end

    it 'does not allow admin to update my email address to one that is already in use' do
      other_email = 'other@aol.com'
      create(:user, email: other_email)

      email = 'email@aol.com'
      user = create(:user, email: email)

      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(user)

      click_link 'Edit Profile'

      fill_in :user_email, with: other_email
      click_button 'Submit'

      user = User.find(user.id)

      expect(page).to have_content('Email has already been taken')
      expect(find_field("user[name]").value).to eq(user.name)
      expect(find_field("user[street]").value).to eq(user.street)
      expect(find_field("user[city]").value).to eq(user.city)
      expect(find_field("user[state]").value).to eq(user.state)
      expect(find_field("user[zip]").value).to eq(user.zip)
      expect(find_field("user[email]").value).to eq(email)
      expect(user.email).to eq(email)
      expect(find_field("user[password]").value).to eq(nil)
    end
  end
end
