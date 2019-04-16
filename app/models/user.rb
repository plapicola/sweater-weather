class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_confirmation_of :password
  validates_uniqueness_of :api_key
end
