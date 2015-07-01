class Bom < ActiveRecord::Base
  
  belongs_to :user
  has_many  :bom_items,
            -> { joins(:component).order('components.name') },
            inverse_of: :bom,
            dependent: :destroy
            
  
  validates :name, presence: true
  
  def revision
    1.0
  end

  def total_parts
    bom_items.reduce(0) { |sum, item| sum + item.quantity }
  end

  def last_ordered
    Date.yesterday
  end

  def days_to_reorder
    1
  end
  
  def total
    bom_items.reduce(0) { |sum, item| sum + item.total }
  end

  def in_bom?(component)
    bom_items.any? { |i| i.component == component }
  end

end