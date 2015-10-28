require 'rails_helper'

feature 'User sign ups' do
  before { visit new_user_registration_path }

  scenario 'with correct details' do
    fill_in_user_data

    expect { click_button 'sign_up_submit_btn' }.to change { User.count }.by(1)
  end


  context 'with invalid details using' do

    scenario 'blank fields on load' do
      expect(page).to have_field('user_email', with: '', type: 'email')
      # These password fields don't have value attributes in the generated HTML,
      # so with: syntax doesn't work.
      expect(find_field('user_password', type: 'password').value).to be_nil
      expect(find_field('user_password_confirmation', type: 'password').value).to be_nil
      expect(find_field('user_name', type: 'text').value).to be_nil
    end

    scenario 'blank fields on submit' do
    end

    scenario 'blank name' do
    end

    scenario 'incorrect password confirmation' do
    end

    scenario 'already registered email' do
    end

    scenario 'invalid email' do
    end

    scenario 'too short password' do
    end

  end


  private

  def fill_in_user_data(name: 'Dale Cooper',
                        email: 'name@mail.com',
                        passwd: 'password1234',
                        passwd_confirm: 'password1234')
    fill_in 'user_name', with: name
    fill_in 'user_email', with: email
    fill_in 'user_password', with: passwd
    fill_in 'user_password_confirmation', with: passwd_confirm

  end
end
