require "rails_helper"

feature "an unauthenticated user" do
  
  before(:each) do
    @item = Item.create(title: "Unicorn Roll",
                        description: "Good", 
                        price: 8, 
                        status: "active")
  end
  
  scenario "can view their cart" do
    visit items_path
    within ".right" do
      find(:link).click
    end
    
    expect(page).to have_content("Shopping Cart")
  end
  
  scenario "can add an item to their cart" do
    visit items_path
    first(:button, "Add To Cart").click
    
    expect(current_path).to eq(items_path)
    expect(page).to have_content("(1)")
  end
  
  scenario "can view the item on their cart page" do
    visit items_path
    first(:button, "Add To Cart").click
    within ".right" do
      find(:link).click
    end
    
    expect(current_path).to eq(cart_path)
    expect(page).to have_content("Unicorn Roll")
  end
  
  scenario "can add more than one item to their cart" do
    visit items_path
    first(:button, "Add To Cart").click
    first(:button, "Add To Cart").click
    
    expect(current_path).to eq(items_path)
    expect(page).to have_content("(2)")
  end
  
  scenario "the line-item price of the item will change based on the quantity" do
    visit items_path
    first(:button, "Add To Cart").click
    first(:button, "Add To Cart").click
    within ".right" do
      find(:link).click
      end
    
    expect(current_path).to eq(cart_path)
    expect(page).to have_content("$16")
  end
end