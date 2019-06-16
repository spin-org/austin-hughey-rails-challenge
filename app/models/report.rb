class Report < ApplicationRecord
  #
  # Some notes about the report model/concept in general...
  #
  # A "report" is a historical record of what the scooter has done, where it's
  # been, and/or its status (active or not). Whenever a scooter checks in on
  # its own it hits the /report end point with a POST of data including its
  # location (lat/lon), and battery level.
  #
  # The automatically maintained field (thanks, Rails!) called
  #   created_at
  # can be considered the date/time the checkin happened...
  #   OR
  # it can be considered the date/time a scooter was activated or deactivated.
  #
  # In the case of activation/deactivation, the scooter doesn't provide any
  # data, this app does, and it does so through the Scooter#activate! and
  # Scooter#deactivate! methods. ALWAYS USE THESE METHODS TO UPDATE STATUS,
  # never just update the attribute directly.
  #
  # TODO: Find a way to "protect" that attribute from direct manipulation on
  # the Scooter model...
  #
  validates :scooter_id, presence: true
  belongs_to :scooter
end
