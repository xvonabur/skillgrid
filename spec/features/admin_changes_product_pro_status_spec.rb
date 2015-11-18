require 'rails_helper'

RSpec.feature 'Admin changes product pro status', type: :feature do
  before do
    user = create(:admin)
    @product = create(:product, pro: false)
    @pro_product = create(:product, pro: true)

    visit new_user_session_path
    login user.email, user.password
    within('#sidebar-products-menu') do
      find('#all_products').click
    end

  end

  scenario 'to pro' do
    find("#product_#{@product.id}_edit").click
    check 'product_pro'

    expect { click_button 'edit_product_submit' }.to change {
      @product.reload.pro
    }
    expect(page).to have_content('PRO', count: 2)
    expect(current_path).to eq(products_path)
  end

  scenario 'to not pro' do
    find("#product_#{@pro_product.id}_edit").click
    uncheck 'product_pro'

    expect { click_button 'edit_product_submit' }.to change {
      @pro_product.reload.pro
    }
    expect(page).not_to have_content('PRO')
    expect(current_path).to eq(products_path)
  end

end
