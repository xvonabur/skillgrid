require 'rails_helper'

RSpec.feature 'User logs in and logs out', type: :feature do
  before do
    visit '/'
    find('#user-sign-in-link').click
  end

  scenario 'and sees a log in form at start' do
    expect(page).to have_content('Войти')
  end

  scenario 'logs in with correct details' do
    user = create(:user, email: 'someone@example.com')

    login user.email, user.password

    expect(current_path).to eq admin_products_path
    expect(page).to have_content 'Вход в систему выполнен'
    expect(page).to have_content user.name
  end

  scenario 'logs out', js: true do
    user = create(:user, email: 'someone@example.com')

    login user.email, user.password
    find('#user-dropdown-menu').click
    find('#user-logout-link').click

    expect(current_path).to eq products_path
    expect(page).to have_content 'Выход из системы выполнен'
    expect(page).not_to have_content 'someone@example.com'
  end

  scenario 'locks account after 3 failed attempts' do
    email = 'someone@example.com'
    create(:user, email: email)

    login email, '1st-try-wrong-password'
    expect(page).to have_content 'Неверные email или пароль'

    login email, '2nd-try-wrong-password'
    expect(page).to have_content 'У Вас осталась еще одна попытка ввести пароль до блокировки'

    login email, '3rd-try-wrong-password'
    expect(page).to have_content 'Ваша учётная запись заблокирована'
  end

  private
    def login(email, password)
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      click_button 'sign_in_submit_btn'
    end
end