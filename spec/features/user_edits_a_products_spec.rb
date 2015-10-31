require 'rails_helper'

RSpec.feature 'User edits a product', type: :feature do
  before do
    user = create(:user)
    @product = create(:product)
    visit new_user_session_path

    login user.email, user.password
    find("#product_#{ @product.id }_edit").click
  end

  scenario 'and sees an image on the form' do
    expect(page).to have_css("img[src*='#{ @product.photo.image.name }']")
  end

  scenario 'and removes an image' do
    find('#product_photo_attributes_remove_image').click
    find('#edit_product_submit').click

    expect(@product.reload.photo.image).to eq(nil)
  end

  scenario 'and changes title' do
    new_title = 'Another cool title'

    fill_in 'product_title', with: new_title
    find('#edit_product_submit').click

    expect(current_path).to eq(admin_products_path)
    expect(page).to have_content(new_title)
    expect(page).not_to have_content(@product.title)
  end

  scenario 'and changes description' do
    new_desc = 'Another cool description'

    fill_in 'product_description', with: new_desc
    find('#edit_product_submit').click

    expect(current_path).to eq(admin_products_path)
    expect(page).to have_content(new_desc)
    expect(page).not_to have_content(@product.description)
  end


end
