class CreateSeats < ActiveRecord::Migration[6.1]
  def change
    create_table :seats do |t|
      t.string :guid, null: false
      t.string :row
      t.string :column
      t.string :status
      t.references :venue, null: false, foreign_key: true

      t.timestamps
    end
    add_index :seats, [:venue_id, :guid], unique: true
  end
end
