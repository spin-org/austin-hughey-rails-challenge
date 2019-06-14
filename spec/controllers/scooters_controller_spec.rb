require 'rails_helper'

RSpec.describe ScootersController, type: :controller do
  describe '/scooters' do
    before :each do
      Scooter.new.save
      @scooter = Scooter.first
    end

    it 'mass activates scooters' do
      scooters = []
      3.times do
        @scooter = Scooter.new(active: false)
        @scooter.save
        scooters << @scooter
      end

      scooters.each do |s|
        expect(s.active?).to eq false
      end

      # We now have 3 deactivate scooters. Try mass activating all of them
      # and see if we get all 3 back in JSON.
      put :mass_activate, params: { ids: scooters.map(&:id) }
      expect(response.status).to eq 200
      scooters = JSON.parse(response.body)
      scooters.each do |s|
        expect(s['active']).to eq true
      end

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
