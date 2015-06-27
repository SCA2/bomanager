class User < ActiveRecord::Base

  has_secure_password

  validates :email, :name, :password, presence: true, on: :create
  validates :email, uniqueness: true

  has_many :boms

end