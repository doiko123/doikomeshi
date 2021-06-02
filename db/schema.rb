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

ActiveRecord::Schema.define(version: 2021_06_02_124958) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", comment: "クレジットカード", force: :cascade do |t|
    t.bigint "customer_id", null: false, comment: "顧客ID"
    t.string "stripe_id", null: false, comment: "StripeのID"
    t.string "last4", null: false, comment: "カード下4桁"
    t.integer "exp_month", null: false, comment: "有効期限の月"
    t.integer "exp_year", null: false, comment: "有効期限の年"
    t.string "brand", null: false, comment: "カードのブランド"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_cards_on_customer_id"
    t.index ["stripe_id"], name: "index_cards_on_stripe_id", unique: true
  end

  create_table "customers", comment: "顧客", force: :cascade do |t|
    t.string "stripe_id", null: false, comment: "StripeのID"
    t.string "name", null: false, comment: "顧客名"
    t.string "email", null: false, comment: "メールアドレス"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["name"], name: "index_customers_on_name", unique: true
    t.index ["stripe_id"], name: "index_customers_on_stripe_id", unique: true
  end

  create_table "products", comment: "商品", force: :cascade do |t|
    t.string "stripe_id", null: false, comment: "StripeのID"
    t.string "name", null: false, comment: "商品名"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_products_on_name", unique: true
    t.index ["stripe_id"], name: "index_products_on_stripe_id", unique: true
  end

  create_table "skus", comment: "SKU", force: :cascade do |t|
    t.integer "price", null: false, comment: "価格"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
