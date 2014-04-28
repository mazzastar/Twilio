require_relative '../lib/order'


describe Order do
  expectedTotal = 10
  let(:initial_order){Order.new(expectedTotal)}	
  context 'initialize order' do
  	it "should have no items when initialized" do
  	  expect(initial_order.items).to be_empty
  	end
  	
  	it "should return a list of items" do
  	  expect(initial_order.items).to be_true
  	end


  	it "can have an item added to the order" do
  	  initial_order.add_item("item", 1)
  	  expect(initial_order.items.length).to eq 1
  	end

  	it "can have add multiple items added to the order" do
  	  initial_order.add_item("item", 1)
  	  initial_order.add_item("item2", 1)
  	  expect(initial_order.items.length).to eq 2
  	end

  	it "should increment the item quantity if it exists" do
  	  initial_order.add_item("item", 2)
  	  initial_order.add_item("item", 1)
  	  expect(initial_order.items["item"]).to eq 3
  	end

  	it "should return a total" do
  	  initial_order.add_item("item", 1)
  	  initial_order.add_item("item2", 4)
  	  expect(initial_order.total_items).to eq 5
  	end

  	it "should return the order quantities" do
  	  initial_order.add_item("item", 1)
  	  initial_order.add_item("item2", 4)
  	  expect(initial_order.your_order).to be_true
  	end

  end


end