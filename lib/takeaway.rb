require_relative './twilio'

class Takeaway

	def initialize
		@price_list = {'Pasta' => 5, 'Pizza' => 6, 'Cheese' =>5, 'Apples' => 3}
		@total_number=0
		@quantities={}
	end

	def total_items
		@quantities.values.inject(:+)
	end

	def sub_cost
		@quantities.map{|key, quantity| @price_list[key]*quantity}
	end

	def your_order 
		@quantities.keys.each do |key|
			puts "#{key} - #{@quantities[key]}"
		end
		puts "total items = #{total_items}"
		puts "total cost = £#{total_cost}"
	end

	def total_cost
		sub_cost.inject(:+)
	end

	def price_list
			@price_list.each{|key, value| puts "#{key} costs £#{value}"}
			true
	end

	def print_order
			@quantities
	end

	def price(item_key)
		@price_list[item_key]
	end

	def add_order_entry(item_key, quantity)
		if @quantities.has_key?(item_key)
			@quantities[item_key]+=quantity	
		else
			@quantities[item_key]=quantity	
		end
	end

	def capture_input
		estimate_total = 10

		if estimate_total != total_items
			raise "unequal total"
		else
			send_confirmation
		end

	end

	def send_confirmation
		twilio = TwilioMessage.new
		twilio.send_text
	end

end

# # puts [2,3].count

 # x = {'A' => 2, 'B' => 2}

 # puts x.class == Hash
	# x= {}
 # puts x.nil?
# price_list = {'Pasta' => 5, 'Pizza' => 6}
# puts price_list['Pasta']
 # v = Takeaway.new
 # puts v.price('Pasta')