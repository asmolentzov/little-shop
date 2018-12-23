
require 'rails_helper'

describe 'ADMIN USER INDEX PAGE' do
  context 'As an Admin user, when I click the Users nav link' do
    it 'shows a list of user information and associated links' do
      #Defaul Users
      user_1 = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
      zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 0, enabled: true)
      user_2 = User.create(name: 'User Two', street: 'Street Two', city: 'City Two', state: 'State2',
      zip: 'ZIP2', email: 'email2@aol.com', password: 'password2', role: 0, enabled: true)
      user_3 = User.create(name: 'User Three', street: 'Street Three', city: 'City Three', state: 'State3',
      zip: 'ZIP3', email: 'email3@aol.com', password: 'password3', role: 0, enabled: false)
      user_4 = User.create(name: 'User Four', street: 'Street Four', city: 'City Four', state: 'State4',
      zip: 'ZIP4', email: 'email4@aol.com', password: 'password4', role: 0, enabled: true)
      #Merchant User
      user_5 = User.create(name: 'User Five', street: 'Street Five', city: 'City Five', state: 'State5',
      zip: 'ZIP5', email: 'email5@aol.com', password: 'password5', role: 1, enabled: true)
      #Admin User
      user_6 = User.create(name: 'User Six', street: 'Street Six', city: 'City Six', state: 'State6',
      zip: 'ZIP6', email: 'email6@aol.com', password: 'password6', role: 2, enabled: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_6)

      visit admin_users_path

      within "#user-links-#{user_1.id}" do
        expect(page).to have_link(user_1.name)
        expect(page).to have_content(user_1.created_at)
        expect(page).to have_button("disable")
      end
      within "#user-links-#{user_2.id}" do
        expect(page).to have_link(user_2.name)
        expect(page).to have_content(user_1.created_at)
        expect(page).to have_button("disable")
      end
      within "#user-links-#{user_3.id}" do
        expect(page).to have_link(user_3.name)
        expect(page).to have_content(user_1.created_at)
        expect(page).to have_button("enable")
      end
      within "#user-links-#{user_4.id}" do
        expect(page).to have_link(user_4.name)
        expect(page).to have_content(user_1.created_at)
        expect(page).to have_button("disable")
      end
    end

    it 'allows me to enable and disable users' do
      #Defaul Users
      user_1 = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
      zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 0, enabled: true)
      #Admin User
      user_6 = User.create(name: 'User Six', street: 'Street Six', city: 'City Six', state: 'State6',
      zip: 'ZIP6', email: 'email6@aol.com', password: 'password6', role: 2, enabled: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_6)

      visit admin_users_path

      within "#user-links-#{user_1.id}" do
        click_button('disable')
      end
      within "#user-links-#{user_1.id}" do
        expect(page).to have_button("enable")
        comp_user = User.find(user_1.id)
        expect(comp_user.enabled).to eq(false)
        click_button('enable')
      end
      within "#user-links-#{user_1.id}" do
        expect(page).to have_button("disable")
        comp_user = User.find(user_1.id)
        expect(comp_user.enabled).to eq(true)
      end
    end
  end
end
