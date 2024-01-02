# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :telegram_id, null: false
      t.string :first_name, null: false
      t.string :last_name, null: true
      t.string :username, null: true
      t.string :photo_url, null: true
      t.integer :auth_date, null: false

      t.timestamps
      t.index :telegram_id, unique: true
    end
  end
end
