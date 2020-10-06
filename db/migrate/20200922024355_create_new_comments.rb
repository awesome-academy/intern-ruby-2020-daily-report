class CreateNewComments < ActiveRecord::Migration[6.0]
  def change
    create_table :new_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :report, null: false, foreign_key: true
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
