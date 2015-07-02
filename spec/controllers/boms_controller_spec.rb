require 'rails_helper'

describe BomsController do

  context 'authenticated user' do

    before      { set_current_user }
    let(:user)  { controller.current_user }

    describe 'GET index' do
      it 'sets @boms to current_user queue' do
        user.boms << Fabricate(:bom)
        user.boms << Fabricate(:bom)
        get :index
        expect(assigns(:boms)).to match_array user.boms
      end

      it 'redirects to home path if no boms' do
        get :index
        expect(response).to redirect_to home_path
      end
    end

    describe 'POST create' do
      let!(:part_1) { Fabricate(:component, name: 'part_z') }
      let!(:part_2) { Fabricate(:component, name: 'part_a') }
      let!(:item_1) { Fabricate.attributes_for(:bom_item, quantity: 1, component: part_1) }
      let!(:item_2) { Fabricate.attributes_for(:bom_item, quantity: 1, component: part_2) }
      let!(:bom_1)  { Fabricate.attributes_for(:bom) }
      let!(:bom_2)  { Fabricate.attributes_for(:bom) }


      it 'creates a new bom' do
        expect {
          post :create, bom: bom_1.merge!(bom_items_attributes: [item_1])
        }.to change(Bom, :count).by 1
      end

      it 'creates a new bom_item' do
        expect {
          post :create, bom: bom_1.merge!(bom_items_attributes: [item_1])
        }.to change(BomItem, :count).by 1
      end

      it 'associates user with new bom' do
        post :create, bom: bom_1.merge!(bom_items_attributes: [item_1])
        expect(Bom.first.user).to eq controller.current_user
      end

      it 'associates new bom_item with new bom' do
        post :create, bom: bom_1.merge!(bom_items_attributes: [item_1])
        expect(Bom.first.bom_items.first).to eq BomItem.first
      end

      it 'associates bom_item with component' do
        post :create, bom: bom_1.merge!(bom_items_attributes: [item_1])
        expect(Bom.first.bom_items.first.component).to eq part_1
      end

      it 'adds bom item quantities' do
        post :create, bom: bom_1.merge!(bom_items_attributes: [item_1])
        id = Bom.first.id
        post :create, bom: bom_1.merge!(bom_items_attributes: [item_1]).merge!(id: id)
        post :create, bom: bom_1.merge!(bom_items_attributes: [item_1]).merge!(id: id)
        expect(BomItem.last.quantity).to eq (item_1[:quantity] * 3)
      end

      it 'puts new bom last in order' do
        post :create, bom: bom_1.merge!(bom_items_attributes: [item_1])
        post :create, bom: bom_2.merge!(bom_items_attributes: [item_2])
        expect(Bom.last.name).to eq bom_2[:name]
      end
  
      it 'orders new bom items by component name' do
        post :create, bom: bom_1.merge!(bom_items_attributes: [item_1])
        id = Bom.first.id
        post :create, bom: bom_1.merge!(bom_items_attributes: [item_2]).merge!(id: id)
        expect(Bom.first.bom_items.first.component_name).to eq 'part_a'
        expect(Bom.first.bom_items.last.component_name).to eq 'part_z'
      end

      it 'does not create duplicate items with same component' do
        expect {
          post :create, bom: bom_1.merge!(bom_items_attributes: [item_1])
          id = Bom.first.id
          post :create, bom: bom_1.merge!(bom_items_attributes: [item_1]).merge!(id: id)
        }.to change(BomItem, :count).by 1
      end

      it 'adds same component to different boms' do
        expect {
          post :create, bom: bom_1.merge!(bom_items_attributes: [item_1])
          post :create, bom: bom_2.merge!(bom_items_attributes: [item_1])
        }.to change(BomItem, :count).by 2
      end

      it 'redirects to boms index page' do
        post :create, id: 0, bom: bom_1.merge!(bom_items_attributes: [item_1])
        expect(response).to redirect_to Bom.last
      end
    end

    describe 'DELETE destroy' do

      let(:category) { Fabricate(:category) }
      let(:part_1)  { category.components.first }
      let(:part_2)  { category.components.second }

      let(:user_1)  { controller.current_user }
      let!(:bom_1)  { Fabricate(:bom, user: user_1) }
      let(:user_2)  { Fabricate(:user) }
      let!(:bom_2)  { Fabricate(:bom, user: user_2) }

      let!(:item_1) { Fabricate(:bom_item, component: part_1) } 
      let!(:item_2) { Fabricate(:bom_item, component: part_2) }

      it 'deletes a bom' do
        expect {
          delete :destroy, id: bom_1
        }.to change(Bom, :count).by(-1)
      end

      it 'deletes only current users boms' do
        expect {
          delete :destroy, id: bom_2
        }.to change(Bom, :count).by(0)
      end

      it 'deletes the dependent bom items' do
        bom_1.bom_items << item_1
        expect {
          delete :destroy, id: bom_1
        }.to change(BomItem, :count).by(-1)
      end

      it 'redirects to boms index page' do
        delete :destroy, id: bom_1
        expect(response).to redirect_to boms_path
      end
    end
  end

  context 'unauthenticated user' do
    describe 'GET index' do
      it_behaves_like 'requires sign in' do
        let(:action) { get :index }
      end
    end

    describe 'GET show' do
      it_behaves_like 'requires sign in' do
        let(:action) { get :index }
      end
    end

    describe 'POST create' do
      it_behaves_like 'requires sign in' do
        let(:action) { post :create }
      end
    end

    describe 'DELETE destroy' do
      it_behaves_like 'requires sign in' do
        let(:action) { delete :destroy, id: 0 }
      end
    end
  end
end