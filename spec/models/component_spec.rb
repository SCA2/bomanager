require 'rails_helper'

describe Component do

  it { should belong_to(:category) }
  it { should have_many(:properties) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:manufacturer) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:last_priced) }
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

  describe "octopart_price" do
    it 'queries Octopart API for component price' do
      component = Fabricate(:component, name: '271-10K-RC')
      expect(component.octopart_price).to eq 29.6000
    end
  end

  describe "mouser_price"
  describe "digikey_price"

  describe "current_price" do
    it 'returns price less than 2 days old' do
    end
  end

end