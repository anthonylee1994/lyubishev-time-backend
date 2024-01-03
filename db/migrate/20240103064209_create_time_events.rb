class CreateTimeEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :time_events do |t|
      t.string :name, null: false
      t.integer :minute, null: false
      t.date :date, null: false
      t.integer :order, null: false, default: 0
      t.references :tag, null: false, foreign_key: { to_table: :time_event_tags }
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
