class Scooter < ApplicationRecord
  # include ActiveRecord::Sanitization::ClassMethods

  validates :active, inclusion: { in: [true, false] }
  has_many :reports
  has_many :tickets

  #
  # Returns all scooters (up to 50) in RADIUS meters from LON LAT coordinates
  # that are marked active:true as a PG result set so iterate over it like this:
  #   scooters = Scooter.near(lon: LON, lat: LAT, radius: RADIUS, after: AFTER)
  #   scooters.rows.each do |scooter|
  #     puts scooter['last_checkin']  # "2019-06-16 04:49:31"
  #     puts scooter['battery_level'] # 88.777294
  #     puts scooter['lon']           # "-97.7408848"
  #     puts scooter['lat']           # "30.269362"
  #     puts scooter['scooter_id']    # "91272513-7566-4209-a079-d2d52d6536b7"
  #
  def self.near(opts = {})
    #
    # Unfortunately, this causes syntax problems:
    #   geolocation_fragment = sanitize_sql([
    #       "ST_DWithin (location, 'POINT(? ?)'::geography, ?)", lon, lat, radius
    #   ])
    # So I have to sanitize the variables myself. Normally I'd spend the time
    # to do that here, but that's some more complex regex because you can't just
    # take lat.gsub(/\D/, '') because you'll remove the pos/neg sign and decimal
    # points. So this is a TODO/FIXME.
    #
    lat    = opts[:lat]
    lon    = opts[:lon]
    radius = opts[:radius].gsub(/\D/, '') # strip any non-digit
    after  = opts[:after]

    #
    # I'm not going to trust ActiveRecord completely here and instead query
    # PostgreSQL directly for geospatial queries.
    #

    scooters = ActiveRecord::Base.connection.execute("
      SELECT
        DISTINCT ON (scooter_id) reports.scooter_id,
        reports.battery_level,
        ST_AsText(reports.location) AS location,
        reports.created_at AS last_checkin,
        scooters.active
      FROM
        reports, scooters
      WHERE
        ST_DWithin (location, 'POINT(#{lon} #{lat})'::geography, #{radius})
      AND
        reports.created_at > '#{after}'
      AND
        scooters.active
      AND
        reports.battery_level > 30
      AND
        scooters.id = reports.scooter_id
      ORDER BY
        reports.scooter_id DESC,
        reports.created_at DESC
    ")

    #
    # Now we have to manipulate the location field data so that it comes out
    # as just a LON LAT pair in plain text, not the PostgreSQL default of
    # something like POINT(-97.7412248 30.2688096).
    #
    # FIXME: Would rather have this as separate points but time is a factor...
    #
    # scooters.each do |scooter|
    #   x = scooter['location'].split(/ /) # split on the space
    #   longitude = p[0].gsub(/POINT\(/, '') # strip the non-coordinates
    #   latitude  = p[1].gsub(/\)/, '') # strip the closing paren
    #   scooter['location'] = "#{longitude} #{latitude}"
    #   #
    #   # FIXME: There's probably a (much) better way to do this, like a regular
    #   # expression, but right now there's just not time for it. Or maybe
    #   # try to make this return separate lat/lon
    #   #
    #   scooter['lat'] = latitude
    #   scooter['lon'] = longitude
    # end

    return scooters

  end

  #
  # Returns only active scooters (that aren't deactivated)
  #
  def self.active
    Scooter.where(active: true)
  end

  #
  # Call this to "shut off" a scooter. It'll be considered "locked" and out
  # of service. Can be used for maintenance or any othe reason to disable
  # a scooter.
  #
  def deactivate!
    if active?
      update_attribute :active, false
    end
  end

  #
  # Call this to activate a deactivated scooter.
  #
  def activate!
    if !active?
      update_attribute :active, true
    end
  end
end
