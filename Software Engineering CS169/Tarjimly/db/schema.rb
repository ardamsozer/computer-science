# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_08_120042) do

  create_table "claims", force: :cascade do |t|
    t.integer "translator_tarjimly_id"
    t.integer "_status"
    t.datetime "submitted_date"
    t.string "translation"
    t.string "translation_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "request_id"
    t.index ["request_id"], name: "index_claims_on_request_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer "user_tarjimly_id"
    t.string "from_language"
    t.string "to_language"
    t.string "document"
    t.string "document_format"
    t.datetime "deadline"
    t.string "title"
    t.string "description"
    t.string "categories"
    t.integer "num_claims"
    t.string "form_type"
    t.integer "_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "claims", "requests"
end
