class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true
      t.text :today_plan
      t.text :actual
      t.text :reason_not_complete
      t.text :tomorrow_plan
      t.text :free_comment

      t.timestamps
    end
  end
end
