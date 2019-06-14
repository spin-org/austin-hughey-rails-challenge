require 'rails_helper'

RSpec.describe ScootersController, type: :controller do
  describe '/scooters' do
    before :each do
      Scooter.new.save
      @scooter = Scooter.first
    end

    it "renders the scooter json" do
      get :show, params: { id: @scooter.id }
      expect(response.status).to eq 200
    end

    it 'PUT :id/deactivate' do
      expect(@scooter.active?).to eq true
      put :deactivate, params: { id: @scooter.id }
      expect(response.status).to eq 200
      scooter = JSON.parse(response.body)
      expect(scooter['active']).to eq false
    end

    it 'PUT :id/activate' do
      @scooter.deactivate! # start with opposite state so we know it works
      put :activate, params: { id: @scooter.id }
      expect(response.status).to eq 200
      scooter = JSON.parse(response.body)
      expect(scooter['active']).to eq true
    end
  end
end
