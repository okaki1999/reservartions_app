class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.date :day, null: false
      t.string :time, null: false
      t.bigint :user_id, null: false
      t.datetime :start_time, null: false

      t.timestamps
    end

    add_index :reservations, :user_id
  end
end
