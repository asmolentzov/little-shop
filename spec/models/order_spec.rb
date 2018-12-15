require "rails_helper"

RSpec.describe Order, type: :model do
  describe "relationships" do
    it { should belong_to(:user)}
    it { should have_many(:items).through(:order_items)}
  end
end
