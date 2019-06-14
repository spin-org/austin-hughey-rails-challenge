require 'rails_helper'

RSpec.describe Scooter, type: :model do
  describe "validations and model methods" do
    before :each do
      @scooter = Scooter.new()
    end

    it "can be activated and deactivated (e.g. for maintenance)" do
      @scooter.deactivate!
      expect(@scooter.valid?).to eq true
      expect(@scooter.active?).to eq false
      @scooter.activate!
      expect(@scooter.valid?).to eq true
      expect(@scooter.active?).to eq true
    end
  end
end