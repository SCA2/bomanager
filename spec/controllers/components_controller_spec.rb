require 'rails_helper'

describe ComponentsController do

  context "with authenticated user" do

    before { set_current_user }

    describe "GET index" do
      it "sets @categories variable" do
        category = Fabricate(:category)
        get :index
        expect(assigns(:categories)).to eq [category]
      end
    end

    describe "GET show" do
      let(:component)   { Fabricate(:component) }
      let(:property_1)  { Fabricate(:property, component: component) }
      let(:property_2)  { Fabricate(:property, component: component) }

      it "sets @component variable" do
        get :show, id: component.id
        expect(assigns(:component)).to eq component
      end

      it "sets @properties variable" do
        get :show, id: component.id
        expect(assigns(:properties)).to include property_1, property_2
      end
    end

  #   describe "GET search" do
  #     it "sets @components variable" do
  #       a =   Fabricate(:component, name: 'a')
  #       b1 =  Fabricate(:component, name: 'b1')
  #       b2 =  Fabricate(:component, name: 'b2')
  #       c =   Fabricate(:component, name: 'c')
  #       get :search, query: 'b'
  #       expect(assigns(:components)).to eq [b1, b2]
  #     end
  #   end
  end
  
  context "with unauthenticated user" do
    describe "GET index" do
      it_behaves_like 'requires sign in' do
        let(:action) { get :index }
      end
    end

    describe "GET show" do
      it_behaves_like 'requires sign in' do
        let(:action) { get :show, id: 0 }
      end
    end

    # describe "GET search" do
    #   it_behaves_like 'requires sign in' do
    #     let(:action) { get :search, query: nil }
    #   end
    # end
  end
end
