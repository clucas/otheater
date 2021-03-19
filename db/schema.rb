# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_17_214756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.string "imdb_id", null: false
    t.string "title", null: false
    t.text "summary"
    t.string "year"
    t.string "genre"
    t.string "image_url", null: false
    t.string "imdb_link", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["imdb_id"], name: "index_movies_on_imdb_id", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.string "name"
    t.bigint "venue_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_reservations_on_movie_id"
    t.index ["venue_id"], name: "index_reservations_on_venue_id"
  end

  create_table "seats", force: :cascade do |t|
    t.string "guid", null: false
    t.string "row"
    t.string "column"
    t.string "status"
    t.bigint "venue_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "reservation_id"
    t.index ["reservation_id"], name: "index_seats_on_reservation_id"
    t.index ["venue_id"], name: "index_seats_on_venue_id"
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.integer "rows", null: false
    t.integer "columns", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "reservations", "movies"
  add_foreign_key "reservations", "venues"
  add_foreign_key "seats", "reservations"
  add_foreign_key "seats", "venues"
end
