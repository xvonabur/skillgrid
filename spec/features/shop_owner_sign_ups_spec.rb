require 'rails_helper'

RSpec.feature 'Shop owner sign ups', type: :feature do
  before do
    visit '/'
    visit new_user_registration_path(type: 'shop_owner')
  end

  scenario 'with correct details' do
    fill_in_shop_owner_data

    expect { click_button 'sign_up_submit_btn' }.to change { User.count }.by(1)
  end

  scenario 'with existent shop' do
    shop = create(:shop)

    fill_in_shop_owner_data(shop_name: shop.name)

    expect { click_button 'sign_up_submit_btn' }.not_to change { Shop.count }
  end

  context 'with invalid details using' do

    scenario 'blank fields on load' do
      expect(page).to have_field('user_email', with: '', type: 'email')

      # These password fields don't have value attributes in the generated HTML,
      # so with: syntax doesn't work.
      expect(
        find_field('user_password', type: 'password').value
      ).to be_nil
      expect(
        find_field('user_password_confirmation', type: 'password').value
      ).to be_nil
      expect(
        find_field('user_avatar_attributes_image', type: 'file').value
      ).to be_nil
      expect(
        find_field('user_shop_attributes_name', type: 'text').value
      ).to be_nil
    end

    scenario 'blank fields on submit' do
      click_button 'sign_up_submit_btn'

      expect { click_button 'sign_up_submit_btn' }.not_to change { User.count }
      expect(page).to have_content('Email не может быть пустым', count: 1)
      expect(page).to have_content('Пароль не может быть пустым', count: 1)
      expect(page).to have_content('Аватар не может быть пустым', count: 1)
      expect(page).to have_content('Название магазина не может быть пустым',
                                    count: 1)
    end

    scenario 'blank shop name' do
      fill_in_shop_owner_data(shop_name: '')

      expect { click_button 'sign_up_submit_btn' }.not_to change { User.count }
      expect(page).to have_content('Название магазина не может быть пустым',
                                   count: 1)
    end

    scenario 'blank avatar' do
      fill_in_shop_owner_data(avatar: '')

      expect { click_button 'sign_up_submit_btn' }.not_to change { User.count }
      expect(page).to have_content('Аватар не может быть пустым', count: 1)
    end


    scenario 'incorrect password confirmation' do
      fill_in_shop_owner_data(passwd: 'password1234',
                         passwd_confirm: 'not-matched-password')

      expect { click_button 'sign_up_submit_btn' }.not_to change { User.count }
      expect(page).to have_content(
        'Подтверждение пароля не совпадает со значением поля Пароль', count: 1)
    end

    scenario 'already registered email' do
      create(:user, email: 'name@mail.com')

      fill_in_shop_owner_data(email: 'name@mail.com')

      expect { click_button 'sign_up_submit_btn' }.not_to change { User.count }
      expect(page).to have_content('Email уже существует', count: 1)
    end

    scenario 'invalid email' do
      fill_in_shop_owner_data(email: 'invalid-email-for-testing')

      expect { click_button 'sign_up_submit_btn' }.not_to change { User.count }
      expect(page).to have_content('Email имеет неверное значение', count: 1)
    end

    scenario 'too short password' do
      min_password_length = 8
      too_short_password = 'p' * (min_password_length - 1)
      fill_in_shop_owner_data(passwd: too_short_password,
                         passwd_confirm: too_short_password)

      expect { click_button 'sign_up_submit_btn' }.not_to change { User.count }
      expect(page).to have_content(
              'Пароль недостаточной длины (не может быть меньше 8 символов)',
              count: 1)
    end

  end


  private

  def fill_in_shop_owner_data(email: 'name@mail.com',
                              passwd: 'password1234',
                              passwd_confirm: 'password1234',
                              shop_name: 'Pretty good shop',
                              avatar: temp_image)
    fill_in 'user_email', with: email
    fill_in 'user_password', with: passwd
    fill_in 'user_password_confirmation', with: passwd_confirm
    fill_in 'user_shop_attributes_name', with: shop_name
    attach_file('user[avatar_attributes][image]',
                avatar.respond_to?(:path) ? avatar.path : nil)
  end

  def temp_image
    Dragonfly.app.generate(:plain, 300, 200, 'format': 'jpeg')
  end
end
