require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'relationships' do
    it { should belong_to(:user)}
    it { should have_many(:order_items)}
    it { should have_many(:items).through(:order_items)}
  end

  describe 'validations' do
    it { should validate_presence_of(:status)}
    it { should validate_presence_of(:user_id)}
  end

  describe 'Class Methods' do
    describe '.biggest_orders' do
      it 'should return the top 3 orders by quantity of items' do
        order_1 = create(:fulfilled_order)
        create(:fulfilled_order_item, order: order_1)
        create(:fulfilled_order_item, order: order_1)

        order_2 = create(:fulfilled_order)
        4.times do
          create(:fulfilled_order_item, order: order_2)
        end

        order_3 = create(:fulfilled_order)
        3.times do
          create(:fulfilled_order_item, order: order_3)
        end

        order_4 = create(:fulfilled_order)
        create(:fulfilled_order_item, order: order_4)
        5.times do
          create(:unfulfilled_order_item, order: order_4)
        end

        order_5 = create(:order)
        5.times do
          create(:fulfilled_order_item, order: order_5)
        end

        order_6 = create(:cancelled_order)
        5.times do
          create(:fulfilled_order_item, order: order_6)
        end

        orders = [order_2, order_3, order_1]

        expect(Order.biggest_orders).to eq(orders)
      end
    end
  end

  describe 'instance methods' do
    it 'returns the quantity of items in an order' do
      order_1 = create(:fulfilled_order)

      create(:fulfilled_order_item, order: order_1, quantity: 1, order_price: 100)
      create(:fulfilled_order_item, order: order_1, quantity: 1, order_price: 200)
      create(:fulfilled_order_item, order: order_1, quantity: 2, order_price: 300)
      create(:unfulfilled_order_item, order: order_1, quantity: 2, order_price: 400)

      expect(order_1.item_quantity).to eq(6)
    end
    it 'returns the grand total for an order' do
      order_1 = create(:fulfilled_order)

      create(:fulfilled_order_item, order: order_1, quantity: 1, order_price: 100)
      create(:fulfilled_order_item, order: order_1, quantity: 1, order_price: 200)
      create(:fulfilled_order_item, order: order_1, quantity: 2, order_price: 300)
      create(:unfulfilled_order_item, order: order_1, quantity: 2, order_price: 400)

      expect(order_1.grand_total).to eq(1700)
    end

  end

end
