require 'rails_helper'

describe 'as any user' do
  before(:each) do
    @item_1 = create(:item) #add a times loop to build these?
    @item_2 = create(:item)
    @item_3 = create(:item)
    @item_4 = create(:item)
    @item_5 = create(:item)
    @item_6 = create(:item)
    @item_7 = create(:item)
    @order_item_1 = create(:fulfilled_order_item, item: @item_1) #add a times loop to build these?
    @order_item_2 = create(:fulfilled_order_item, item: @item_1)
    @order_item_3 = create(:fulfilled_order_item, item: @item_1)
    @order_item_3 = create(:fulfilled_order_item, item: @item_1)
    @order_item_3 = create(:fulfilled_order_item, item: @item_3)
    @order_item_3 = create(:fulfilled_order_item, item: @item_3)
    @order_item_3 = create(:fulfilled_order_item, item: @item_3)
    @order_item_3 = create(:fulfilled_order_item, item: @item_2)
    @order_item_3 = create(:fulfilled_order_item, item: @item_2)
    @order_item_3 = create(:fulfilled_order_item, item: @item_4)
    @order_item_3 = create(:fulfilled_order_item, item: @item_4)
    @order_item_3 = create(:fulfilled_order_item, item: @item_6)
    @order_item_3 = create(:fulfilled_order_item, item: @item_6)
    @order_item_3 = create(:fulfilled_order_item, item: @item_5)
    @order_item_3 = create(:fulfilled_order_item, item: @item_7)
  end
  describe 'when I visit the items index page' do
    it 'should see an area with item statistics, including the top 5 and bottom 5 popular items' do


      visit items_path

      expect(page).to have_content('Item Statistics')

      within('#top-five-items') do
        expect(page).to have_content("#{@item_1.name}")
        expect(page).to have_content("#{@item_3.name}")
        expect(page).to have_content("#{@item_2.name}")
        expect(page).to have_content("#{@item_4.name}")
        expect(page).to have_content("#{@item_6.name}")
        expect(page).to_not have_content("#{@item_5.name}")
        expect(page).to_not have_content("#{@item_7.name}")
      end

      within('#bottom-five-items') do
        expect(page).to have_content("#{@item_7.name}")
        expect(page).to have_content("#{@item_6.name}")
        expect(page).to have_content("#{@item_5.name}")
        expect(page).to have_content("#{@item_4.name}")
        expect(page).to have_content("#{@item_2.name}")
        expect(page).to_not have_content("#{@item_3.name}")
        expect(page).to_not have_content("#{@item_1.name}")
      end
    end
  end
end
