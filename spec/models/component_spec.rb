require 'rails_helper'

describe Component do

  it { should belong_to(:category) }
  it { should have_many(:properties) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:manufacturer) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:distributor) }

  it "retrieves Components in name order" do
    c = Fabricate(:component, name: 'name c', description: 'Description c')
    b = Fabricate(:component, name: 'name b', description: 'Description b')
    a = Fabricate(:component, name: 'name a', description: 'Description a')
    expect(Component.all.sorted).to eq [a, b, c]
  end

  describe "search_by_name" do
    it "returns empty array on no match" do
      expect(Component.search_by_name("non-existent name")).to eq []
    end
    
    it "returns one Component for exact match" do
      component = Fabricate(:component, name: 'name')
      expect(Component.search_by_name("name")).to eq [component]
    end

    it "returns array of Components for partial matches" do
      a = Fabricate(:component, name: 'name a')
      b = Fabricate(:component, name: 'name b')
      c = Fabricate(:component, name: 'name c')
      expect(Component.search_by_name('name')).to eq [a, b, c]
    end

    it "ignores case" do
      a = Fabricate(:component, name: 'name a')
      b = Fabricate(:component, name: 'name b')
      c = Fabricate(:component, name: 'name c')
      expect(Component.search_by_name('NaMe')).to eq [a, b, c]
    end

    it "returns array of Components in name order" do
      c = Fabricate(:component, name: 'name c')
      b = Fabricate(:component, name: 'name b')
      a = Fabricate(:component, name: 'name a')
      expect(Component.search_by_name('name')).to eq [a, b, c]
    end

    it "returns empty array for empty search string" do
      c = Fabricate(:component, name: 'name c')
      b = Fabricate(:component, name: 'name b')
      a = Fabricate(:component, name: 'name a')
      expect(Component.search_by_name('')).to eq []
    end
  end

  describe "current_price" do
    it 'returns cached price if less than 2 days old' do
      component = Fabricate(:component, price: 0.50, last_priced: 1.day.ago)
      expect(component.current_price).to eq 0.50
    end

    it 'does not return cached price if more than 2 days old' do
      component = Fabricate(:component, price: 0.50, last_priced: 3.days.ago)
      expect(component.current_price).not_to eq 0.50
    end

    it 'returns octopart price if more than 2 days old' do
      component = Fabricate(:component, price: 0.50, last_priced: 3.days.ago)
      expect(component.current_price).to eq 1.2345
    end

    it 'caches octopart price if cache is more than 2 days old' do
      component = Fabricate(:component, price: 0.50, last_priced: 3.days.ago)
      expect(component.current_price).to eq component.price
    end

    it 'updates last_priced if cache is more than 2 days old' do
      component = Fabricate(:component, price: 0.50, last_priced: 3.days.ago)
      component.current_price
      expect(component.last_priced).to be > 1.minute.ago
    end
  end

  describe "current_distributor" do
    it 'returns cached distributor if less than 2 days old' do
      component = Fabricate(:component, distributor: 'Newark', last_priced: 1.day.ago)
      expect(component.current_distributor).to eq 'Newark'
    end

    it 'does not return cached distributor if more than 2 days old' do
      component = Fabricate(:component, distributor: 'Newark', last_priced: 3.days.ago)
      expect(component.current_distributor).not_to eq 'Newark'
    end

    it 'returns octopart distributor if more than 2 days old' do
      component = Fabricate(:component, distributor: 'Newark', last_priced: 3.days.ago)
      expect(component.current_distributor).to eq 'Verical'
    end

    it 'caches octopart distributor if cache is more than 2 days old' do
      component = Fabricate(:component, distributor: 'Newark', last_priced: 3.days.ago)
      expect(component.current_distributor).to eq component.distributor
    end

    it 'updates last_priced if cache is more than 2 days old' do
      component = Fabricate(:component, distributor: 'Newark', last_priced: 3.days.ago)
      component.current_distributor
      expect(component.last_priced).to be > 1.minute.ago
    end
  end

end