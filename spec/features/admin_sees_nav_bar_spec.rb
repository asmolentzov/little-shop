require 'rails_helper'

describe 'As an admin' do
  before(:each) do
    @admin = User.create(name: "user_1", password: "test", street: "street", city: "city", state: "CO", zip: "80219", email: "email", role: 2, enabled: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end
  
  it 'allows admin users to see admin links' do
    visit items_path



    within '#nav' do
      click_on "Home"
    end

    expect(current_path).to eq(root_path)

    within '#nav' do
      click_on "Items"
    end

    expect(current_path).to eq(items_path)

    within '#nav' do
      click_on "Merchants"
    end

    expect(current_path).to eq(merchants_path)

    within "#nav" do
      click_link 'Log Out'
    end

    expect(current_path).to eq(root_path)

    within "#nav" do
      click_link 'All Users'
    end

    expect(current_path).to eq(admin_users_path)

    within "#nav" do
      expect(page).to_not have_link("Cart")
      expect(page).to_not have_content("Total Items in Cart")
    end
  end
  
  it 'should not be able to navigate to any profile path' do
    visit root_path
    
    within "#nav" do
      expect(page).to_not have_content("Profile")
    end
    
    visit profile_path
    expect(page.status_code).to eq(404)
  end
  it 'should not be able to navigate to any dashboard path' do
    visit root_path
    
    within "#nav" do
      expect(page).to_not have_content("Dashboard")
    end
    
    visit dashboard_path
    expect(page.status_code).to eq(404)
  end
  it 'should not be able to navigate to any cart path' do
    visit root_path
    
    within "#nav" do
      expect(page).to_not have_content("Cart")
    end
    
    visit cart_path
    expect(page.status_code).to eq(404)
  end
end
