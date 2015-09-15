# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150914131851) do

  create_table "album_labels", id: false, force: :cascade do |t|
    t.integer "album_id",                        limit: 4
    t.integer "label_id",                        limit: 4
    t.integer "[\"album_id\", \"label_id\"]_id", limit: 4
  end

  create_table "album_tracks", force: :cascade do |t|
    t.string   "name",                    limit: 70
    t.integer  "position",                limit: 4
    t.string   "track_length",            limit: 20
    t.integer  "album_id",                limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "music_file_file_name",    limit: 255
    t.string   "music_file_content_type", limit: 255
    t.integer  "music_file_file_size",    limit: 4
    t.datetime "music_file_updated_at"
  end

  add_index "album_tracks", ["album_id"], name: "index_album_tracks_on_album_id", using: :btree
  add_index "album_tracks", ["name"], name: "index_album_tracks_on_name", using: :btree

  create_table "album_tracks_music_groups", id: false, force: :cascade do |t|
    t.integer "album_track_id",                              limit: 4
    t.integer "music_group_id",                              limit: 4
    t.integer "[\"album_track_id\", \"music_group_id\"]_id", limit: 4
  end

  create_table "albums", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.boolean  "published",                     default: true
    t.datetime "release_date"
    t.boolean  "accepted_by_label"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "album_art",         limit: 255
  end

  create_table "albums_music_groups", id: false, force: :cascade do |t|
    t.integer "album_id",                              limit: 4
    t.integer "music_group_id",                        limit: 4
    t.integer "[\"album_id\", \"music_group_id\"]_id", limit: 4
  end

  create_table "artists", force: :cascade do |t|
    t.string   "email",           limit: 200,                 null: false
    t.string   "password_digest", limit: 255
    t.boolean  "activated",                   default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "artists", ["email"], name: "index_artists_on_email", using: :btree

  create_table "labels", force: :cascade do |t|
    t.string   "label_name",       limit: 255
    t.integer  "music_company_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "labels", ["music_company_id"], name: "index_labels_on_music_company_id", using: :btree

  create_table "labels_music_companies", id: false, force: :cascade do |t|
    t.integer "label_id",                                limit: 4
    t.integer "music_company_id",                        limit: 4
    t.integer "[\"label_id\", \"music_company_id\"]_id", limit: 4
  end

  create_table "music_companies", force: :cascade do |t|
    t.string   "email",           limit: 200, null: false
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "super_power",     limit: 4
  end

  create_table "music_groups", force: :cascade do |t|
    t.string   "name",           limit: 50
    t.string   "tag_name",       limit: 255
    t.boolean  "solo_work",                  default: false
    t.datetime "formation_date"
    t.integer  "artist_id",      limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "music_groups", ["artist_id"], name: "index_music_groups_on_artist_id", using: :btree

end
