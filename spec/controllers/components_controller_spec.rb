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

      it "sets @component variable" do
        get :show, id: component.id
        expect(assigns(:component)).to eq component
      end
    end
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
  end

end
