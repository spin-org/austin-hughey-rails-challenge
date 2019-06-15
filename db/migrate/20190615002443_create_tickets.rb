class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets, id: :uuid do |t|
      t.uuid              :scooter_id
      t.string            :opened_by
      t.boolean           :deactivate_scooter
      t.text              :notes
      t.timestamps
    end

    add_index :tickets, :opened_by
    add_index :tickets, :deactivate_scooter
    add_foreign_key :tickets, :scooters
  end
end
