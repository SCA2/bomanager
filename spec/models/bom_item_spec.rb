require 'rails_helper'

describe BomItem do
  it { should belong_to(:bom) }
  it { should belong_to(:component) }
  it { should validate_numericality_of(:quantity).only_integer }
  it { should validate_numericality_of(:quantity).is_greater_than(0) }

  let(:category)  { Fabricate(:category) }
  let(:component) { category.components.first }
  let(:bom_item)  { Fabricate(:bom_item, component: component) }
  
  describe '#component_name' do
    it 'returns name of the associated component' do
      expect(bom_item.component_name).to eq component.name
    end
  end

  describe '#category' do
    it 'returns component category' do
      expect(bom_item.category).to eq component.category
    end
  end

  describe '#manufacturer' do
    it 'returns component manufacturer' do
      expect(bom_item.manufacturer).to eq component.manufacturer
    end
  end

  describe '#current_price' do
    it 'returns component price' do
      expect(bom_item.current_price).to eq component.current_price
    end
  end

  describe '#current_distributor' do
    it 'returns component distributor' do
      expect(bom_item.current_distributor).to eq component.current_distributor
    end
  end

end