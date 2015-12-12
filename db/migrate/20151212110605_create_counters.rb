class CreateCounters < ActiveRecord::Migration
  def change
    create_table :counters do |t|
      t.string :name
      t.integer :cooldown
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
