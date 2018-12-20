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
  
  it 'should not be able to navigate to any profile path' do
    visit root_path
    
    within "#nav" do
      expect(page).to_not have_content("Profile")
    end
    
    visit profile_path
    expect(page.status_code).to eq(404)
    
    visit profile_edit_path
    expect(page.status_code).to eq(404)
  end
  it 'should not be able to navigate to any admin path' do
    visit root_path
    
    within "#nav" do
      expect(page).to_not have_content("All Users")
    end
    
    visit admin_users_path
    expect(page.status_code).to eq(404)
  end
end
