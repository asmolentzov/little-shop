require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:order)}
    it { should belong_to(:item)}
  end

  describe 'validations' do
    it { should validate_presence_of(:order_id)}
    it { should validate_presence_of(:item_id)}
    it { should validate_presence_of(:quantity)}
    it { should validate_presence_of(:order_price)}
    it { should validate_inclusion_of(:fulfilled).in_array([true, false])}
  end

  describe 'instance methods' do
    it 'provides the order_item subtotal' do
      order_item_1 = create(:fulfilled_order_item, quantity: 3, order_price: 300)
      expect(order_item_1.subtotal).to equal(900)
    end
  end
end
