require 'rails_helper'

describe 'as any user' do
  context "when I visit /items and visit an item's show page" do
    it 'should see information about that item' do
      user_1 = User.create(name: "user_1", password: "test", street: "street",
        city: "city", state: "CO", zip: "80219", email: "email1@aol.com", role: 0)
      user_2 = User.create(name: "user_1", password: "test", street: "street",
        city: "city", state: "CO", zip: "80219", email: "email2@aol.com", role: 1)
      item_1 = user_2.items.create(name: 'apple1', image_link: 'https://picsum.photos/g/200/300',
      inventory: 3, description: 'apple one', current_price: 200, enabled: true)
      item_2 = user_2.items.create(name: 'apple2', image_link: 'https://picsum.photos/5472/3648?image=1083',
      inventory: 4, description: 'apple two', current_price: 400, enabled: false)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit items_path

      click_on 'apple1'

      expect(page).to have_content(item_1.name)
      expect(page).to have_css("img[src*='https://picsum.photos/g/200/300']")
      expect(page).to have_content(item_1.user.name)
      expect(page).to have_content(item_1.description)
      expect(page).to have_content(item_1.inventory)
      expect(page).to have_content(item_1.current_price)
      expect(page).to have_content(item_1.avg_fulfill_time)
      expect(page).to have_button("Add item")
    end
  end

  context 'when i visit the items show page as an unregistered user' do
    it 'can click link to add item to cart' do
      item_1 = create(:item)
      item_2 = create(:item)
      item_3 = create(:item)
      item_4 = create(:item)

      visit item_path(item_1.id)

      expect(page).to have_button("Add item")

      click_on "Add item"

      expect(current_path).to eq(items_path)

      within '#nav' do

        expect(page).to have_content("Cart: 1")

      end

      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_3.name)
      expect(page).to have_content(item_4.name)

      expect(page).to have_content(item_1.description)
      expect(page).to have_content(item_2.description)
      expect(page).to have_content(item_3.description)
      expect(page).to have_content(item_4.description)

      expect(page).to have_content(item_1.current_price)
      expect(page).to have_content(item_2.current_price)
      expect(page).to have_content(item_3.current_price)
      expect(page).to have_content(item_4.current_price)

    end
  end

end
