class BomItem < ActiveRecord::Base

  belongs_to :bom
  belongs_to :component

  scope :sort, -> { joins(:component).order('components.name') }

  validates :quantity, numericality: { only_integer: true }
  validates :quantity, numericality: { greater_than: 0 }
  validates :component, presence: true
  validates :component, uniqueness: { scope: :bom }

  delegate :category,     to: :component
  delegate :manufacturer, to: :component
  delegate :price,        to: :component
  delegate :name,         to: :component, prefix: :component

  def category_name
    component.category.name
  end

  def total
    price * quantity
  end
end