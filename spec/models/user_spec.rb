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
    it { should validate_presence_of(:enabled)}
  end

  describe 'class methods' do
    describe '.enabled_merchants' do
      it 'return all enabled merchants' do
        user_1 = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
          zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 1, created_at: 1.days.ago)
        user_2 = User.create(name: 'User Two', street: 'Street Two', city: 'City Two', state: 'State2',
          zip: 'ZIP2', email: 'email2@aol.com', password: 'password2', role: 1, enabled: false, created_at: 2.days.ago)
        user_3 = User.create(name: 'User Three', street: 'Street Three', city: 'City Three', state: 'State3',
          zip: 'ZIP3', email: 'email3@aol.com', password: 'password3', role: 1, created_at: 3.days.ago)
        user_4 = User.create(name: 'User Four', street: 'Street Four', city: 'City Four', state: 'State4',
          zip: 'ZIP4', email: 'email4@aol.com', password: 'password4', created_at: 4.days.ago)

        expect(User.enabled_merchants).to eq([user_1, user_3])
        expect(User.enabled_merchants).not_to eq([user_2, user_4])
      end
    end
  end
  describe '.merchant?' do
    it 'should return all merchants' do
    user_1 = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
      zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 1, created_at: 1.days.ago)
    user_2 = User.create(name: 'User Two', street: 'Street Two', city: 'City Two', state: 'State2',
      zip: 'ZIP2', email: 'email2@aol.com', password: 'password2', role: 1, enabled: false, created_at: 2.days.ago)
    user_3 = User.create(name: 'User Three', street: 'Street Three', city: 'City Three', state: 'State3',
      zip: 'ZIP3', email: 'email3@aol.com', password: 'password3', role: 1, created_at: 3.days.ago)
    user_4 = User.create(name: 'User Four', street: 'Street Four', city: 'City Four', state: 'State4',
      zip: 'ZIP4', email: 'email4@aol.com', password: 'password4',  created_at: 4.days.ago)

      expect(User.merchant?.pluck(:name)).to eq([user_1.name, user_2.name, user_3.name])
      expect(User.merchant?.pluck(:name)).to_not eq([user_4.name])
    end
  end
end
