require 'rails_helper'

feature 'component library' do

  let!(:category) { Fabricate(:category) }
  let(:component) { category.components.first }

  describe 'user can view component index' do
    
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

  describe 'user can view component details' do

    scenario 'click on first component' do
      sign_in_user
      visit components_path
      within_table('components') do
        click_link(component.name)
      end
      expect(page.current_path).to eq component_path(component)
      expect(page.find('h3', text: component.name)).to be_present
    end

    scenario 'component view lists BOMs' do
      sign_in_user
      bom = Fabricate(:bom)
      bom_item = Fabricate(:bom_item, bom: bom, component: component)
      visit component_path(component)
      expect(page).to have_content(bom.name)
    end
  end

  describe 'user adds parts to a BOM: ' do
    
    scenario 'add library component to new BOM' do
      sign_in_user
      visit(components_path)
      within_table('components') do
        first("input[type='checkbox']").set(true)
      end
      select('New BOM', from: 'bom[id]')
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
      select('New BOM', from: 'bom[id]')
      click_button('Add selected to BOM')
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

end
