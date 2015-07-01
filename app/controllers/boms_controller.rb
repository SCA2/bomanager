class BomsController < ApplicationController

  before_action :authorized_only

  def index
    @boms = current_user.boms
  end

  def show
    redirect_to bom_items_path(id: params[:id])
  end

  def create
    # binding.pry
    @bom = Bom.where(id: bom_params[:id]).first_or_create
    begin
      ActiveRecord::Base.transaction do
        @bom.update!(bom_params)
        create_items(items_params)
        flash[:success] = "BOM updated!"
        redirect_to @bom
      end
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound
      flash[:alert] = "Can't update BOM!"
      redirect_to components_path
    end
  end

  def destroy
    bom = Bom.find(params[:id])
    if current_user.boms.include?(bom)
      Bom.destroy(bom.id)
      flash[:success] = "BOM deleted!"
    else
      flash[:alert] = "Can't delete BOM!"
    end
    redirect_to boms_path
  end

  private

  def permit_item(param)
    param.permit(:component_id, :quantity, :reference)
  end

  def bom_params
    params.require(:bom).permit(:name, :id).merge!(user_id: current_user.id)
  end

  def items_params
    params.require(:bom).require(:bom_items_attributes)
  end

  def create_items(params)
    params.each do |param|
      if param[:component_id]
        item = @bom.bom_items.find_by(component_id: param[:component_id])
        if item
          item.quantity += param[:quantity].to_i
        else
          item = @bom.bom_items.create(permit_item(param))
        end
        item.save!
      end
    end
  end

end
