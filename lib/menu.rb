class Menu

	attr_reader :items
	attr_reader :name

	def initialize(name)
		@name = name
		@items = {}		
	end

	def add(dish)
		@items[dish.name]=dish
	end

	def item(name)
		@items[name]
			
	end

	def price(name)
		@items[name].price
	end

	def remove(name)
			@items.delete(name)		
	end	

	def read_menu
		puts "Menu list"
		puts "*"*20
		formatted_menu = []
		items.each{|key, value| formatted_menu << value.format}
		formatted_menu
	end


end
