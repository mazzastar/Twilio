class Dish

	attr_reader :name, :price

	def initialize(name, price)
		@name=name
		@price = price		
	end

	def format
		"#{@name} - £#{@price}"
	end

	def update_price(price)
		@price = price
	end

	def update_name(name)
		@name = name	
	end

end