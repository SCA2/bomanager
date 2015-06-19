class ComponentsController < ApplicationController
  def index
    @categories = Category.joins(:components).sorted.uniq
  end
end