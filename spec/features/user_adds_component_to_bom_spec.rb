require 'rails_helper'

feature 'user adds components to a BOM: ' do
  
  let(:category) { Fabricate(:category, name: 'Capacitors') }
  let(:component) { Component.first }

  before do
    Fabricate.times(3, :component, category: category)
  end

  scenario 'add library component to new BOM' do
    sign_in_user
    visit(components_path)
    within_table('components') do
      first("input[type='checkbox']").set(true)
    end
    select('Create new', from: 'bom[id]')
    click_button('Add selected to BOM')
    expect(page.current_path).to eq bom_path(Bom.last)
    expect(page.find('.alert-success')).to be_present
  end

  scenario 'add two library components to same BOM' do
    sign_in_user
    visit(components_path)
    within_table('components') do
      first("input[type='checkbox']").set(true)
    end
    select('Create new', from: 'bom[id]')
    click_button('Add selected to BOM')
    expect(page.current_path).to eq bom_path(Bom.last)
    expect(page.find('.alert-success')).to be_present
    visit(components_path)
    within_table('components') do
      first("input[type='checkbox']").set(true)
    end
    select('New BOM', from: 'bom[id]')
    click_button('Add selected to BOM')
    expect(page.current_path).to eq bom_path(Bom.last)
    expect(page.find('.alert-success')).to be_present
  end
end