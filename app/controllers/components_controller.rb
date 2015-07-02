class ComponentsController < ApplicationController

  before_action :authorized_only

  def index
    @categories = Category.joins(:components).sorted.uniq
  end

  def sub_index
    @categories = Category.joins(:components).where(id: params[:id]).uniq
    render :index
  end

  def show
    @component = Component.find(params[:id])
    @bom_items = @component.bom_items
  end

end