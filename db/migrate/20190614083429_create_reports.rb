class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports, id: :uuid do |t|
      t.uuid            :scooter_id
      t.float           :battery_level
      t.st_point        :location
      t.timestamps
    end
    add_foreign_key :reports, :scooters
    add_index :reports, :scooter_id
    add_index :reports, :battery_level
    add_index :reports, :location, using: :gist
  end
end
