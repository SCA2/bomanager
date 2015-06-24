class BomsController < ApplicationController

  def index
    @boms = current_user.boms
  end

  def create
    # binding.pry
    if Bom.exists?(bom_params[:id])
      bom = Bom.find(bom_params[:id])
    else
      bom = Bom.new(bom_params)
    end

    if bom.update(bom_params)
      flash[:success] = "BOM updated!"
      redirect_to bom
    else
      flash[:alert] = "Can't update BOM!"
      redirect_to components_path
    end
  end

  def update
    bom = Bom.find(bom_params[:id])
    if bom.update(bom_params)
      flash[:success] = "BOM updated!"
      redirect_to bom
    else
      flash[:alert] = "Can't update BOM!"
      redirect_to components_path
    end
  end

  def show
    @bom = current_user.boms.find(params[:id])
    @bom_items = @bom.bom_items
  end

  private

  def bom_params
    bps = params.require(:bom).permit(:name, :id, bom_items_attributes: [:component_id])
    bps.merge!(user_id: current_user.id)
    bps[:bom_items_attributes].map! {|item| item.merge(quantity: '1')}
    bps
  end

end