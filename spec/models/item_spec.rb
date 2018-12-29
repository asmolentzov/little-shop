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
    it  {should validate_inclusion_of(:enabled).in_array([true, false])}
    it { should validate_presence_of(:current_price)}
    it { should validate_presence_of(:user_id)}
  end

  describe 'class methods' do
    describe '.enabled_items' do
      it 'should return all enabled items' do
        merch = create(:merchant)
        user = create(:user)
        item_1 = create(:item, user: merch)
        item_2 = create(:item, user: merch)
        item_3 = create(:disabled_item, user: merch)

        expect(Item.enabled_items).to eq([item_1, item_2])
      end
    end
  end
  describe 'instance methods' do
    describe '#avg_fulfill_time' do
      it 'should return the average time it took for an item to be fulfilled' do
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
    describe '#five_popular()' do
      it 'returns the top five or bottom five most popular items' do
        item_1 = create(:item) #add a times loop to build these?
        item_2 = create(:item)
        item_3 = create(:item)
        item_4 = create(:item)
        item_5 = create(:item)
        item_6 = create(:item)
        item_7 = create(:item)
        order_item_1 = create(:fulfilled_order_item, item: item_1) #add a times loop to build these?
        order_item_2 = create(:fulfilled_order_item, item: item_1)
        order_item_3 = create(:fulfilled_order_item, item: item_1)
        order_item_4 = create(:fulfilled_order_item, item: item_1)
        order_item_5 = create(:fulfilled_order_item, item: item_3)
        order_item_6 = create(:fulfilled_order_item, item: item_3)
        order_item_7 = create(:fulfilled_order_item, item: item_3)
        order_item_8 = create(:fulfilled_order_item, item: item_2)
        order_item_9 = create(:fulfilled_order_item, item: item_2)
        order_item_10 = create(:fulfilled_order_item, item: item_4)
        order_item_11 = create(:fulfilled_order_item, item: item_4)
        order_item_12 = create(:fulfilled_order_item, item: item_6)
        order_item_13 = create(:fulfilled_order_item, item: item_6)
        order_item_14 = create(:fulfilled_order_item, item: item_5)
        order_item_15 = create(:fulfilled_order_item, item: item_7)

        expect(Item.five_popular('desc')).to include(item_1)
        expect(Item.five_popular('desc')).to include(item_2)
        expect(Item.five_popular('desc')).to include(item_3)
        expect(Item.five_popular('desc')).to include(item_4)
        expect(Item.five_popular('desc')).to include(item_6)
        expect(Item.five_popular('desc')).to_not include(item_5)
        expect(Item.five_popular('desc')).to_not include(item_7)

        expect(Item.five_popular('asc')).to include(item_7)
        expect(Item.five_popular('asc')).to include(item_6)
        expect(Item.five_popular('asc')).to include(item_5)
        expect(Item.five_popular('asc')).to include(item_4)
        expect(Item.five_popular('asc')).to include(item_2)
        expect(Item.five_popular('asc')).to_not include(item_1)
        expect(Item.five_popular('asc')).to_not include(item_3)
      end
    end
  end
end
