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

ActiveRecord::Schema.define(version: 2019_03_14_014824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_infos", force: :cascade do |t|
    t.string "name_company"
    t.string "npwp"
    t.string "website"
    t.string "image"
    t.string "address"
    t.string "city"
    t.string "province"
    t.string "postal_code"
    t.string "country"
    t.string "name_person"
    t.string "phone_one"
    t.string "phone_two"
    t.string "email"
    t.string "fax"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "couriers", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "company"
    t.string "phone_number"
    t.string "address"
    t.string "country"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.date "start_event"
    t.date "end_event"
    t.string "color"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_details", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "tax_id"
    t.bigint "invoice_id"
    t.decimal "cost"
    t.integer "qty"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_invoice_details_on_invoice_id"
    t.index ["product_id"], name: "index_invoice_details_on_product_id"
    t.index ["tax_id"], name: "index_invoice_details_on_tax_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.date "invoice_date"
    t.string "number_invoice"
    t.bigint "customer_id"
    t.string "shipping"
    t.string "status"
    t.decimal "subtotal"
    t.decimal "grand_total"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "payment_type_id"
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
    t.index ["payment_type_id"], name: "index_invoices_on_payment_type_id"
  end

  create_table "payment_types", force: :cascade do |t|
    t.string "name"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.text "note"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "invoice_id"
    t.string "number_payment"
    t.bigint "purchase_id"
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
    t.index ["purchase_id"], name: "index_payments_on_purchase_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "sku"
    t.string "name"
    t.decimal "price"
    t.integer "qty"
    t.string "status"
    t.text "description"
    t.string "weight"
    t.string "length"
    t.string "high"
    t.string "wide"
    t.json "images"
    t.string "created_by"
    t.string "updated_by"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "unit_id"
    t.bigint "brand_id"
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["unit_id"], name: "index_products_on_unit_id"
  end

  create_table "purchase_details", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "tax_id"
    t.bigint "purchase_id"
    t.decimal "cost"
    t.integer "qty"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_purchase_details_on_product_id"
    t.index ["purchase_id"], name: "index_purchase_details_on_purchase_id"
    t.index ["tax_id"], name: "index_purchase_details_on_tax_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.date "purchase_date"
    t.string "number_purchase"
    t.bigint "vendor_id"
    t.string "shipping"
    t.string "status"
    t.bigint "payment_type_id"
    t.decimal "subtotal"
    t.decimal "grand_total"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_type_id"], name: "index_purchases_on_payment_type_id"
    t.index ["vendor_id"], name: "index_purchases_on_vendor_id"
  end

  create_table "recurring_events", force: :cascade do |t|
    t.string "title"
    t.date "anchor"
    t.integer "frequency", limit: 2, default: 0
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taxes", force: :cascade do |t|
    t.string "name"
    t.decimal "rate"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "phone_number"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "company"
    t.string "phone_number"
    t.string "address"
    t.string "country"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "invoice_details", "products"
  add_foreign_key "invoice_details", "taxes"
  add_foreign_key "invoices", "customers"
  add_foreign_key "invoices", "payment_types"
  add_foreign_key "payments", "invoices"
  add_foreign_key "payments", "purchases"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "units"
  add_foreign_key "purchase_details", "products"
  add_foreign_key "purchase_details", "taxes"
  add_foreign_key "purchases", "payment_types"
  add_foreign_key "purchases", "vendors"
end
