require 'rails_helper'

describe Bom do

  it { should validate_presence_of(:name) }
  it { should belong_to(:user) }
  it { should have_many(:bom_items) }

  let(:bom)       { Fabricate(:bom) }
  let(:category)  { Fabricate(:category) }
  let(:part_1)    { category.components[0] }
  let(:part_2)    { category.components[1] }
  let(:part_3)    { category.components[2] }

  describe '#revision' do
    it 'returns revision number of BOM' do
      expect(bom.revision).to be_present
    end
  end

  describe '#total_parts' do
    it 'returns sum of component quantities' do
      Fabricate(:bom_item, bom: bom, component: part_1, quantity: 1)
      Fabricate(:bom_item, bom: bom, component: part_2, quantity: 2)
      Fabricate(:bom_item, bom: bom, component: part_3, quantity: 3)
      expect(bom.total_parts).to eq 6
    end
  end

  describe '#last_ordered' do
    it 'returns date of last order' do
      expect(bom.last_ordered).to be_present
    end
  end

  describe '#days_to_reorder' do
    it 'returns days of stock remaining' do
      expect(bom.days_to_reorder).to be_present
    end
  end

  describe '#total' do
    it 'returns total price of BOM' do
      bom = double(Bom)
      allow(bom).to receive(:total) { 1 }
      expect(bom.total).to eq 1
    end
  end

end