class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :type
      t.date :request_for_date
      t.time :checked_time
      t.datetime :compensation_from
      t.datetime :compensation_to
      t.text :reason
      t.string :status

      t.timestamps
    end
  end
end
