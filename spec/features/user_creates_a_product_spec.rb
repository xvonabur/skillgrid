require 'rails_helper'

RSpec.feature 'User creates a product', type: :feature do
  before do
    user = create(:user)
    visit new_user_session_path

    login user.email, user.password
    find('#new_product').click
  end

  scenario 'and sees blank fields on load' do
    expect(find_field('product_title', type: 'text').value).to be_nil
    expect(find_field('product_description', type: 'text').value).to be_nil
    expect(
      find_field('product_photo_attributes_image', type: 'file').value
    ).to be_nil
  end

  scenario 'with correct details' do
    fill_in_product_data

    expect {
      click_button 'new_product_submit'
    }.to change { Product.count }.by(1)
    expect(current_path).to eq(admin_products_path)
    expect(page).to have_css("img[src*='lightsaber']")
  end

  context 'with invalid details using' do

    scenario 'blank fields on submit' do
      expect {
        click_button 'new_product_submit'
      }.not_to change { Product.count }
      within('.form-group.product_title') do
        expect(page).to have_content('не может быть пустым', count: 1)
      end
      within('.form-group.product_description') do
        expect(page).to have_content('не может быть пустым', count: 1)
      end
    end
  end


  private
  def fill_in_product_data(title: 'Lightsaber',
                           desc: 'This was the formal weapon of a Jedi Knight')
    fill_in 'product_title', with: title
    fill_in 'product_description', with: desc
    attach_file('product[photo_attributes][image]',
                Rails.root.join('spec/support/lightsaber.png'))
  end
end
