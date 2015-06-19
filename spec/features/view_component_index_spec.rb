require 'rails_helper'

feature 'signed-in user' do
  
  let(:category)  { Fabricate(:category) }
  let!(:component) { Fabricate(:component, category: category) }

  scenario 'can view component index' do
    visit components_path
    expect(page).to have_content(component.name)
  end
end