ActiveRecord::Schema[7.0].define(version: 2022_05_03_125124) do
  create_table "applications", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "token"
    t.string "name"
    t.integer "chats_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_applications_on_token", unique: true
  end

end
