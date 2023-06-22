class NearestStation < ApplicationRecord
  validates :name_of_railway, presence: true
  validates :station_name, presence: true
  validates :how_many_minuites_walk, presence: true

  belongs_to :property, inverse_of: :nearest_stations
end
