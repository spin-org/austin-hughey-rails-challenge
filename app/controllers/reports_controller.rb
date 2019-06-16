class ReportsController < ApplicationController

  #
  # For the purposes of a demo app this is fine, but for a real prod app
  # you'd definitely want to read paginated data from cache, update the cache
  # with a worker in the background periodically, and have that worker do
  # its read work off of a read-only database replica with a hell of a lot of
  # RAM and multiple SSDs in a RAID0 or something. Also, we should have the
  # cache auto-expire objects in memory after a certain number of days based
  # on legality/locality. Since that number of days will vary from one locality
  # to the next based on legalities, we should find a max value everybody can
  # be happy with and make that an environment variable, at least for a first
  # iteration. Future iterations may be able to handle the complexity of having
  # a different max number of days worth of reports per locality, as at that
  # point of growth the complexity of doing that actually gets you more
  # efficiency since you can discard stuff older than a certain locality might
  # need, thus making room for other stuff. But the tradeoff in the work
  # required to do all that vs. the benefit of doing so is purely a function
  # of scale.
  #

  def by_scooter
    @scooter = Scooter.find(params[:scooter_id])
    render json: @scooter.reports # TODO: Paginate this
  end

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
