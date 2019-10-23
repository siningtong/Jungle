require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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
  scenario "click one of the product partials in order to navigate directly to a product detail page" do
    # ACT
    visit '/products'
    first('article.product').find_link('Details').click    
    # DEBUG
   
    save_screenshot

    # VERIFY
    expect(page).to have_text 'Name'
  end
end
