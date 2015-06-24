class Category < ActiveRecord::Base

  has_many :components, -> { order(:name) }

  validates :name, presence: true

  scope :sorted, -> { order(:name) }
  
end