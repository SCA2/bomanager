require 'rails_helper'

describe BomItemsController do

  context 'authenticated user' do

    before      { set_current_user }
    let(:user)  { controller.current_user }

    describe 'GET index' do

      let!(:bom)  { Fabricate(:bom) }

      it 'sets @bom_items to selected bom items' do
        bom.bom_items << Fabricate(:bom_item)
        bom.bom_items << Fabricate(:bom_item)
        get :index, id: bom.id
        expect(assigns(:bom_items)).to match_array bom.bom_items
      end
    end

    describe 'POST update_bom' do

      let!(:part_1) { Fabricate(:component, name: 'part_z') }
      let!(:part_2) { Fabricate(:component, name: 'part_a') }
      let!(:persist_1) { Fabricate(:bom_item, quantity: 1, component: part_1) }
      let!(:persist_2) { Fabricate(:bom_item, quantity: 2, component: part_2) }
      let!(:item_1) { Fabricate.attributes_for(:bom_item, quantity: 1, component: part_1) }
      let!(:item_2) { Fabricate.attributes_for(:bom_item, quantity: 0, component: part_2) }
      let!(:bom_1)  { Fabricate(:bom) }
      let!(:bom_2)  { Fabricate(:bom) }

      context 'valid data' do

        it 'redirects to bom items index page' do
          bom_1.bom_items << persist_1
          post :update_bom, id: bom_1.id, bom_items: [item_1]
          expect(response).to redirect_to bom_1
        end

        it 'puts bom items in order' do
          bom_1.bom_items << persist_1
          bom_1.bom_items << persist_2
          post :update_bom, id: bom_1.id, bom_items: [item_1, item_2]
          expect(bom_1.bom_items.first.component).to eq(part_2)
        end
      end

      context 'invalid data' do
        it 'redirects to bom_1' do
          bom_1.bom_items << persist_2
          post :update_bom, id: bom_1.id, bom_items: [item_2]
          expect(response).to redirect_to bom_1
        end

        it 'sets the flash error message' do
          bom_1.bom_items << persist_2
          post :update_bom, id: bom_1.id, bom_items: [item_2]
          expect(flash[:error]).to be_present
        end

        it 'does not change existing bom items' do
          bom_1.bom_items << persist_2
          post :update_bom, id: bom_1.id, bom_items: [item_2]
          expect(persist_2.reload.quantity).to eq 2
        end
      end

      context 'with other boms data' do
        it 'does not change existing bom items' do
          bom_1.bom_items << persist_1
          bom_2.bom_items << persist_2
          post :update_bom, id: bom_2.id, bom_items: [item_1]
          expect(persist_1.reload.quantity).to eq 1
          expect(persist_2.reload.quantity).to eq 2
        end
      end
    end

    describe "DELETE destroy" do

      let(:category) { Fabricate(:category) }
      let(:part_1)  { category.components.first }
      let(:part_2)  { category.components.second }

      let(:user_1)  { controller.current_user }
      let(:bom_1)   { Fabricate(:bom, user: user_1) }
      let(:user_2)  { Fabricate(:user) }
      let(:bom_2)   { Fabricate(:bom, user: user_2) }

      let!(:item_1) { Fabricate(:bom_item, component: part_1, bom: bom_1) } 
      let!(:item_2) { Fabricate(:bom_item, component: part_2, bom: bom_1) }
      let!(:item_3) { Fabricate(:bom_item, component: part_2, bom: bom_2) }

      it 'deletes a bom_item' do
        expect {
          delete :destroy, id: item_1
        }.to change(BomItem, :count).by(-1)
      end

      it 'deletes only the correct bom_item' do
        expect {
          delete :destroy, id: item_3
        }.to change(BomItem, :count).by(0)
      end

      it 'redirects to bom page' do
        delete :destroy, id: item_1
        expect(response).to redirect_to bom_path(bom_1)
      end
    end
  end
  
  context 'unauthenticated user' do
    describe 'GET index' do
      it_behaves_like 'requires sign in' do
        let(:action) { get :index }
      end
    end

    describe 'POST update_bom' do
      it_behaves_like 'requires sign in' do
        let(:action) { post :update_bom, id: 0 }
      end
    end

    describe 'DELETE destroy' do
      it_behaves_like 'requires sign in' do
        let(:action) { delete :destroy, id: 0 }
      end
    end
  end
end
