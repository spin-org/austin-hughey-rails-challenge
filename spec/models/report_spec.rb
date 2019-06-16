require 'rails_helper'

RSpec.describe Report, type: :model do
  describe "validations" do
    before :each do
      Scooter.new.save
      @scooter = Scooter.first
      @factory = RGeo::Geographic.spherical_factory
      @report = Report.new(
        scooter: @scooter,
        location: @factory.point(-97.7375201, 39.0907132),
        battery_level: 37.3
      )
    end

    it "requires a scooter" do
      @report.scooter = nil
      expect(@report.valid?).to eq false
    end
  end
end
