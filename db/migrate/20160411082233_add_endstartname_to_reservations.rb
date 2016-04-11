class AddEndstartnameToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :starts_at, :datetime
    add_column :reservations, :ends_at, :datetime
    add_column :reservations, :name, :string
  end
end
