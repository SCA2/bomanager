class Category < ActiveRecord::Base
  has_many :components
  scope :sorted, -> { order(:name) }
end