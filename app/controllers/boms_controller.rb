class BomsController < ApplicationController

  before_action :authorized_only

  def index
    @boms = current_user.boms
    if @boms.count == 0
      flash[:notice] = "You don't have any BOMs"
      redirect_to home_path
    end
  end

  def create
    @bom = Bom.where(id: bom_params[:id]).first_or_create
    begin
      ActiveRecord::Base.transaction do
        @bom.update!(bom_params)
        create_or_update_items(items_params)
      end
      flash[:success] = "BOM created!"
      redirect_to @bom
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound
      flash[:alert] = "Can't create BOM!"
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

  def bom_params
    params.require(:bom).permit(:name, :id).merge!(user_id: current_user.id)
  end

  def items_params
    params.require(:bom).require(:bom_items_attributes)
  end

  def create_or_update_items(params)
    params.each do |param|
      create_or_update_item(param)
    end
  end

  def create_or_update_item(param)
    return unless param[:component_id]
    item = @bom.bom_items.find_by(component_id: param[:component_id])
    if item
      item.quantity += param[:quantity].to_i
    else
      item = @bom.bom_items.create(permit_item(param))
    end
    item.save!
  end

  def permit_item(param)
    param.permit(:component_id, :quantity, :reference)
  end

end
