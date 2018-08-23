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

ActiveRecord::Schema.define(version: 2018_08_23_183943) do

  create_table "questions", force: :cascade do |t|
    t.string "questions"
    t.string "answer"
    t.integer "test_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.integer "teacher_id"
    t.integer "test_ids"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.integer "student_ids"
    t.integer "test_ids"
  end

  create_table "tests", force: :cascade do |t|
    t.string "title"
    t.integer "points"
    t.integer "teacher_id"
  end

end
