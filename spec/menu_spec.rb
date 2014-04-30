require "menu"

describe Menu do

	let(:dish){double :dish, name: 'Fish', price: 4, format: "Fish - £4" }
	let(:menu){Menu.new}
  it "should have no dishes when created" do
    expect(menu.items.length).to eq 0
  end

  it "can have items added" do
    menu.add(dish)
    expect(menu.items.length).to eq 1
  end

  it "should retrieve an item based on name" do
    menu.add(dish)
    expect(menu.item('Fish')).to be_true
  end

  it "should retrieve the correct item" do
    menu.add(dish)
    expect(menu.item('Fish').name).to eq 'Fish'
  end

  it "should return the a price based on the name" do
    menu.add(dish)
    expect(menu.price('Fish')).to eq 4
  end

  it "should return the a price based on the name" do
    menu.add(dish)
    expect(menu.price('Fish')).to eq 4
  end

  it "should return the a price based on the name" do
    dish2 = double :dish2, name:'Chips', price: 2
    menu.add(dish)
    menu.add(dish2)
    expect(menu.price('Chips')).to eq 2
  end

  it "can should overwrite an entry with the same name" do
  	 dish3 = double :double, name: 'Fish', price: 5
  	 menu.add(dish)
  	 menu.add(dish3)
  	 expected = menu.item('Fish')
  	 expect(expected.price).to eq 5
  end

  it "can delete a dish" do
  	menu.remove('Fish')
  	expect(menu.items.length).to eq 0
  end

  it "should can return a formatted string of the menu" do
  	dish4 = double :double, name: 'Pasta', price: 5, format: "Pasta - £5"
  	menu.add(dish)
  	menu.add(dish4)
    expect(menu.read_menu).to eq ["Fish - £4", "Pasta - £5"]
  end


end