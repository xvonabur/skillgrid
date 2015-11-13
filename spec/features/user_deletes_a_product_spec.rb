require 'rails_helper'

RSpec.feature 'User deletes a product', type: :feature do
  before do
    user = create(:user)
    @product = create(:product)
    visit new_user_session_path

    login user.email, user.password
  end

  scenario 'and sees a product index page with delete link' do
    expect(current_path).to eq(products_path)
    expect(page).to have_content(@product.title)
    expect(page).to have_content(@product.description)
    expect(page).to have_css("#product_#{@product.id}_del")
  end

  scenario 'by clicking on delete link' do
    expect {
      find("#product_#{@product.id}_del").click
    }.to change { Product.count }.by(-1)
    expect(page).not_to have_content(@product.title)
    expect(page).not_to have_content(@product.description)
  end
end
