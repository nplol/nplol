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

ActiveRecord::Schema.define(version: 20160624163017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "text"
    t.integer  "user_id"
    t.index ["post_id"], name: "index_comments_on_post_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id", "post_id"], name: "index_likes_on_user_id_and_post_id", unique: true, using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.boolean  "public",      default: true
    t.boolean  "popular",     default: false
    t.integer  "likes_count", default: 0
    t.boolean  "top",         default: false
    t.boolean  "banner"
    t.string   "image"
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "posts_tags", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["post_id", "tag_id"], name: "index_posts_tags_on_post_id_and_tag_id", unique: true, using: :btree
    t.index ["post_id"], name: "index_posts_tags_on_post_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "avatar"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "uuid"
    t.string   "email"
    t.string   "username"
  end

end
