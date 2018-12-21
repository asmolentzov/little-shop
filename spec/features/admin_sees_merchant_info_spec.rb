require 'rails_helper'

describe 'As an admin' do
  it 'can visit the merchant index path' do
    merchant_1 = User.create(name: 'Argellica Jones', street: '9 Slider Ave', city: 'Smithtown', state: 'PA',
      zip: '76390', email: 'Jonesey@aol.com', password: '123456789', role: 1, enabled: true)
    merchant_2 = User.create(name: 'Holden Butts', street: '5607 E County Rd.', city: 'bifftown', state: 'CO',
        zip: '21154', email: 'Butts1045@aol.com', password: 'abc123', role: 1, enabled: true)



    admin = User.create(name: "user_1", password: "test", street: "street", city: "city", state: "CO", zip: "80219", email: "email", role: 2, enabled: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    merchant_2.update!(enabled: false)

    visit merchants_path



    within "#merchant-#{merchant_1.id}" do
    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_1.city)
    expect(page).to have_content(merchant_1.state)
    expect(page).to have_link(merchant_1.name)
    expect(page).to have_button("disable")

    expect(page).to_not have_content(merchant_2.name)
    expect(page).to_not have_content(merchant_2.city)
    expect(page).to_not have_content(merchant_2.state)
    expect(page).to_not have_link(merchant_2.name)
    end

    within "#merchant-#{merchant_2.id}" do
    expect(page).to have_content(merchant_2.name)
    expect(page).to have_content(merchant_2.city)
    expect(page).to have_content(merchant_2.state)
    expect(page).to have_link(merchant_2.name)
    expect(page).to have_button("enable")

    expect(page).to_not have_content(merchant_1.name)
    expect(page).to_not have_content(merchant_1.city)
    expect(page).to_not have_content(merchant_1.state)
    expect(page).to_not have_link(merchant_1.name)
    end
  end

  it 'can navigate to indivdual merchant paths' do

    merchant_1 = User.create(name: 'Argellica Jones', street: '9 Slider Ave', city: 'Smithtown', state: 'PA',
    zip: '76390', email: 'Jonesey@aol.com', password: '123456789', role: 1, enabled: true)
    merchant_2 = User.create(name: 'Holden Butts', street: '5607 E County Rd.', city: 'bifftown', state: 'CO',
      zip: '21154', email: 'Butts1045@aol.com', password: 'abc123', role: 1, enabled: true)

    admin = User.create(name: "user_1", password: "test", street: "street", city: "city", state: "CO", zip: "80219", email: "email", role: 2, enabled: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit merchants_path

    within "#merchant-#{merchant_1.id}" do

    click_on merchant_1.name

    end

    expect(current_path).to eq(admin_merchant_path(merchant_1.id))
    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_1.city)
    expect(page).to have_content(merchant_1.state)

    expect(page).to_not have_content(merchant_2.name)
    expect(page).to_not have_content(merchant_2.city)
    expect(page).to_not have_content(merchant_2.state)
  end

  it 'can enable a merchant' do

    merchant_1 = User.create(name: 'Argellica Jones', street: '9 Slider Ave', city: 'Smithtown', state: 'PA',
      zip: '76390', email: 'Jonesey@aol.com', password: '123456789', role: 1, enabled: true)
    merchant_2 = User.create(name: 'Holden Butts', street: '5607 E County Rd.', city: 'bifftown', state: 'CO',
        zip: '21154', email: 'Butts1045@aol.com', password: 'abc123', role: 1, enabled: false)


    admin = User.create(name: "user_1", password: "test", street: "street", city: "city", state: "CO", zip: "80219", email: "email", role: 2, enabled: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit merchants_path

    within "#merchant-#{merchant_2.id}" do

    click_on "enable"

    end

    expect(page).to have_content("#{merchant_2.name} is now enabled")
    
    within "#merchant-#{merchant_2.id}" do

    expect(page).to have_button("disable")

    end
  end
end
