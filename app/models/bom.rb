class Bom < ActiveRecord::Base
  belongs_to :user
  has_many :bom_items, inverse_of: :bom
  validates :name, presence: true
  accepts_nested_attributes_for :bom_items

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
  
  def price
    bom_items.reduce(0) { |sum, item| sum + item.total }
  end

end