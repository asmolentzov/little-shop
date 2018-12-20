require 'rails_helper'

RSpec.describe Cart do
  describe 'instance methods' do
    describe '#add_item' do
      it 'should add items to cart' do
        cart = Cart.new({})
        cart.add_item(1)
        expect(cart.contents).to eq({'1' => 1})
        cart.add_item(2)
        expect(cart.contents).to eq({'1' => 1, '2' => 1})
        cart.add_item(1)
        expect(cart.contents).to eq({'1' => 2, '2' => 1})
      end
    end

    describe '#grand_total' do
      it 'should return the grand total of all items and quantities' do
        merchant = User.create!(name: 'User Five', street: 'Street Five', city: 'City Five', state: 'State5',
        zip: 'ZIP5', email: 'email5@aol.com', password: 'password5', role: 1, enabled: true)
        #Item belonging to Mercant
        item_1 = Item.create!(name: 'IBM PCXT 5160', user: merchant, inventory: 3,
        current_price: 399500, enabled: true, image_link: 'ibm-pcxt5160.jpg', description: 'Yesterday in personal computing technology')
        item_2 = Item.create(name: 'IBM PCXT 5161', user: merchant, inventory: 3,
        current_price: 400000, enabled: true, image_link: 'ibm-pcxt5160.jpg', description: 'The latest in personal computing technology')

        cart = Cart.new({item_1.id.to_s => 1, item_2.id.to_s => 2})
        total = 1199500

        expect(cart.grand_total).to eq(total)
      end
    end
  end

end
