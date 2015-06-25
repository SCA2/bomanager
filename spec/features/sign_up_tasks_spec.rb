require 'rails_helper'

feature 'user behaviors: ' do

  describe 'user signs up' do
    scenario 'with new username and password' do
      user = Fabricate.attributes_for(:user)
      visit sign_up_path
      fill_in "Name", with: "#{user[:name]}"
      fill_in "Email Address", with: "#{user[:email]}"
      fill_in "Password", with: "#{user[:password]}"
      click_button "Sign Up"
      expect(page.current_path).to eq "/home"
      expect(page).to have_content "#{user[:name]}"
      expect(page).to have_content "Sign out"
    end

    scenario 'with existing email' do
      user = Fabricate(:user)
      visit sign_up_path
      fill_in "Name", with: "#{user[:name]}"
      fill_in "Email Address", with: "#{user[:email]}"
      fill_in "Password", with: "#{user[:password]}"
      click_button "Sign Up"
      expect(page.current_path).to eq "/users"
      expect(page).not_to have_content "#{user.name}"
      expect(page).to have_content "has already been taken"
    end
  end

  describe 'user signs in' do
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

  describe 'user signs out' do
    scenario 'with existing username and password' do
      user = Fabricate(:user)
      sign_in_user(user)
      expect(page.current_path).to eq "/home"
      expect(page).to have_content "#{user.name}"
      expect(page).to have_content "Signed in!"
      click_link "Sign out"
      expect(page.current_path).to eq "/"
      expect(page).not_to have_content "#{user.name}"
      expect(page).to have_content "Sign in"
    end
  end

end
