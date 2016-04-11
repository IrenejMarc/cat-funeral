class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :day
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
