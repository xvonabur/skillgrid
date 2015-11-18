require 'rails_helper'

RSpec.feature 'Not signed in user does not see pro products', type: :feature do
  before do
    @product = create(:product, pro: false)
    @pro_product = create(:product, pro: true)

    visit '/'
    within('#sidebar-products-menu') do
      find('#all_products').click
    end
  end

  scenario 'only ordinary ones' do
    expect(page).to have_css('#products-table tbody tr', count: 1)
    expect(page).to have_content(@product.title)
    expect(page).not_to have_content(@pro_product.title)
  end
end
