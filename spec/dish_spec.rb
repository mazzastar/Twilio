require "dish"

describe Dish do
	let(:dish){Dish.new('Pasta', 5)}

	it "should have a name" do
	  # dish = Dish.new('Pasta', 5)
	  expect(dish.name).to eq "Pasta"
	end

	it "should have a price" do
	  # dish = Dish.new('Pasta', 5)
	  expect(dish.price).to eq 5
	end

	it "should return a formatted string of the dish" do
	  expect(dish.format).to eq "Pasta - £5"
	end

	it "should can have its price altered" do
	  dish.update_price(1000)
	  expect(dish.price).to eq 1000
	end

	it "should be able to change its name if necessary" do
	  dish.update_name('Carbonara')
	  expect(dish.name).to eq 'Carbonara'
	end
  
end