class Order
	def initialize(expected)
		@expected_total = expected
		@items={}
	end

	def items
		@items
	end

	def expected_total
		@expected_total
	end

	def add_item(item_key, quantity)
		if @items.key?(item_key)
			@items[item_key]+=quantity
		else
			@items[item_key]=quantity
		end	
	end

	def total_items
		@items.values.inject(:+)
	end

 	def your_order 
	 	@items.keys.each do |key|
	 	 puts "#{key} - #{@items[key]}"
	 	end
	 	 puts "total items = #{total_items}"
	 	
	 	 @items
	end

end