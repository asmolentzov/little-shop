require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:user)}
    it { should have_many(:order_items)}
    it { should have_many(:orders).through(:order_items)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:image_link)}
    it { should validate_presence_of(:inventory)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:enabled)}
    it { should validate_presence_of(:current_price)}
    it { should validate_presence_of(:user_id)}
  end

  describe 'instance methods' do
    it '.avg_fulfill_time' do
      user_2 = User.create(name: "user_1", password: "test", street: "street",
        city: "city", state: "CO", zip: "80219", email: "email2@aol.com", role: 1)
      item_1 = user_2.items.create(name: 'apple1', image_link: 'https://picsum.photos/g/200/300',
      inventory: 3, description: 'apple one', current_price: 200, enabled: true)
      item_2 = user_2.items.create(name: 'apple2', image_link: 'https://picsum.photos/5472/3648?image=1083',
      inventory: 4, description: 'apple two', current_price: 400, enabled: false)
      order_1 = Order.create(user_id: user_2.id, status: 1, created_at: 2.days.ago)
      order_item_1 = OrderItem.create(order_id: order_1.id, item_id: item_1.id,
                      quantity: 1, order_price: item_1.current_price, fulfilled: true, created_at: 18.days.ago)
      order_item_2 = OrderItem.create(order_id: order_1.id, item_id: item_1.id,
                      quantity: 1, order_price: item_1.current_price, fulfilled: true, created_at: 19.days.ago)
      order_item_3 = OrderItem.create(order_id: order_1.id, item_id: item_1.id,
                      quantity: 1, order_price: item_1.current_price, fulfilled: false, created_at: 2.days.ago)

      expect(item_1.avg_fulfill_time).to eq(18)
    end
  end
end
