class CreateVenues < ActiveRecord::Migration[6.1]
  def change
    create_table :venues do |t|
      t.string :name
      t.integer :rows, null: false
      t.integer :columns, null: false

      t.timestamps
    end
  end
end
