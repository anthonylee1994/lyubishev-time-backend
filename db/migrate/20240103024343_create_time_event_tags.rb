class CreateTimeEventTags < ActiveRecord::Migration[7.1]
  def change
    create_table :time_event_tags do |t|
      t.references :color, null: false, foreign_key: true
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :order, null: false, default: 0

      t.timestamps
    end
  end
end
