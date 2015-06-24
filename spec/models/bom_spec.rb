require 'rails_helper'

describe Bom do

  it { should validate_presence_of(:name) }
  it { should belong_to(:user) }
  it { should have_many(:bom_items) }

end