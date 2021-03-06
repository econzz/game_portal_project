# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_29_104148) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "commenter", default: ""
    t.text "content", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "game_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name", default: ""
    t.text "description", default: ""
    t.string "path", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "numberOfPlay", default: 0
    t.string "cover_big"
    t.string "preview_big"
    t.string "game_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_games_on_category_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "hash_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hash_id"], name: "index_players_on_hash_id", unique: true
  end

  create_table "rankings", force: :cascade do |t|
    t.string "game_id", default: ""
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "games_id"
    t.integer "players_id"
    t.index ["games_id"], name: "index_rankings_on_games_id"
    t.index ["players_id"], name: "index_rankings_on_players_id"
  end

end
