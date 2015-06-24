require 'rails_helper'

feature 'user signs in' do

  scenario 'with existing username and password' do
    user = Fabricate(:user)
    sign_in_user(user)
    expect(page.current_path).to eq "/home"
    expect(page).to have_content "#{user.name}"
    expect(page).to have_content "Signed in!"
  end

  scenario 'with unknown username or password' do
    user = Fabricate(:user, password: 'right')
    visit sign_in_path
    fill_in "Email Address", with: "#{user.email}"
    fill_in "Password", with: "wrong"
    click_button "Sign in"
    expect(page.current_path).to eq "/sign_in"
    expect(page).not_to have_content "#{user.name}"
    expect(page).to have_content "Email or password is invalid!"
  end
end

