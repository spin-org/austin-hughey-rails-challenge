require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  describe "creating reports" do
    before :each do
      @scooter = Scooter.new
      @scooter.save
    end

    it "creates a new report via POST /reports" do
      post :create, params: {
        scooter_id: @scooter.id,
        battery_level: 55.57,
        lat: 39.0907132,
        lon: -97.7375201
      }
      expect(response.status).to eq 200
      expect(JSON.parse(response.body)["scooter_id"]).to eq @scooter.id
    end

    it "renders a 400 bad request if missing information" do
      post :create, params: {
        battery_level: 55.57,
        lat: 39.0907132,
        lon: -97.7375201
      }
      expect(response.status).to eq 400
    end
  end
end
