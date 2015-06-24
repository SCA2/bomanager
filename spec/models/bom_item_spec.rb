require 'rails_helper'

describe BomItem do
  it { should belong_to(:bom) }
  it { should belong_to(:component) }
  it { should validate_numericality_of(:quantity).only_integer }
  it { should validate_numericality_of(:quantity).is_greater_than(0) }

  describe '#component_name' do
    it 'returns name of the associated component' do
      bom = Fabricate(:bom)
      component = Fabricate(:component)
      bom_item = Fabricate(:bom_item, bom: bom, component: component)
      expect(bom_item.component_name).to eq component.name
    end
  end

  describe '#category_name' do
    it 'returns component category name' do
      bom = Fabricate(:bom)
      category = Fabricate(:category)
      component = category.components.first
      bom_item = Fabricate(:bom_item, bom: bom, component: component)
      expect(bom_item.category_name).to eq component.category.name
    end
  end

  describe '#category' do
    it 'returns component category' do
      bom = Fabricate(:bom)
      category = Fabricate(:category)
      component = category.components.first
      bom_item = Fabricate(:bom_item, bom: bom, component: component)
      expect(bom_item.category).to eq component.category
    end
  end

  # describe '#rating' do
  #   let(:bom) { Fabricate(:bom) }
  #   let(:component) { Fabricate(:component) }
  #   it 'returns rating if review present' do
  #     review = Fabricate(:review, bom: bom, component: component)
  #     bom_item = Fabricate(:bom_item, bom: bom, component: component)
  #     expect(bom_item.rating).to eq review.rating
  #   end
  #   it 'returns nil if no review present' do
  #     bom_item = Fabricate(:bom_item, bom: bom, component: component)
  #     expect(bom_item.rating).to eq nil
  #   end
  # end

  # describe '#rating=' do
  #   let(:bom) { Fabricate(:bom) }
  #   let(:component) { Fabricate(:component) }
  #   let(:bom_item) { Fabricate(:bom_item, bom: bom, component: component) }
  #   it 'has valid fabricators' do
  #     Fabricate(:review, bom: bom, component: component, rating: 1)
  #     expect(bom_item.rating).to eq 1
  #   end

  #   it 'updates review rating if review exists' do
  #     Fabricate(:review, bom: bom, component: component, rating: 1)
  #     bom_item.rating = 5
  #     expect(bom_item.reload.rating).to eq 5
  #   end
    
  #   it 'removes review rating if review exists' do
  #     Fabricate(:review, bom: bom, component: component, rating: 1)
  #     bom_item.rating = nil
  #     expect(bom_item.reload.rating).to be_nil
  #   end

  #   it 'creates review and rating if review does not exist' do
  #     bom_item.rating = 5
  #     expect(bom_item.reload.rating).to eq 5
  #   end
  # end

end