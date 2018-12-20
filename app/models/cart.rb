class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def add_item(item_id)
    @contents[item_id.to_s] ||= 0
    @contents[item_id.to_s] += 1
  end

end
