class AddDefaultToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :division_id, from: nil, to: 1
    change_column_default :users, :activated, from: nil, to: false
  end
end
