require 'rails_helper'

describe 'USER SHOW PAGE' do
  context 'As a registered user' do
    it 'does this thing' do
      user_1 = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
        zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 0, enabled: true)

      visit user_path(user_1)

      expect(page).to have_content(user_1.name)
      expect(page).to have_content(user_1.street)
      expect(page).to have_content(user_1.city)
      expect(page).to have_content(user_1.state)
      expect(page).to have_content(user_1.zip)
      expect(page).to have_content(user_1.email)

      expect(page).to have_link('Edit Profile')
    end
  end
end
