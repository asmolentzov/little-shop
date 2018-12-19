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
    it 'merchants' do
      user_1 = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
        zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 1)
      user_2 = User.create(name: 'User Two', street: 'Street Two', city: 'City Two', state: 'State2',
        zip: 'ZIP2', email: 'email2@aol.com', password: 'password2')
      user_3 = User.create(name: 'User Three', street: 'Street Three', city: 'City Three', state: 'State3',
        zip: 'ZIP3', email: 'email3@aol.com', password: 'password3', role: 1)

      expect(User.merchants).to eq([user_1, user_3])
    end 
  end
end
