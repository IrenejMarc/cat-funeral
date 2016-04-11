class User < ActiveRecord::Base
  has_secure_password
  has_many :reservations

  validates :username, presence: true
  validates :password, confirmation: true
end
