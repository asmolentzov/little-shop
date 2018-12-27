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
end
