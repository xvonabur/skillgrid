require 'rails_helper'

RSpec.feature 'Guest navigates to products page', type: :feature do
  before do
    @products = []
    5.times { @products << create(:product) }

    visit products_path
  end

  scenario 'by clicking on button' do
    product = @products.first

    find("#product_#{product.id}_show").click

    expect(current_path).to eq(product_path(product))
    expect(page).to have_content(product.title)
    expect(page).to have_content(product.description)
    @products[1..-1].each do |product|
      expect(page).not_to have_content(product.title)
      expect(page).not_to have_content(product.description)
    end
  end
end
