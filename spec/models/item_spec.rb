require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to(:user)}
    it { should have_many(:orders).through(:order_items)}
  end
end
