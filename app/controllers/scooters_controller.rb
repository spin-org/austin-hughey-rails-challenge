class ScootersController < ApplicationController
  before_action :set_scooter, only: [:show, :deactivate, :activate]

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
