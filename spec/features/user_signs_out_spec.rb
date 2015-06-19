require 'rails_helper'

feature 'user signs out' do

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

