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
        
        orders = [order_2, order_3, order_1]
        
        expect(Order.biggest_orders).to eq(orders)
      end
    end
  end

end
