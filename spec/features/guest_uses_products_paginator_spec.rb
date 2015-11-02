require 'rails_helper'

RSpec.feature 'Guest uses products paginator', type: :feature do
  before do
    @products = []
    12.times { @products << create(:product) }

    visit products_path
  end

  scenario 'with default settings' do
    expect(page).to have_css('section.content .thumbnail', count: 10)
  end

  scenario 'by choosing next page' do
    find('.content .pagination .next a').click

    expect(page).to have_css('section.content .thumbnail', count: 2)
    @products[-2..-1].each do |product|
      expect(page).to have_content(product.title)
      expect(page).to have_content(product.description)
    end
    expect(page).to have_css('.content .pagination .next.disabled')
  end

  scenario 'by choosing previous page' do
    find('.content .pagination .next a').click
    find('.content .pagination .prev a').click

    expect(page).to have_css('section.content .thumbnail', count: 10)
    @products[0..9].each do |product|
      expect(page).to have_content(product.title)
      expect(page).to have_content(product.description)
    end
    expect(page).to have_css('.content .pagination .prev.disabled')
  end

end
