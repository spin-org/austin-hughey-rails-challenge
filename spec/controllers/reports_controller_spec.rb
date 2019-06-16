require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  describe "reports API" do
    before :each do
      @scooter = Scooter.create()
      3.times do
        Report.create(scooter: @scooter)
        # For this test we need no other attributes
      end
    end

    it "renders all the reports for a given scooter" do
      get :by_scooter, params: { scooter_id: @scooter.id }
      expect(response).to be_successful
      expect(JSON.parse(response.body).count).to eq 3
    end

#     it "validates with the JSON Schema Validator" do
#       schema = JSON.parse(File.read(File.expand_path(__FILE__ + "../../../../public/reports.schema.json")))
#       get :by_scooter, params: { scooter_id: @scooter.id }
# # binding.pry
#       expect(JSON::Validator.validate(schema, JSON.parse(response.body))).to be_true
#     end
  end

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
