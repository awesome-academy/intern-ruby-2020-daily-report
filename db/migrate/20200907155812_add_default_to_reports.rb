class AddDefaultToReports < ActiveRecord::Migration[6.0]
  def change
    change_column_default :reports, :status, from: nil, to: 0
    change_column_default :reports, :deleted, from: nil, to: false
  end
end
