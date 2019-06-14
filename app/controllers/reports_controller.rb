class ReportsController < ApplicationController
  def create
    @report = Report.new(
      scooter_id: report_params[:scooter_id],
      battery_level: report_params[:battery_level],
      location: RGeo::Geographic.spherical_factory.point(
        report_params[:lat], report_params[:lon]
      )
    )
    if @report.valid? && @report.save
      render json: @report
    else
      render plain: "Bad Request", status: :bad_request
    end
  end
private

  def report_params
    params.permit(:scooter_id, :lat, :lon, :battery_level)
  end

end
