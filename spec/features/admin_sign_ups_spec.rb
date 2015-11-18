require 'rails_helper'

RSpec.feature 'Admin sign ups', type: :feature do
  before do
    visit '/'
    find('#sign-up-dropdown').click
    find('#admin-sign-up-link').click
  end

  scenario 'with correct details' do
    fill_in_admin_data

    expect { click_button 'sign_up_submit_btn' }.to change {
     User.admins.count
    }.by(1)
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
        find_field('user_name', type: 'text').value
      ).to be_nil
      expect(
        find_field('user_last_name', type: 'text').value
      ).to be_nil
      expect(
        find_field('user_birthday', type: 'text').value
      ).to be_nil
      expect(
        find_field('user_avatar_attributes_image', type: 'file').value
      ).to be_nil
      expect(
        find_field('user_passport_attributes_image', type: 'file').value
      ).to be_nil
    end

    scenario 'blank fields on submit' do
      click_button 'sign_up_submit_btn'

      expect { click_button 'sign_up_submit_btn' }.not_to change {
        User.admins.count
      }
      expect(page).to have_content('Email не может быть пустым', count: 1)
      expect(page).to have_content('Пароль не может быть пустым', count: 1)
      expect(page).to have_content('Имя не может быть пустым', count: 1)
      expect(page).to have_content('Фамилия не может быть пустым', count: 1)
      expect(page).to have_content('Паспорт не может быть пустым', count: 1)
      expect(page).to have_content('Дата рождения не может быть пустым', count: 1)
      expect(page).to have_content('Аватар не может быть пустым', count: 1)
    end

    scenario 'blank name' do
      fill_in_admin_data(name: '')

      expect { click_button 'sign_up_submit_btn' }.not_to change {
       User.admins.count
      }
      expect(page).to have_content('Имя не может быть пустым', count: 1)
    end

    scenario 'blank avatar and passport' do
      fill_in_admin_data(avatar: '', passport: '')

      expect { click_button 'sign_up_submit_btn' }.not_to change {
        User.admins.count
      }
      expect(page).to have_content('Аватар не может быть пустым', count: 1)
      expect(page).to have_content('Паспорт не может быть пустым', count: 1)
    end


    scenario 'incorrect password confirmation' do
      fill_in_admin_data(passwd: 'password1234',
                        passwd_confirm: 'not-matched-password')

      expect { click_button 'sign_up_submit_btn' }.not_to change {
        User.admins.count
      }
      expect(page).to have_content(
        'Подтверждение пароля не совпадает со значением поля Пароль', count: 1)
    end

    scenario 'already registered email' do
      create(:user, email: 'name@mail.com')

      fill_in_admin_data(email: 'name@mail.com')

      expect { click_button 'sign_up_submit_btn' }.not_to change {
        User.admins.count
      }
      expect(page).to have_content('Email уже существует', count: 1)
    end

    scenario 'invalid email' do
      fill_in_admin_data(email: 'invalid-email-for-testing')

      expect { click_button 'sign_up_submit_btn' }.not_to change {
        User.admins.count
      }
      expect(page).to have_content('Email имеет неверное значение', count: 1)
    end

    scenario 'too short password' do
      min_password_length = 10
      too_short_password = 'p' * (min_password_length - 1)
      fill_in_admin_data(passwd: too_short_password,
                        passwd_confirm: too_short_password)

      expect { click_button 'sign_up_submit_btn' }.not_to change {
        User.admins.count
      }
      expect(page).to have_content(
              'Пароль недостаточной длины (не может быть меньше 10 символов)',
              count: 1)
    end

  end


  private

  def fill_in_admin_data(name: 'Dale',
                         last_name: 'Cooper',
                         email: 'name@mail.com',
                         passwd: 'password1234',
                         passwd_confirm: 'password1234',
                         birthday: I18n.l(20.years.ago.to_date),
                         avatar: temp_image,
                         passport: temp_image)
    fill_in 'user_name', with: name
    fill_in 'user_last_name', with: last_name
    fill_in 'user_birthday', with: birthday
    fill_in 'user_email', with: email
    fill_in 'user_password', with: passwd
    fill_in 'user_password_confirmation', with: passwd_confirm
    attach_file('user[avatar_attributes][image]',
                avatar.respond_to?(:path) ? avatar.path : nil)
    attach_file('user[passport_attributes][image]',
                passport.respond_to?(:path) ? passport.path : nil)
  end

  def temp_image
    Dragonfly.app.generate(:plain, 300, 200, 'format': 'jpeg')
  end
end
