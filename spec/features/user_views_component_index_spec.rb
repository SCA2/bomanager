require 'rails_helper'

feature 'user can view component index' do
  
  let(:category)  { Fabricate(:category) }
  let!(:component) { Fabricate(:component, category: category) }

  scenario 'user signed in' do
    sign_in_user
    visit components_path
    expect(page).to have_content(component.name)
  end

  scenario 'user not signed in' do
    visit components_path
    expect(page).not_to have_content(component.name)
  end
end