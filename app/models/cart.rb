class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents ||= Hash.new(0)
  end

  def add_item(item_id)
    @contents[item_id.to_s] ||= 0
    @contents[item_id.to_s] += 1
  end

  def grand_total
    total = 0
    @contents.each do |item_id, quantity|
      total += Item.find(item_id.to_i).current_price * quantity
    end
    total
  end
  
  def cart_count
    @contents.values.sum
  end
  
  def empty
    @contents.clear
  end
end
