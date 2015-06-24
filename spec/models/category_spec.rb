require 'rails_helper'

describe Category do

  it { should validate_presence_of(:name) }
  it { should have_many(:components).order(:name) }

  it "retrieves categories in name order" do
    c = Fabricate(:category, name: 'Name c')
    b = Fabricate(:category, name: 'Name b')
    a = Fabricate(:category, name: 'Name a')
    expect(Category.all.sorted).to eq [a, b, c]
  end

end