class Report < ApplicationRecord
  validates :scooter_id, presence: true
  validates :location, presence: true
  validates :battery_level, presence: true
  belongs_to :scooter
end
