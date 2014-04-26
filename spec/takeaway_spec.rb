require "takeaway"

describe Takeaway do 
	context "initialised takeaway" do
		it "should return a list of prices" do
		  takeaway = Takeaway.new
		  expect{takeaway.price_list}.to be_true
		end

		it "should be able to access the prices" do
			takeaway = Takeaway.new
			price = (takeaway.price('Pasta'))
			expect(price).not_to be_nil
		end

		it "should be return the price of Pasta" do
			takeaway = Takeaway.new
			price = (takeaway.price('Pasta'))
			expect(price).to eq 5
		end	

		it "should be return the price of Pizza" do
		  takeaway = Takeaway.new
		  price = (takeaway.price('Pizza'))
		  expect(price).to eq 6
		end
	end

	context "it should take an order "


end