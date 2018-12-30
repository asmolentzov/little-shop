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
        user_1 = create(:user)
        user_2 = create(:user)
        user_3 = create(:user)
        user_4 = create(:user)
        user_5 = create(:merchant)
        user_6 = create(:admin)

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

    describe '.top_states' do
      it 'should return the top three states where any orders were shipped' do
        user_1 = create(:user, state: 'CO')
        create(:fulfilled_order, user: user_1)
        create(:fulfilled_order, user: user_1)

        user_2 = create(:user, state: 'HI')
        create(:fulfilled_order, user: user_2)
        create(:fulfilled_order, user: user_2)
        create(:fulfilled_order, user: user_2)

        user_3 = create(:user, state: 'CA')
        create(:fulfilled_order, user: user_3)

        user_4 = create(:user, state: 'NY')

        user_5 = create(:user, state: 'HI')
        create(:fulfilled_order, user: user_5)

        user_6 = create(:user, state: 'AK')
        5.times do
          create(:fulfilled_order, user: user_6, status: 0 )
        end

        user_7 = create(:user, state: 'AK')
        5.times do
          create(:fulfilled_order, user: user_7, status: 2)
        end

        states = ['HI', 'CO', 'CA']

        expect(User.top_states).to eq(states)
      end
    end

    describe '.top_cities' do
      it 'should return the top three cities with the most orders shipped' do
        user_1 = create(:user, city: 'Springfield', state: 'CO')
        create(:fulfilled_order, user: user_1)
        create(:fulfilled_order, user: user_1)

        user_2 = create(:user, city: 'Honolulu', state: 'HI')
        4.times do
          create(:fulfilled_order, user: user_2)
        end

        user_3 = create(:user, city: 'Claremont', state: 'CA')
        create(:fulfilled_order, user: user_3)

        user_4 = create(:user, city: 'New York City', state: 'NY')

        user_5 = create(:user, city: 'Honolulu', state: 'HI')
        create(:fulfilled_order, user: user_5)

        user_6 = create(:user, city: 'Fairbanks', state: 'AK')
        6.times do
          create(:fulfilled_order, user: user_6, status: 0 )
        end

        user_7 = create(:user, city: 'Fairbanks', state: 'AK')
        6.times do
          create(:fulfilled_order, user: user_7, status: 2)
        end

        user_8 = create(:user, city: 'Springfield', state: 'MI')
        create(:fulfilled_order, user: user_8)
        create(:fulfilled_order, user: user_8)
        create(:fulfilled_order, user: user_8)

        cities = [['Honolulu', 'HI'], ['Springfield', 'MI'], ['Springfield', 'CO']]

        expect(User.top_cities).to eq(cities)
      end
    end
  end

  describe '#merchant_pending_orders' do
    it 'returns all pending orders for a merchant' do
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

      expect(merchant.merchant_pending_orders).to eq([order_1, order_3])
    end
  end

  describe 'merchant statistics instance methods' do
    before(:each) do
      @merchant_1 = create(:merchant)

      #All items belong to merchant_1. Total inventory = 300
      @item_1 = create(:item, inventory: 1, user: @merchant_1)
      @item_2 = create(:item, inventory: 2, user: @merchant_1)
      @item_3 = create(:item, inventory: 3, user: @merchant_1)
      @item_4 = create(:item, inventory: 4, user: @merchant_1)
      @item_5 = create(:item, inventory: 50, user: @merchant_1)
      @item_6 = create(:item, inventory: 60, user: @merchant_1)
      @item_7 = create(:item, inventory: 70, user: @merchant_1)
      @item_8 = create(:item, inventory: 110, user: @merchant_1)
      #Users from 6 states & 6 cities. Identical city names from two states.
      @user_1 = create(:user, city: 'Manhattan', state: 'KS')
      @user_2 = create(:user, city: 'Manhattan', state: 'KS')
      @user_3 = create(:user, city: 'Manhattan', state: 'NY')
      @user_4 = create(:user, city: 'Buttermilk', state: 'KS')
      @user_5 = create(:user, city: 'Brigham', state: 'UT')
      @user_6 = create(:user, city: 'Austin', state: 'NV')
      @user_7 = create(:user, city: 'Smackover', state: 'AK')

      #User_1 orders - Manhattan, KS -- 2nd shipped to city, 1st state
      order_1 = create(:order, user: @user_1)
        create(:fulfilled_order_item, order: order_1, item: @item_1, quantity: 1, order_price: 100)
        create(:fulfilled_order_item, order: order_1, item: @item_2, quantity: 2, order_price: 200)

      #User_2 orders - Manhattan, KS -- ANOTHER Manhattan, KS
      order_2 = create(:order, user: @user_2)
        create(:fulfilled_order_item, order: order_2, item: @item_1, quantity: 1, order_price: 100)
        create(:fulfilled_order_item, order: order_2, item: @item_2, quantity: 2, order_price: 300)
      order_3 = create(:order, user: @user_2)
        create(:fulfilled_order_item, order: order_3, item: @item_3, quantity: 3, order_price: 300)
      order_4 = create(:order, user: @user_2)
        create(:fulfilled_order_item, order: order_4, item: @item_4, quantity: 1, order_price: 400)

      #User_3 orders - Manhattan, NY -- Top shipped-to city, 2nd state
      order_5 = create(:order, user: @user_3)
        create(:fulfilled_order_item, order: order_5, item: @item_1, quantity: 1, order_price: 100)
        create(:fulfilled_order_item, order: order_5, item: @item_2, quantity: 2, order_price: 200)
      order_6 = create(:order, user: @user_3)
        create(:fulfilled_order_item, order: order_6, item: @item_3, quantity: 3, order_price: 300)
      order_7 = create(:order, user: @user_3)
        create(:fulfilled_order_item, order: order_7, item: @item_4, quantity: 1, order_price: 400)
      order_8 = create(:order, user: @user_3)
        create(:fulfilled_order_item, order: order_8, item: @item_5, quantity: 2, order_price: 500)
      order_9 = create(:order, user: @user_3)
        create(:fulfilled_order_item, order: order_9, item: @item_6, quantity: 3, order_price: 600)

      #User_4 orders - Buttermilk, KS -- 3rd shipped to city
      order_10 = create(:order, user: @user_4)
        create(:fulfilled_order_item, order: order_10, item: @item_1, quantity: 1, order_price: 100)
        create(:fulfilled_order_item, order: order_10, item: @item_2, quantity: 2, order_price: 200)
      order_11 = create(:order, user: @user_4)
        create(:fulfilled_order_item, order: order_11, item: @item_3, quantity: 2, order_price: 300)
      order_12 = create(:order, user: @user_4)
        create(:fulfilled_order_item, order: order_12, item: @item_4, quantity: 1, order_price: 400)

      #User_5 orders - Brigham, UT
      order_13 = create(:order, user: @user_5)
        create(:fulfilled_order_item, order: order_13, item: @item_1, quantity: 1, order_price: 100)
        create(:fulfilled_order_item, order: order_13, item: @item_2, quantity: 2, order_price: 200)
        create(:fulfilled_order_item, order: order_13, item: @item_3, quantity: 3, order_price: 300)
        create(:fulfilled_order_item, order: order_13, item: @item_4, quantity: 1, order_price: 400)
        create(:fulfilled_order_item, order: order_13, item: @item_5, quantity: 3, order_price: 550)
        create(:fulfilled_order_item, order: order_13, item: @item_6, quantity: 3, order_price: 650)
        create(:fulfilled_order_item, order: order_13, item: @item_7, quantity: 1, order_price: 13467)
        create(:fulfilled_order_item, order: order_13, item: @item_8, quantity: 1, order_price: 57500)

      #User_6 orders - Austin, NV -- 3rd shipped-to state
      order_14 = create(:order, user: @user_6)
        create(:fulfilled_order_item, order: order_14, item: @item_1, quantity: 2, order_price: 100)
        create(:fulfilled_order_item, order: order_14, item: @item_2, quantity: 2, order_price: 200)
      order_15 = create(:order, user: @user_6)
        create(:fulfilled_order_item, order: order_15, item: @item_7, quantity: 3, order_price: 12200)

      #User_7 orders - Smackover, AK
      order_16 = create(:order, user: @user_7)
        create(:fulfilled_order_item, order: order_16, item: @item_8, quantity: 2, order_price: 57500)
    end

    xdescribe 'merchant_top_five_items' do
      it 'returns the merchants top five items sold by quantity' do
        expect(@merchant_1.merchant_top_five_items).to eq([@item_3, @item_2, @item_1, @item_6, @item_5])
      end
    end
    describe 'merchant_units_sold' do
      it 'returns the total units the merchant has sold' do
        expect(@merchant_1.merchant_units_sold).to eq(52)
      end
    end
    describe 'merchant_units_inventory' do
      it 'returns the number of units of all items the merchant has in inventory' do
        expect(@merchant_1.merchant_units_inventory).to eq(300)
      end
    end
    describe 'merchant_percent_sold' do
      it 'returns the percentage of unit sales over inventory' do
        expect(@merchant_1.merchant_percent_sold).to eq(17)
      end
    end
    xdescribe 'merchant_top_states' do
      it 'returns the merchants top three states by orders shipped' do
        expect(@merchant_1.merchant_top_states).to eq(["KS", "NY", "NV"])
      end
    end
    xdescribe 'merchant_top_cities' do
      it 'returns the merchants top three cities by orders shipped' do
        expect(@merchant_1.merchant_top_cities).to eq(["Manhattan, NY", "Manhattan, KS", "Buttermilk, KS"])
      end
    end
    xdescribe 'merchant_top_order_user' do
      it 'returns the user with the most orders for the merchant' do
        expect(@merchant_1.merchant_top_order_user).to eq(@user_3)
      end
    end
    describe 'merchant_top_units_user' do
      it 'returns the user with the most units bought for the merchant' do
        @merchant_2 = create(:merchant)
        @merchant_3 = create(:merchant)

        @item_30 = create(:item, inventory: 1, user: @merchant_2)
        @item_31 = create(:item, inventory: 2, user: @merchant_2)
        @item_32 = create(:item, inventory: 3, user: @merchant_3)
        @item_33 = create(:item, inventory: 4, user: @merchant_3)

        order_20 = create(:order, user: @user_7)
        order_21 = create(:order, user: @user_7)

        create(:fulfilled_order_item, order: order_20, item: @item_30, quantity: 100, order_price: 100)
        create(:fulfilled_order_item, order: order_20, item: @item_31, quantity: 222, order_price: 200)
        create(:fulfilled_order_item, order: order_21, item: @item_32, quantity: 3, order_price: 300)
        create(:fulfilled_order_item, order: order_21, item: @item_33, quantity: 1, order_price: 400)


        expect(@merchant_1.merchant_top_units_user).to eq(@user_5)
      end
    end
    xdescribe 'merchant_highest_spending_users' do
      it 'returns the merchants 3 highest spending users' do
        expect(@merchant_1.merchant_highest_spending_users).to eq([@user_7, @user_5, @user_6])
      end
    end
  end

end
