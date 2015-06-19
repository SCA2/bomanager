require 'rails_helper'

feature 'user signs up' do

  scenario 'with new username and password' do
    user = Fabricate.attributes_for(:user)
    visit sign_up_path
    fill_in "Name", with: "#{user[:name]}"
    fill_in "Email Address", with: "#{user[:email]}"
    fill_in "Password", with: "#{user[:password]}"
    click_button "Sign Up"
    # save_and_open_page
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

