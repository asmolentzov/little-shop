require 'rails_helper'

describe 'as a registered user' do
  it 'sees an empty cart' do

    user_1 = create(:user)
    user_2 = create(:user)

    item_1 = create(:item)
    item_2 = create(:item)

   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

   visit cart_path

   expect(page).to have_content("Cart: 0")
   expect(page).to_not have_contnet(item_1.name)
   expect(page).to_not have_contnet(item_1.price)
   expect(page).to_not have_contnet(item_2.name)
   expect(page).to_not have_contnet(item_2.price)
   expect(page).to_not have_link('Empty Cart')

  end
end
