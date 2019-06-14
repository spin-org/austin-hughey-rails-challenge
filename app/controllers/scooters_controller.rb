class ScootersController < ApplicationController
  before_action :set_scooter
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

private

  def set_scooter
    @scooter = Scooter.find(params[:id])
  end

  def scooter_params
    params.require(:scooter).permit(:id)
  end
end
