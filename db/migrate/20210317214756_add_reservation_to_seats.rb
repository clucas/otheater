class AddReservationToSeats < ActiveRecord::Migration[6.1]
  def change
    add_reference :seats, :reservation, null: true, foreign_key: true
  end
end
