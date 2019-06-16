require 'rails_helper'

RSpec.describe ScootersController, type: :controller do
  describe '/scooters/near/:lat/:lon/:radius' do
    before :each do
      @deactivated_scooter = Scooter.create(active: false)
      @far_scooter = Scooter.create
      @far_scooter_report = Report.create(
        scooter: @far_scooter,
        battery_level: 85,
        location: 'POINT(-97.7488463 30.269854)' # Star Bar, Austin, TX
      )
      @low_battery_scooter = Scooter.create
      @low_battery_scooter_report = Report.create(
        scooter: @low_battery_scooter,
        battery_level: 29.4475,
        location: 'POINT(-97.7412248 30.2688096)'
      )
      @scooters = []
      @reports = []
      3.times do
        scooter = Scooter.create
        @scooters << scooter
        3.times do
          report = Report.create(
            scooter: scooter,
            battery_level: 85,
            location: 'POINT(-97.7412248 30.2688096)'
          )
        end
      end
    end

    it 'reports scooters near me' do
      get :locate, params: { radius: 75, lat: 30.2688096, lon: -97.7412248 }
      expect(response).to be_successful
      count = JSON.parse(response.body).count
# I ran into a non-deterministic test failure here but could only reproduce it
# once, and that was before calling pry on it. So I'm leaving this here for now
# in hopes of catching the error. I suspect something having to do with time
# and/or psql.
if count != 3
  binding.pry
end
      expect(count).to eq 3
    end

    it 'does not report inactive/deactivated scooters' do
      get :locate, params: { radius: 75, lat: 30.2688096, lon: -97.7412248 }
      expect(response).to be_successful
      scooters = JSON.parse(response.body)
      scooters.each do |s|
        expect(s['id']) != @deactivated_scooter.id
      end
    end

    it 'does not report scooters further than RADIUS' do
      get :locate, params: { radius: 75, lat: 30.2688096, lon: -97.7412248 }
      expect(response).to be_successful
      scooters = JSON.parse(response.body)
      scooters.each do |s|
        expect(s['id']) != @far_scooter.id
      end
    end
  end
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
