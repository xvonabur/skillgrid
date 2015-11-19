require 'rails_helper'

RSpec.feature "Guest doesn't see shop name", type: :feature do
  before do
    @product = create(:product, pro: false)

    visit '/'
    find('#user-sign-in-link').click
    @guest = create(:guest)
    login @guest.email, @guest.password
  end

  scenario 'on products index page' do
    expect(page).not_to have_content(@product.user.shop_name)
  end

  scenario 'on products show page' do
    find("#product_#{ @product.id }_show").click
    expect(page).not_to have_content(@product.user.shop_name)
  end
end
