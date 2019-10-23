require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end
  scenario "visit the home page and click 'Add to Cart' buttons for one of the products" do
    # ACT
    visit root_path
    first('article.product').find_button('Add').click
    # DEBUG
    sleep 5
    save_screenshot

    # VERIFY
    expect(page).to have_content 'My Cart (1)'
  end
end
