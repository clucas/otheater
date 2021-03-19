class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :imdb_id, null: false
      t.string :title, null: false
      t.text :summary
      t.string :year
      t.string :genre
      t.string :image_url, null: false
      t.string :imdb_link, null: false

      t.timestamps
    end
    add_index :movies, :imdb_id, unique: true
  end
end
