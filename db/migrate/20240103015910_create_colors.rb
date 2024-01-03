class CreateColors < ActiveRecord::Migration[7.1]
  def change
    create_table :colors do |t|
      t.string :hexcode, null: false, index: { unique: true }
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
