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

ActiveRecord::Schema.define(version: 20170308160501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercises", force: :cascade do |t|
    t.string   "name"
    t.float    "x_accel"
    t.float    "y_accel"
    t.float    "z_accel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ibeacons", force: :cascade do |t|
    t.float    "x_motion"
    t.float    "y_motion"
    t.float    "z_motion"
    t.integer  "ibeacon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weightseeds", force: :cascade do |t|
    t.integer  "ibeacon_id"
    t.integer  "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workouts", force: :cascade do |t|
    t.integer  "exercise_id"
    t.integer  "user_id"
    t.integer  "reps_counted"
    t.string   "workout_id"
    t.integer  "weight"
    t.boolean  "good_performance?"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
