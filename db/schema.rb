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

ActiveRecord::Schema.define(version: 20140725142058) do

  create_table "mdm_columns", force: true do |t|
    t.string  "name"
    t.integer "mdm_data_type_id"
    t.integer "mdm_object_id"
    t.string  "precision"
    t.string  "scale"
  end

  create_table "mdm_data_types", force: true do |t|
    t.string "name"
    t.string "sql_type"
  end

  create_table "mdm_foreign_keys", force: true do |t|
    t.integer "mdm_column_id"
    t.integer "mdm_object_id"
  end

  create_table "mdm_models", force: true do |t|
    t.string "name"
  end

  create_table "mdm_objects", force: true do |t|
    t.string  "name"
    t.integer "mdm_model_id"
  end

  create_table "mdm_primary_keys", force: true do |t|
    t.integer "mdm_column_id"
    t.integer "mdm_object_id"
  end

end
