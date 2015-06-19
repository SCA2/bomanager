require 'rails_helper'

feature 'landing page' do
  
  scenario 'discovered by any user' do
    visit root_path
    expect(page.current_path).to eq '/'
    expect(page).to have_content('BOManager')
  end

end

