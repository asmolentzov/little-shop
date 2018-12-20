require 'rails_helper'

RSpec.describe Cart do
  describe 'instance methods' do
    describe '#add_item' do
      it 'should add items to cart' do
        cart = Cart.new()
        cart.add_item(1)
        expect(cart.contents).to eq({'1' => 1})
        cart.add_item(2)
        expect(cart.contents).to eq({'1' => 1, '2' => 1})
        cart.add_item(1)
        expect(cart.contents).to eq({'1' => 2, '2' => 1})
      end
    end
  end
end
