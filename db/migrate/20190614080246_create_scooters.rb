class CreateScooters < ActiveRecord::Migration[5.2]
  def change
    create_table :scooters, id: :uuid do |t|
      #
      # A scooter is just a unique object (hence the UUID)
      # that can be locked down (so it won't run) or deactivated
      # for maintenance (or other reasons).
      #
      t.boolean     :active, default: true
      t.timestamps

      #
      # TODO: Add location information about where it's "currently" located.
      # That'll be a future migration/iteration.
      #
    end
    add_index :scooters, :active
  end
end
