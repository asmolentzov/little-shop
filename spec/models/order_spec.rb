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
    
    describe '.merchant_pending_orders' do
      it 'should return all the pending orders for a merchant where they have items' do
        merchant = create(:merchant)
        
        order_1 = create(:order)
        item_1 = create(:item, user: merchant)
        create(:unfulfilled_order_item, order: order_1, item: item_1)
        create(:unfulfilled_order_item, order: order_1) 
        
        order_2 = create(:order)
        create(:unfulfilled_order_item, order: order_2)
        
        order_3 = create(:order)
        item_2 = create(:item, user: merchant)
        item_4 = create(:item, user: merchant)
        create(:fulfilled_order_item, order: order_3, item: item_2)
        create(:fulfilled_order_item, order: order_3, item: item_4)
        
        order_4 = create(:fulfilled_order)
        item_3 = create(:item, user: merchant)
        create(:fulfilled_order_item, order: order_4, item: item_3)
        
        expect(Order.merchant_pending_orders(merchant.id)).to eq([order_1, order_3])
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
  
    describe '#merchant_items_quantity' do
      it 'returns the quantity of items the specified merchant has in the order' do
        merchant = create(:merchant)
        
        order_1 = create(:order)
        item_1 = create(:item, user: merchant)
        item_2 = create(:item, user: merchant)
        create(:unfulfilled_order_item, order: order_1, item: item_1)
        create(:unfulfilled_order_item, order: order_1, item: item_2) 
        
        order_2 = create(:order)
        create(:unfulfilled_order_item, order: order_2)
        
        order_3 = create(:order)
        item_3 = create(:item, user: merchant)
        create(:fulfilled_order_item, order: order_3, item: item_3)
        create(:unfulfilled_order_item, order: order_3)
        
        expect(order_1.merchant_items_quantity(merchant.id)).to eq(2)
        expect(order_2.merchant_items_quantity(merchant.id)).to eq(0)
        expect(order_3.merchant_items_quantity(merchant.id)).to eq(1)
      end
    end
    
    describe '#merchant_items_value' do
      it 'returns the value of all of a merchants items in an order' do
        merchant = create(:merchant)
        
        order_1 = create(:order)
        item_1 = create(:item, user: merchant)
        item_2 = create(:item, user: merchant)
        o_i_1 = create(:unfulfilled_order_item, order: order_1, item: item_1)
        o_i_2 = create(:unfulfilled_order_item, order: order_1, item: item_2) 
        total_1 = o_i_1.order_price + o_i_2.order_price
        
        order_2 = create(:order)
        create(:unfulfilled_order_item, order: order_2)
        
        order_3 = create(:order)
        item_3 = create(:item, user: merchant)
        o_i_3 = create(:fulfilled_order_item, order: order_3, item: item_3)
        create(:unfulfilled_order_item, order: order_3)
        total_2 = o_i_3.order_price
        
        expect(order_1.merchant_items_value(merchant.id)).to eq(total_1)
        expect(order_2.merchant_items_value(merchant.id)).to eq(0)
        expect(order_3.merchant_items_value(merchant.id)).to eq(total_2)
      end
    end
    
    describe '#merchant_items_with_quantity' do
      it 'returns the items in an order that belong to the specified merchant, with the quantity' do
        merchant = create(:merchant)
        item_1 = create(:item, user: merchant)
        item_2 = create(:item, user: merchant)
        
        item_3 = create(:item)
        item_4 = create(:item, user: merchant)
        
        order = create(:order)
        create(:fulfilled_order_item, order: order, item: item_1, quantity: 2)
        create(:unfulfilled_order_item, order: order, item: item_2, quantity: 1)
        create(:fulfilled_order_item, order: order, item: item_3)
        
        expect(order.merchant_items_with_quantity(merchant.id)).to eq([[item_1, 2], [item_2, 1]])
      end
    end
  end
end
