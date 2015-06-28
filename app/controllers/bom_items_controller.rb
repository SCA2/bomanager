class BomItemsController < ApplicationController

  before_action :authorized_only

  def destroy
    bom_item = BomItem.find(params[:id])
    if current_user.boms.include?(bom_item.bom)
      bom_item.destroy
      redirect_to bom_path(bom_item.bom)
    else
      flash[:alert] = "Can't delete that line item!"
      redirect_to boms_path(bom_item.bom)
    end
  end

end