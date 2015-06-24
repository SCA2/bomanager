class BomItem < ActiveRecord::Base

  belongs_to :bom
  belongs_to :component

  validates :quantity, numericality: { only_integer: true }
  validates :quantity, numericality: { greater_than: 0 }

  def reference
    "C1, C2, C3"
  end

  def component_name
    component.name
  end

  def category
    component.category
  end

  def category_name
    component.category.name
  end

  def manufacturer
    component.manufacturer
  end

  def price
    component.price
  end

  def total
    price * quantity
  end
end