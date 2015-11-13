require 'rails_helper'

RSpec.feature 'User uses control panel products paginator', type: :feature do
  before do
    @products = []
    12.times { @products << create(:product) }
    user = create(:user)

    visit '/'
    find('#user-sign-in-link').click
    login user.email, user.password
    visit products_path
  end

  scenario 'with default settings' do
    expect(page).to have_css('#products-table tbody tr', count: 10)
  end

  scenario 'by choosing next page' do
    find('.box-body .pagination .next a').click

    expect(page).to have_css('#products-table tbody tr', count: 2)
    @products[-2..-1].each do |product|
      expect(page).to have_content(product.title)
      expect(page).to have_content(product.description)
    end
    expect(page).to have_css('.content .pagination .next.disabled')
  end

  scenario 'by choosing previous page' do
    find('.box-body .pagination .next a').click
    find('.box-body .pagination .prev a').click

    expect(page).to have_css('#products-table tbody tr', count: 10)
    @products[0..9].each do |product|
      expect(page).to have_content(product.title)
      expect(page).to have_content(product.description)
    end
    expect(page).to have_css('.box-body .pagination .prev.disabled')
  end

end
