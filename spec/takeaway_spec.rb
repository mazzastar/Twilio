require "takeaway"

describe Takeaway do 
	let(:takeaway) {Takeaway.new}
	let(:new_order) {double :new_order}
	let(:second_order) {double :second_order}
	let(:twilio){ double :twilio}
	context "intialised takeaway" do
		it "should have no orders after creation " do
		  expected = takeaway.orders
			expect(expected.length).to eq 0
		end

		it "can output a menu" do
		  expected = takeaway.menu
		  expect(expected).to be_true
		end

		it "can add an order" do
			takeaway.add_order(new_order)
			expect(takeaway.orders.length).to eq 1
		end

		it "can split an order string into an items array" do
		  item_array = takeaway.splitItems("Pasta, 2; Cheese, 5")
		  expect(item_array).to eq ["Pasta, 2", " Cheese, 5"]
		end

		it "should extract the expected total" do
		   total, item_array = takeaway.splitTotal("7: Pasta, 2; Cheese, 5")
		   expect(total).to eq 7
		end

		it "should extract the Items String" do
		   total, item_string = takeaway.splitTotal("7: Pasta, 2; Cheese, 5")
		   expect(item_string).to eq "Pasta,2;Cheese,5"
		end

		it "should extract the item key and Quantity" do
		   item_array = takeaway.splitItems("Pasta,2;Cheese,5")
		   expect(item_array).to eq ["Pasta,2", "Cheese,5"]
		end


		it "can process an order" do
			takeaway.add_order(new_order)
			expect(takeaway.make_next_order).to eq new_order
		end

		it "should expect orders left" do
		  takeaway.add_order(new_order)
		  takeaway.add_order(second_order)
		  takeaway.make_next_order
		  expect(takeaway.make_next_order).to eq second_order
		end

		it "can compare confirm correct orders" do
			estimated_quantity = 10
			new_order.stub(:total_items).and_return(10)
		  expect(takeaway.correct_order?(new_order, estimated_quantity)).to be_true
		end

		it "can confirm incorrect order totals" do
			estimated_quantity = 15
			new_order.stub(:total_items).and_return(10)
		  expect(takeaway.correct_order?(new_order, estimated_quantity)).not_to be_true
		end

		it "should send out a text if the order is correct" do
			estimated_quantity = 10
			new_order.stub(:total_items).and_return(10)
			expect(takeaway).to receive(:send_confirmation)
			takeaway.process_order(new_order, estimated_quantity)
		end

		it "should raise an error when incorrect totals are given" do
			estimated_quantity = 15
			new_order.stub(:total_items).and_return(10)
			expect{takeaway.process_order(new_order, estimated_quantity)}.to raise_error "Incorrect Quantity"
		end

		it "can take multiple orders" do

			takeaway.stub(:gets).and_return("7: Pasta, 2; Cheese, 5")
			takeaway.stub(:send_confirmation).and_return (true)
			takeaway.process_input
			takeaway.process_input
			expect(takeaway.orders.count).to eq 2
		end

	end

end