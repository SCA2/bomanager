class Component < ActiveRecord::Base
  belongs_to  :category
  has_many    :properties
  has_many    :bom_items

  validates :name, :manufacturer, :description, presence: :true

  scope :sorted, -> { order(:name) }

  def self.search_by_name(query)
    return [] if query.blank?
    where("name ILIKE ?", "%#{query}%").all.sorted
  end

  def price
    0.25
  end

end