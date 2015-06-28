require 'rails_helper'

describe BomItemsController do

  context "with authenticated user" do

    before { set_current_user }

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
        expect(response).to redirect_to sign_in_path
      end

      it 'redirects to bom page' do
        delete :destroy, id: item_1
        expect(response).to redirect_to bom_path(bom)
      end

    end

  end
  
  context "with unauthenticated user" do

    describe "DELETE destroy" do
      it_behaves_like 'requires sign in' do
        let(:action) { delete :destroy, id: 0 }
      end
    end

  end
end
