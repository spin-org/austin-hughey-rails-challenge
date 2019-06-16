class ScootersController < ApplicationController
  before_action :set_scooter, only: [:show, :deactivate, :activate]

  #
  # Finds scooters within RADIUS meters of LAT and LON.
  #   GET '/scooters/near/30.269362/-97.7408848/75'
  #     would return up to 50 scooters within 75 meters of the point given
  #     in the order of LONGITUDE (west <--> east), LATITUDE (up/down).
  #
  #   This API is only going to return a JSON array of scooters within the
  #   defined radius, along with their location as longitude, latitude, and
  #   their battery level. A timestamp will be included that tells you how
  #   "fresh" that information is - in other words, when the scooter last
  #   checked in.
  #
  #   It's up to the client application to plot these on a map and decide
  #   whether or not the data should be presented to the user, or which
  #   parts of that data should be presented to the user (e.g. you might
  #   want to filter scooters that haven't checked in for over 3 days, etc.).
  #
  #   This will be limited to a maximum return set of 50 scooters. No more.
  #   Usually the result set will be less but for now, that value will be
  #   hard-coded.
  #
  #   Example of what this is going to return:
  #
  #           {
  #             "scooters": [
  #               {
  #                 "scooter_id": "65363976-0dba-4a8b-823f-518850a47781",
  #                 "battery_level": 88.76293,
  #                 "location": "-97.7408848 30.269362",
  #                 "last_checkin": "2019-06-16 03:58:41"
  #               }
  #             ]
  #           }
  #
  #
  #
  def locate
    lat    = params[:lat]
    lon    = params[:lon]
    radius = params[:radius]
    now    = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S')
    render json: Scooter.near(lon: lon, lat: lat, radius: radius, after: now)
  end

  def show
    render json: @scooter
  end

  def deactivate
    @scooter.deactivate!
    render json: @scooter
  end

  def activate
    @scooter.activate!
    render json: @scooter
  end

  def mass_activate
    scooters = []
    multiple_scooter_params[:ids].each do |id|
      if @scooter = Scooter.find(id)
        @scooter.activate!
        scooters << @scooter
      end
    end
    render json: scooters
  end

private

  def set_scooter
    @scooter = Scooter.find(params[:id])
  end

  def multiple_scooter_params
    params.permit(ids: [])
  end
end
