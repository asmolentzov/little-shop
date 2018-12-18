require 'rails_helper'

describe 'as a merchant' do
  before(:each) do
    @user = User.create(name: "user_1", password: "test", street: "street", city: "city", state: "CO", zip: "80219", email: "email", role: 1, enabled: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  it 'sees a nav bar with appropriate links' do

    visit merchants_path

    within('#nav') do
      expect(page).to have_content('Dashboard')
      expect(page).to_not have_content('Total Items in Cart:')
    end
  end
end
