class Component < ActiveRecord::Base
  belongs_to  :category
  has_many    :traits
end