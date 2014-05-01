require_relative './twilio'
require_relative './order'
require_relative './menu'
require_relative './dish'

class Takeaway
	include TwilioMessage
	attr_reader :menus
	attr_reader :orders

	def initialize	
		@total_number=0
		@orders=[]
		@menus={}
	end

	def add_menu(menu)
		@menus[menu.name]=menu
	end

	def get_menu(name)
		@menus[name]
	end

	def add_order(new_order)
		@orders << new_order
	end

	def make_next_order
		order = @orders.shift
	end

	def correct_order?(new_order)
		new_order.total_items == new_order.expected_total
	end

	def process_order(new_order)	
			if correct_order?(new_order)	
				add_order(new_order)
				send_confirmation
			else
				raise "Incorrect Quantity"
			end			
	end
	
	def send_confirmation
		send_text
	end

	def get_order
		begin
			itemList = inputItems
			expectedTotal, itemString = splitTotal(itemList)
			new_order = Order.new(expectedTotal)

			splitItems(itemString).each do |string|
				item_key, quantity = string.split(',')
				new_order.add_item(item_key,quantity.to_i)
			end
			process_order(new_order)
		end
	end

	def print_orders
		puts "Orders"
		puts "*"*20
		@orders.each_with_index{|order, index| print_order(order, index)}
	end

	def print_order(order, index)
		puts "Order - #{index+1}"
		order.your_order
		puts "*"*20
	end

	def splitItems(itemString)
		items = itemString.split(';')
	end

	def splitTotal(string)
		total, itemsString = string.split(':')
		[total.to_i, itemsString.gsub(" ",'')]
	end

	def inputItems
		puts "Place order in format: <total expected>: <item1>, <quantity2>;<item2>, <quantity2>;... "
		orderString = gets.chomp
	end

end