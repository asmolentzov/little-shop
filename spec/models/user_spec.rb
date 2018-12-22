require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:orders)}
    it { should have_many(:items)}
  end
  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:street)}
    it { should validate_presence_of(:city)}
    it { should validate_presence_of(:state)}
    it { should validate_presence_of(:zip)}
    it { should validate_presence_of(:email)}
    it { should validate_uniqueness_of(:email)}
    it { should validate_presence_of(:password)}
    it { should validate_presence_of(:role)}
    it  {should validate_inclusion_of(:enabled).in_array([true, false])}
  end

  describe 'class methods' do
    describe '.enabled_merchants' do
      it 'return all merchants' do
        user_1 = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
          zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 1, created_at: 1.days.ago)
        user_2 = User.create(name: 'User Two', street: 'Street Two', city: 'City Two', state: 'State2',
          zip: 'ZIP2', email: 'email2@aol.com', password: 'password2', role: 1, enabled: false, created_at: 2.days.ago)
        user_3 = User.create(name: 'User Three', street: 'Street Three', city: 'City Three', state: 'State3',
          zip: 'ZIP3', email: 'email3@aol.com', password: 'password3', role: 1, created_at: 3.days.ago)
        user_4 = User.create(name: 'User Four', street: 'Street Four', city: 'City Four', state: 'State4',
          zip: 'ZIP4', email: 'email4@aol.com', password: 'password4', created_at: 4.days.ago)

        expect(User.enabled_merchants).to eq([user_1, user_3])
      end
    end
    describe '.default_users' do
      it 'returns all default users' do
        #Default Users
        user_1 = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
        zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 0, enabled: true)
        user_2 = User.create(name: 'User Two', street: 'Street Two', city: 'City Two', state: 'State2',
        zip: 'ZIP2', email: 'email2@aol.com', password: 'password2', role: 0, enabled: true)
        user_3 = User.create(name: 'User Three', street: 'Street Three', city: 'City Three', state: 'State3',
        zip: 'ZIP3', email: 'email3@aol.com', password: 'password3', role: 0, enabled: false)
        user_4 = User.create(name: 'User Four', street: 'Street Four', city: 'City Four', state: 'State4',
        zip: 'ZIP4', email: 'email4@aol.com', password: 'password4', role: 0, enabled: true)
        #Merchant User
        user_5 = User.create(name: 'User Five', street: 'Street Five', city: 'City Five', state: 'State5',
        zip: 'ZIP5', email: 'email5@aol.com', password: 'password5', role: 1, enabled: true)
        #Admin User
        user_6 = User.create(name: 'User Six', street: 'Street Six', city: 'City Six', state: 'State6',
        zip: 'ZIP6', email: 'email6@aol.com', password: 'password6', role: 2, enabled: true)

        expect(User.default_users).to eq([user_1, user_2, user_3, user_4])
      end
    end

    describe '.merchants_by_quantity' do
      it 'should return the top three merchants by quantity of items sold' do
        merchant_1 = create(:merchant)
        4.times do
          create(:fulfilled_order_item, item: create(:item, user: merchant_1))
        end
        
        merchant_2 = create(:merchant)
        create(:fulfilled_order_item, item: create(:item, user: merchant_2))
        create(:fulfilled_order_item, item: create(:item, user: merchant_2))
        
        merchant_3 = create(:merchant)
        
        merchant_4 = create(:merchant)
        3.times do
          create(:fulfilled_order_item, item: create(:item, user: merchant_4))
        end
        create(:unfulfilled_order_item, item: create(:item, user: merchant_4))
        create(:unfulfilled_order_item, item: create(:item, user: merchant_4))
        
        merchant_5 = create(:merchant)
        create(:fulfilled_order_item, item: create(:item, user: merchant_5))
        
        merchant_6 = create(:merchant, enabled: false)
        5.times do
          create(:fulfilled_order_item, item: create(:item, user: merchant_6))
        end
        
        expect(User.merchants_by_quantity).to eq([merchant_1, merchant_4, merchant_2])
      end
    end
    describe '.merchants_by_price' do
      it 'should return top three merchants by total price of items sold' do
        merchant_1 = create(:merchant)
        4.times do
          create(:fulfilled_order_item, item: create(:item, user: merchant_1),  order_price: 500)
        end
        
        merchant_2 = create(:merchant)
        create(:fulfilled_order_item, item: create(:item, user: merchant_2), order_price: 4000)
        create(:fulfilled_order_item, item: create(:item, user: merchant_2), order_price: 5000)
        
        merchant_3 = create(:merchant)
        
        merchant_4 = create(:merchant)
        3.times do
          create(:fulfilled_order_item, item: create(:item, user: merchant_4),  order_price: 100)
        end
        create(:unfulfilled_order_item, item: create(:item, user: merchant_4))
        create(:unfulfilled_order_item, item: create(:item, user: merchant_4))
        
        merchant_5 = create(:merchant)
        create(:fulfilled_order_item, item: create(:item, user: merchant_5), order_price: 10000)
        
        merchant_6 = create(:merchant, enabled: false)
        5.times do
          create(:fulfilled_order_item, item: create(:item, user: merchant_6), order_price: 10000)
        end
        
        expect(User.merchants_by_price).to eq([merchant_5, merchant_2, merchant_1])
      end
    end
    describe '.merchants_by_time' do
      it 'should return merchants sorted by average fulfillment time ascending' do
        merchant_1 = create(:merchant)
        create(:fulfilled_order_item, item: create(:item, user: merchant_1), created_at: 1.day.ago)
        create(:fulfilled_order_item, item: create(:item, user: merchant_1), created_at: 1.hour.ago)
        create(:unfulfilled_order_item, item: create(:item, user: merchant_1), created_at: 1.minute.ago)
        
        merchant_2 = create(:merchant)
        create(:fulfilled_order_item, item: create(:item, user: merchant_2), created_at: 2.hours.ago)
        create(:fulfilled_order_item, item: create(:item, user: merchant_2), created_at: 2.hours.ago)
        
        merchant_3 = create(:merchant)
        create(:fulfilled_order_item, item: create(:item, user: merchant_3), created_at: 2.days.ago)
        create(:fulfilled_order_item, item: create(:item, user: merchant_3), created_at: 3.days.ago)
        create(:fulfilled_order_item, item: create(:item, user: merchant_3), created_at: 3.days.ago)
        
        merchant_4 = create(:merchant)
        create(:fulfilled_order_item, item: create(:item, user: merchant_4), created_at: 4.days.ago)
        
        merchant_5 = create(:merchant, enabled: false)
        create(:fulfilled_order_item, item: create(:item, user: merchant_5), created_at: 1.minute.ago)
        
        
        sorted_merchants = [merchant_2, merchant_1, merchant_3, merchant_4]
        
        expect(User.merchants_by_time).to eq(sorted_merchants)
      end
    end
  end
  
  describe 'Instance Methods' do
    describe '#enabled_toggle' do
      it 'toggles a user between enabled and disabled states' do
        user = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
          zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 0, enabled: true)
        user.enabled_toggle
        expect(user.enabled).to eq(false)
        user.enabled_toggle
        expect(user.enabled).to eq(true)
      end
    end
  end
end
