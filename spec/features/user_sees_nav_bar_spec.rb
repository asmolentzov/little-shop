require 'rails_helper'
describe 'nav' do
  context 'as a registered user' do

    before(:each) do
      @user = User.create(name: "user_1", password: "test", street: "street", city: "city", state: "CO", zip: "80219", email: "email", role: 0, enabled: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'sees a nav bar with the same of links as visitor' do
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
    end
    it 'should see number of items in cart' do
      item_1 = create(:item)
      item_2 = create(:item)
      
      visit items_path

      within "#nav" do
        expect(page).to have_content("Cart: 0") 
      end
      
      within "#item-#{item_1.id}" do
        click_button('Add item')
      end
      
      within "#nav" do
        expect(page).to have_content("Cart: 1") 
      end
      
      within "#item-#{item_2.id}" do
        click_button('Add item')
        click_button('Add item')
      end
      
      within "#nav" do
        expect(page).to have_content("Cart: 3") 
      end
    end

    it 'sees a nav bar with user specific links' do
      visit root_path

      within "#nav" do
        click_link 'Profile'
      end

      expect(current_path).to eq(profile_path)

      within "#nav" do
        click_link 'Orders'
      end

      expect(current_path).to eq(profile_orders_path)

      within "#nav" do
        click_link 'Log Out'
      end

      expect(current_path).to eq(root_path)

    end

    it 'does not see visitor specific links' do
      visit root_path

      within "#nav" do
        expect(page).to_not have_content("Log In")
        expect(page).to_not have_content("Register")
      end

    end

    it 'sees text about logged in' do
      visit root_path

      within "#nav" do
        expect(page).to have_content("Logged in as #{@user.name}")
      end
    end
    
    it 'should not be able to navigate to any dashboard path' do
      visit root_path
      
      within "#nav" do
        expect(page).to_not have_content("Dashboard")
      end
      
      visit dashboard_path
      
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
end
