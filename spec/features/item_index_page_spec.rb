require 'rails_helper'

describe 'as a visitor' do
  describe 'when I visit /items' do
    context 'as a default user' do
      it 'should see all enabled items and their information' do
        user_1 = User.create(name: "user_1", password: "test", street: "street",
          city: "city", state: "CO", zip: "80219", email: "email", role: 0, enabled: true)
        user_2 = User.create(name: "user_1", password: "test", street: "street",
          city: "city", state: "CO", zip: "80219", email: "email", role: 1, enabled: true)
        item_1 = user_2.create(name: 'apple1', image_link: 'https://picsum.photos/g/200/300',
        inventory: 3, description: 'apple one', current_price: 200, enabled: true)
        item_2 = user_2.create(name: 'apple2', image_link: 'https://picsum.photos/5472/3648?image=1083',
        inventory: 4, description: 'apple two', current_price: 400, enabled: false)
        item_3 = user_2.create(name: 'apple3', image_link: 'https://picsum.photos/200/300?image=0',
        inventory: 5, description: 'apple three', current_price: 500, enabled: true)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

        visit items_path

        expect(page).to have_content(item_1.name)
        expect(page).to have_link("#{item_1.name}", item_path(item_1))
        expect(page).to have_css("img[src*='https://picsum.photos/g/200/300']")
        expect(page).to have_content(item_1.user.name)
        expect(page).to have_content(item_1.inventory)
        expect(page).to have_content(item_1.current_price)
        expect(page).to_not have_content(item_2.name)
        expect(page).to_not have_link("#{item_2.name}", item_path(item_2))
        expect(page).to_not have_css("img[src*='https://picsum.photos/5472/3648?image=1083']")
        expect(page).to_not have_content(item_2.user.name)
        expect(page).to_not have_content(item_2.inventory)
        expect(page).to_not have_content(item_2.current_price)
        expect(page).to have_content(item_3.name)
        expect(page).to have_link("#{item_3.name}", item_path(item_3))
        expect(page).to have_css("img[src*='https://picsum.photos/200/300?image=0']")
        expect(page).to have_content(item_3.user.name)
        expect(page).to have_content(item_3.inventory)
        expect(page).to have_content(item_3.current_price)
        find('#item-1-img').click
        expect(current_path).to eq(item_path(item_1))
      end
    end
    context 'as a merchant user' do
      it 'should see all enabled items and their information' do
        user_1 = User.create(name: "user_1", password: "test", street: "street",
          city: "city", state: "CO", zip: "80219", email: "email", role: 1, enabled: true)
        user_2 = User.create(name: "user_1", password: "test", street: "street",
          city: "city", state: "CO", zip: "80219", email: "email", role: 1, enabled: true)
        item_1 = user_2.create(name: 'apple1', image_link: 'https://picsum.photos/g/200/300',
        inventory: 3, description: 'apple one', current_price: 200, enabled: true)
        item_2 = user_2.create(name: 'apple2', image_link: 'https://picsum.photos/5472/3648?image=1083',
        inventory: 4, description: 'apple two', current_price: 400, enabled: false)
        item_3 = user_2.create(name: 'apple3', image_link: 'https://picsum.photos/200/300?image=0',
        inventory: 5, description: 'apple three', current_price: 500, enabled: true)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

        visit items_path

        expect(page).to have_content(item_1.name)
        expect(page).to have_link("#{item_1.name}", item_path(item_1))
        expect(page).to have_css("img[src*='https://picsum.photos/g/200/300']")
        expect(page).to have_content(item_1.user.name)
        expect(page).to have_content(item_1.inventory)
        expect(page).to have_content(item_1.current_price)
        expect(page).to_not have_content(item_2.name)
        expect(page).to_not have_link("#{item_2.name}", item_path(item_2))
        expect(page).to_not have_css("img[src*='https://picsum.photos/5472/3648?image=1083']")
        expect(page).to_not have_content(item_2.user.name)
        expect(page).to_not have_content(item_2.inventory)
        expect(page).to_not have_content(item_2.current_price)
        expect(page).to have_content(item_3.name)
        expect(page).to have_link("#{item_3.name}", item_path(item_3))
        expect(page).to have_css("img[src*='https://picsum.photos/200/300?image=0']")
        expect(page).to have_content(item_3.user.name)
        expect(page).to have_content(item_3.inventory)
        expect(page).to have_content(item_3.current_price)
        find('#item-1-img').click
        expect(current_path).to eq(item_path(item_1))
      end
    end
    context 'as an admin user' do
      it 'should see all enabled items and their information' do
        user_1 = User.create(name: "user_1", password: "test", street: "street",
          city: "city", state: "CO", zip: "80219", email: "email", role: 2, enabled: true)
        user_2 = User.create(name: "user_1", password: "test", street: "street",
          city: "city", state: "CO", zip: "80219", email: "email", role: 1, enabled: true)
        item_1 = user_2.create(name: 'apple1', image_link: 'https://picsum.photos/g/200/300',
        inventory: 3, description: 'apple one', current_price: 200, enabled: true)
        item_2 = user_2.create(name: 'apple2', image_link: 'https://picsum.photos/5472/3648?image=1083',
        inventory: 4, description: 'apple two', current_price: 400, enabled: false)
        item_3 = user_2.create(name: 'apple3', image_link: 'https://picsum.photos/200/300?image=0',
        inventory: 5, description: 'apple three', current_price: 500, enabled: true)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

        visit items_path

        expect(page).to have_content(item_1.name)
        expect(page).to have_link("#{item_1.name}", item_path(item_1))
        expect(page).to have_css("img[src*='https://picsum.photos/g/200/300']")
        expect(page).to have_content(item_1.user.name)
        expect(page).to have_content(item_1.inventory)
        expect(page).to have_content(item_1.current_price)
        expect(page).to_not have_content(item_2.name)
        expect(page).to_not have_link("#{item_2.name}", item_path(item_2))
        expect(page).to_not have_css("img[src*='https://picsum.photos/5472/3648?image=1083']")
        expect(page).to_not have_content(item_2.user.name)
        expect(page).to_not have_content(item_2.inventory)
        expect(page).to_not have_content(item_2.current_price)
        expect(page).to have_content(item_3.name)
        expect(page).to have_link("#{item_3.name}", item_path(item_3))
        expect(page).to have_css("img[src*='https://picsum.photos/200/300?image=0']")
        expect(page).to have_content(item_3.user.name)
        expect(page).to have_content(item_3.inventory)
        expect(page).to have_content(item_3.current_price)
        find('#item-1-img').click
        expect(current_path).to eq(item_path(item_1))
      end
    end
    context 'as a non-registered visitor' do
      it 'should see all enabled items and their information' do

        user_2 = User.create(name: "user_1", password: "test", street: "street",
          city: "city", state: "CO", zip: "80219", email: "email", role: 1, enabled: true)
        item_1 = user_2.create(name: 'apple1', image_link: 'https://picsum.photos/g/200/300',
        inventory: 3, description: 'apple one', current_price: 200, enabled: true)
        item_2 = user_2.create(name: 'apple2', image_link: 'https://picsum.photos/5472/3648?image=1083',
        inventory: 4, description: 'apple two', current_price: 400, enabled: false)
        item_3 = user_2.create(name: 'apple3', image_link: 'https://picsum.photos/200/300?image=0',
        inventory: 5, description: 'apple three', current_price: 500, enabled: true)

        visit items_path

        expect(page).to have_content(item_1.name)
        expect(page).to have_link("#{item_1.name}", item_path(item_1))
        expect(page).to have_css("img[src*='https://picsum.photos/g/200/300']")
        expect(page).to have_content(item_1.user.name)
        expect(page).to have_content(item_1.inventory)
        expect(page).to have_content(item_1.current_price)
        expect(page).to_not have_content(item_2.name)
        expect(page).to_not have_link("#{item_2.name}", item_path(item_2))
        expect(page).to_not have_css("img[src*='https://picsum.photos/5472/3648?image=1083']")
        expect(page).to_not have_content(item_2.user.name)
        expect(page).to_not have_content(item_2.inventory)
        expect(page).to_not have_content(item_2.current_price)
        expect(page).to have_content(item_3.name)
        expect(page).to have_link("#{item_3.name}", item_path(item_3))
        expect(page).to have_css("img[src*='https://picsum.photos/200/300?image=0']")
        expect(page).to have_content(item_3.user.name)
        expect(page).to have_content(item_3.inventory)
        expect(page).to have_content(item_3.current_price)
        find('#item-1-img').click
        expect(current_path).to eq(item_path(item_1))
      end
    end
  end
end
