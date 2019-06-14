require 'rails_helper'

RSpec.describe Report, type: :model do
  describe "validations" do
    before :each do
      Scooter.new.save
      @scooter = Scooter.first
      @factory = RGeo::Geographic.spherical_factory
      @report = Report.new(
        scooter: @scooter,
        location: @factory.point(-21, 22),
        battery_level: 37.3
      )
    end

    it "requires a scooter" do
      @report.scooter = nil
      expect(@report.valid?).to eq false
    end

    it "requires a battery level" do
      @report.battery_level = nil
      expect(@report.valid?).to eq false
    end

    it "requires a location" do
      @report.location = nil
      expect(@report.valid?).to eq false
    end
  end
end
