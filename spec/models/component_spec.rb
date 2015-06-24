require 'rails_helper'

describe Component do

  it { should belong_to(:category) }
  it { should have_many(:properties) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:manufacturer) }
  it { should validate_presence_of(:description) }

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
end