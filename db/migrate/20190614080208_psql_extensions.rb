class PsqlExtensions < ActiveRecord::Migration[5.2]
  def change
    #
    # Used to enable the extensions for PostgreSQL that we'll need:
    #   postgis: geographical location system
    #   pgcrypto: Dependency for uuid-ossp
    #   uuid-ossp: For native UUID data types
    #
    enable_extension "postgis"
    enable_extension "postgis_topology"
    enable_extension "postgis_sfcgal"
    enable_extension "fuzzystrmatch"
    enable_extension "postgis_tiger_geocoder"
    enable_extension "address_standardizer"
    enable_extension "pgcrypto"
    enable_extension "uuid-ossp"
  end
end
