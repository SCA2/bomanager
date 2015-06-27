class ComponentsController < ApplicationController

  before_action :authorized_only

  def index
    @categories = Category.joins(:components).sorted.uniq
  end

  def show
    @component = Component.find(params[:id])
  end

end