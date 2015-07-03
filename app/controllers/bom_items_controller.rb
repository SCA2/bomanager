class BomItemsController < ApplicationController

  before_action :authorized_only
  before_action :set_bom, only: [:index, :create, :update_bom]

  def index
    @bom_items = @bom.bom_items
  end

  def update_bom
    begin
      ActiveRecord::Base.transaction do
        update_items(bom_items_params)
      end
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound
      flash[:error] = "Invalid input"
    end
    redirect_to @bom
  end

  def destroy
    bom_item = BomItem.find(params[:id])
    if current_user.boms.include?(bom_item.bom)
      BomItem.destroy(bom_item.id)
      flash[:success] = "Item deleted!"
    else
      flash[:alert] = "Can't delete that item!"
    end
    redirect_to bom_path(bom_item.bom)
  end

  private

  def permit_item(param)
    param.permit(:component_id, :quantity, :reference)
  end

  def bom_item_params
    permit_item(params.require(:bom_item)).merge!(bom_id: @bom.id)
  end

  def bom_items_params
    params.require(:bom_items)
  end

  def set_bom
    @bom = Bom.find(params.require(:id))
  end

  def update_items(params)
    params.each do |param|
      item = @bom.bom_items.find_by!(component_id: param[:component_id])
      item.update!(permit_item(param))
    end
  end

end