require 'rails_helper'

RSpec.feature 'Signed in user does see pro products', type: :feature do
  before do
    @product = create(:product, pro: false)
    @pro_product = create(:product, pro: true)

    visit '/'
    find('#user-sign-in-link').click
  end

  scenario 'admin case' do
    @admin = create(:admin)
    login @admin.email, @admin.password

    expect(page).to have_css('#products-table tbody tr', count: 2)
    expect(page).to have_content(@product.title)
    expect(page).to have_content(@pro_product.title)
  end

  scenario 'shop owner case' do
    @shop_owner = create(:shop_owner)
    login @shop_owner.email, @shop_owner.password

    expect(page).to have_css('#products-table tbody tr', count: 2)
    expect(page).to have_content(@product.title)
    expect(page).to have_content(@pro_product.title)
  end

  scenario 'guest case' do
    @guest = create(:guest)
    login @guest.email, @guest.password

    expect(page).to have_css('#products-table tbody tr', count: 2)
    expect(page).to have_content(@product.title)
    expect(page).to have_content(@pro_product.title)
  end
end
