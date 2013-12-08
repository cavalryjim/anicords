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

ActiveRecord::Schema.define(version: 20131207153003) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "allergies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animal_allergies", force: true do |t|
    t.integer  "animal_id"
    t.integer  "allergy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animal_associations", force: true do |t|
    t.integer  "animal_id"
    t.integer  "service_provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animal_diagnoses", force: true do |t|
    t.integer  "animal_id"
    t.integer  "medical_diagnosis_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animal_medications", force: true do |t|
    t.integer  "animal_id"
    t.integer  "medication_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animal_transfers", force: true do |t|
    t.integer  "animal_id"
    t.integer  "transferee_id"
    t.string   "transferee_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animal_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animal_vaccinations", force: true do |t|
    t.integer  "animal_id"
    t.integer  "vaccination_id"
    t.date     "vaccination_date"
    t.string   "dosage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animals", force: true do |t|
    t.string   "name"
    t.integer  "animal_type_id"
    t.decimal  "weight"
    t.text     "description"
    t.integer  "household_id"
    t.integer  "breeder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "dob"
    t.string   "food"
    t.decimal  "volume_per_serving"
    t.integer  "servings_per_day"
    t.string   "image"
    t.string   "pedigree"
    t.string   "pedigree_chart"
    t.string   "health_certification"
    t.string   "vaccination_record"
    t.string   "show_name"
    t.string   "registration_number"
    t.string   "serving_measure"
    t.integer  "shampoo_id"
    t.integer  "treat_id"
    t.integer  "vitamin_id"
    t.string   "weight_measure"
    t.integer  "breed_id"
    t.string   "gender"
    t.boolean  "neutered"
    t.integer  "food_id"
    t.text     "special_instructions"
    t.string   "rfid"
    t.string   "qr_code_uid"
    t.string   "qr_code_name"
    t.integer  "organization_id"
    t.integer  "owner_id"
    t.string   "owner_type"
  end

  create_table "beta_comments", force: true do |t|
    t.text     "comment"
    t.string   "page_url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "breeders", force: true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "website"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "breeds", force: true do |t|
    t.string   "name"
    t.integer  "animal_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_types", force: true do |t|
    t.integer  "service_provider_id"
    t.integer  "service_provider_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.string   "title"
    t.string   "file_path"
    t.integer  "animal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foods", force: true do |t|
    t.string   "name"
    t.integer  "animal_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "household_associations", force: true do |t|
    t.integer  "household_id"
    t.integer  "service_provider_id"
    t.integer  "clinic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "households", force: true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_diagnoses", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "animal_type_id"
  end

  create_table "medications", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.string   "message"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "queue_classic_jobs", force: true do |t|
    t.text     "q_name",    null: false
    t.text     "method",    null: false
    t.text     "args",      null: false
    t.datetime "locked_at"
  end

  add_index "queue_classic_jobs", ["q_name", "id"], name: "idx_qc_on_name_only_unlocked", where: "(locked_at IS NULL)", using: :btree

  create_table "service_offerings", force: true do |t|
    t.integer  "service_provider_id"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_provider_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_providers", force: true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "email"
    t.string   "website"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "service_provider_type_id"
  end

  create_table "shampoos", force: true do |t|
    t.string   "name"
    t.integer  "animal_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treats", force: true do |t|
    t.string   "name"
    t.integer  "animal_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_associations", force: true do |t|
    t.integer  "user_id"
    t.integer  "breeder_id"
    t.integer  "household_id"
    t.boolean  "administrator"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "veterinarian_id"
    t.integer  "service_provider_id"
    t.integer  "group_id"
    t.string   "group_type"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vaccinations", force: true do |t|
    t.string   "name"
    t.string   "frequency"
    t.string   "recommended_dosage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "veterinarians", force: true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "service_provider_id"
  end

  create_table "vitamins", force: true do |t|
    t.string   "name"
    t.integer  "animal_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
