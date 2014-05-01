require "takeaway"

describe Takeaway do 
	let(:takeaway) {Takeaway.new}
	let(:new_order) {double :new_order, total_items: 10, expected_total: 10}
	let(:bad_order) {double :new_order, total_items: 10, expected_total: 20}
	let(:second_order) {double :second_order}
	let(:twilio){ double :twilio}
	let(:menu_1){double :menu, name:"starter"}
	let(:estimated_quantity1){10}
	let(:estimated_quantity2){15}
	

	context "intialised takeaway" do
		it "should have no orders after creation " do
		  expected = takeaway.orders
			expect(expected.length).to eq 0
		end

		it "should have no initial menu" do
		  expect(takeaway.menus.length).to eq 0
		end

		it "should can add a menu to the menus" do
		  takeaway.add_menu(menu_1)
		  expect(takeaway.menus.length).to eq 1
		end

		it "should contain uniquely named menus" do
			menu_2 = double :menu, name: "starter"
		  takeaway.add_menu(menu_1)
		  takeaway.add_menu(menu_2)
		  expect(takeaway.menus.length).to eq 1
		end

		it "should overwrite existing menus" do
			menu_2 = double :menu, name: "starter"
		  takeaway.add_menu(menu_1)
		  takeaway.add_menu(menu_2)
		  expect(takeaway.get_menu("starter")).to eq menu_2
		end

		it "should retrieve a menu" do
		  takeaway.add_menu(menu_1)
		  expect(takeaway.get_menu("starter")).to eq menu_1
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

		it "should remove orders in a FIFO queue" do
		  takeaway.add_order(new_order)
		  takeaway.add_order(second_order)
		  takeaway.make_next_order
		  expect(takeaway.make_next_order).to eq second_order
		end

		it "can compare confirm correct orders" do
			new_order.stub(:total_items).and_return(estimated_quantity1)
		  expect(takeaway.correct_order?(new_order)).to be_true
		end

		it "can confirm incorrect order totals" do
		  expect(takeaway.correct_order?(bad_order)).not_to be_true
		end

		it "should send out a text if the order is correct" do
			expect(takeaway).to receive(:send_text)
			takeaway.process_order(new_order)
		end

		it "should raise an error when incorrect totals are given" do
			expect{takeaway.process_order(bad_order)}.to raise_error "Incorrect Quantity"
		end

		it "can take multiple orders" do
			takeaway.stub(:gets).and_return("7: Pasta, 2; Cheese, 5")
			takeaway.stub(:send_confirmation).and_return (true)
			takeaway.get_order
			takeaway.get_order
			expect(takeaway.orders.count).to eq 2
		end

	end

end