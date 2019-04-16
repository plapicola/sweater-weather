class City < ApplicationRecord
  has_many :favorites
  has_many :users, through: :favorites

  validates_presence_of :name
  validates_uniqueness_of :name
  validates :latitude,
    presence: true,
    numericality: {
      greater_than_or_equal_to: -180,
      less_than_or_equal_to: 180
  }

  validates :longitude,
    presence: true,
    numericality: {
      greater_than_or_equal_to: -180,
      less_than_or_equal_to: 180
  }

  def coordinates
    {
      lat: latitude,
      lng: longitude
    }
  end
end
