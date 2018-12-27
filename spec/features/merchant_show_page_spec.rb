require 'rails_helper'

describe 'as a merchant user' do
  context 'when I visit my dashboard' do
    it 'should show me my profile data, but I cannot edit it' do
      merch = create(:merchant)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merch)

      visit dashboard_path

      expect(page).to have_content(merch.name)
      expect(page).to have_content(merch.street)
      expect(page).to have_content(merch.city)
      expect(page).to have_content(merch.state)
      expect(page).to have_content(merch.zip)
      expect(page).to have_content(merch.email)
      expect(page).to have_link('My Items')
      expect(page).to_not have_link('Edit Profile')
    end
  end
end
