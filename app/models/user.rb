class User < ApplicationRecord
  has_secure_password

  has_many :favorites
  has_many :cities, through: :favorites

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_confirmation_of :password
  validates_uniqueness_of :api_key
end
