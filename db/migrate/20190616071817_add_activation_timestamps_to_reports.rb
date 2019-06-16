class AddActivationTimestampsToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :activated_at,   :datetime
    add_index  :reports, :activated_at
    add_column :reports, :deactivated_at, :datetime
    add_index  :reports, :deactivated_at
  end
end
