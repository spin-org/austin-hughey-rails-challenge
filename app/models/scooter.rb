class Scooter < ApplicationRecord
  validates :active, inclusion: { in: [true, false] }
  has_many :reports
  has_many :tickets

  #
  # Returns only active scooters (that aren't deactivated)
  #
  def self.active
    Scooter.where(active: true)
  end

  #
  # Call this to "shut off" a scooter. It'll be considered "locked" and out
  # of service. Can be used for maintenance or any othe reason to disable
  # a scooter.
  #
  def deactivate!
    if active?
      update_attribute :active, false
    end
  end

  #
  # Call this to activate a deactivated scooter.
  #
  def activate!
    if !active?
      update_attribute :active, true
    end
  end
end
