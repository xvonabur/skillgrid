def login(email, password)
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  click_button 'sign_in_submit_btn'
end