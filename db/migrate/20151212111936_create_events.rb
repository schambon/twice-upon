class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :counter, index: true, foreign_key: true
      t.datetime :timestamp

      t.timestamps null: false
    end
  end
end
