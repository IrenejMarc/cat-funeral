class AddYearmonthdayToReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :day

    add_column :reservations, :year, :integer
    add_column :reservations, :month, :integer
    add_column :reservations, :day, :integer
  end
end
