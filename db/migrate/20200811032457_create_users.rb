class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :role
      t.references :division, null: false, foreign_key: true
      t.string :password_digest
      t.boolean :activated
      t.string :reset_digest
      t.datetime :reset_send_at

      t.timestamps
    end
  end
end
