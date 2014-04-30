require_relative './twilio'
require_relative './order'
require_relative './order'

class Takeaway
	# MENU = {'Pasta' => 5, 'Pizza' => 6, 'Cheese' =>5, 'Apples' => 3}
	attr_reader :menus
	def initialize	
		@total_number=0
		@quantities={}
		@orders=[]
		@menus={}
	end

	def add_menu(name, menu)
		@menus[name]=menu
	end

	def get_menu(name)
		@menus[name]
	end

	def add_order(new_order)
		@orders << new_order
	end

	def inputItems
		puts "Place order in format: <total expected>: <item1>, <quantity2>;<item2>, <quantity2>;... "
		orderString = gets.chomp
	end

	def splitItems(itemString)
		items = itemString.split(';')
	end

	def splitTotal(string)
		total, itemsString = string.split(':')
		[total.to_i, itemsString.gsub(" ",'')]
	end

	def make_next_order
		order = @orders.shift
		order
	end

	def correct_order?(new_order, estimated_quantity)
		new_order.total_items == estimated_quantity
	end

	def process_order(new_order, estimated_quantity)
			if correct_order?(new_order, estimated_quantity)
				add_order(new_order)
				send_confirmation
			else
				puts "Incorrect Quantity"
				raise "Incorrect Quantity"
			end			
	end
	
	def send_confirmation
		twilio = TwilioMessage.new
		twilio.send_text
	end


	# def menu
	# 	# puts "Menu list"
	# 	# puts "*"*20

	# 	# MENU.each{|key, value| puts "#{key} - £#{value}"}
	# 	# MENU
	# end

	def orders
		@orders
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

	def process_input
		begin
			expectedTotal, itemString = splitTotal(inputItems)
			new_order = Order.new(expectedTotal)

			splitItems(itemString).each do |string|
				item_key, quantity = string.split(',')
				new_order.add_item(item_key,quantity.to_i)
			end
			process_order(new_order, expectedTotal)
		rescue
		  retry
		end
	end

	def print_menu    
	  puts "1. Show Menu"
	  puts "2. Show Orders"
	  puts "3. Remove Leading Order"
	  puts "4. Add Order"
	  puts "9. Exit"
	end

	def process(selection)
	  case selection
	  when "1"
	    menu
	  when "2"
	    print_orders
	  when "3"
	    make_next_order    
	  when "4"
	    process_input 
	  when "9"
	    exit
	  else
	    puts "I don't know what you mean, try again"
	  end
	end

	def interactive_menu  
	  loop do
	    print_menu        
	    process(STDIN.gets.chomp)
	  end
	end

end