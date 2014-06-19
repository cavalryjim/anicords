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

ActiveRecord::Schema.define(version: 20140619004729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "adoptions", force: true do |t|
    t.integer  "organization_id"
    t.integer  "animal_id"
    t.integer  "organization_user_id"
    t.date     "date"
    t.string   "location"
    t.text     "comments"
    t.integer  "transferee_user_id"
    t.string   "transferee_first_name"
    t.string   "transferee_last_name"
    t.string   "transferee_email"
    t.string   "transferee_phone"
    t.string   "transferee_address1"
    t.string   "transferee_address2"
    t.string   "transferee_city"
    t.string   "transferee_state"
    t.string   "transferee_zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.boolean  "checked_in"
  end

  create_table "animal_breeds", force: true do |t|
    t.integer  "animal_id"
    t.integer  "breed_id"
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
    t.string   "volume"
    t.string   "route"
    t.string   "interval"
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
    t.date     "vaccination_due"
    t.string   "tag_number"
    t.integer  "notification_count", default: 0
    t.boolean  "notify",             default: true
    t.date     "notify_on"
    t.string   "location"
  end

  create_table "animals", force: true do |t|
    t.string   "name"
    t.integer  "animal_type_id"
    t.text     "description"
    t.integer  "breeder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "dob"
    t.string   "food"
    t.decimal  "volume_per_serving"
    t.integer  "servings_per_day"
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
    t.string   "gender"
    t.boolean  "neutered"
    t.integer  "food_id"
    t.text     "special_instructions"
    t.string   "microchip_id"
    t.string   "qr_code_uid"
    t.string   "qr_code_name"
    t.integer  "organization_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.date     "neutered_date"
    t.integer  "registration_club_id"
    t.string   "fur_color"
    t.string   "disposition"
    t.string   "avatar_uid"
    t.string   "avatar_name"
    t.string   "size"
    t.boolean  "pedigreed"
    t.boolean  "microchipped"
    t.string   "neuter_location"
    t.integer  "microchip_brand_id"
    t.boolean  "active"
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

  create_table "dispositions", force: true do |t|
    t.integer  "animal_id"
    t.integer  "personality_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.string   "title"
    t.integer  "animal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_type"
    t.string   "file_uid"
    t.string   "file_name"
    t.string   "external_url"
  end

  create_table "foods", force: true do |t|
    t.string   "name"
    t.integer  "animal_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "health_profiles", force: true do |t|
    t.integer  "animal_id"
    t.date     "last_exam_date"
    t.string   "last_exam_location"
    t.date     "heartworm_test_date"
    t.string   "heartworm_test_location"
    t.boolean  "heartworm_test_result"
    t.date     "fiv_felv_test_date"
    t.string   "fiv_felv_test_location"
    t.boolean  "fiv_felv_test_result"
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

  create_table "locations", force: true do |t|
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

  create_table "microchip_brands", force: true do |t|
    t.string   "name"
    t.string   "website"
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
    t.integer  "event_id"
    t.string   "event_type"
    t.integer  "animal_id"
    t.boolean  "active",         default: true
  end

  create_table "org_profiles", force: true do |t|
    t.integer  "animal_id"
    t.date     "intake_date"
    t.string   "intake_reason"
    t.integer  "neuter_location_id"
    t.string   "neuter_location_type"
    t.float    "intake_weight"
    t.string   "intake_weight_measure"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_location_id"
    t.integer  "petfinder_id"
    t.string   "org_animal_id"
    t.string   "thumbnail_url"
    t.date     "adoption_date"
    t.string   "transferee_first_name"
    t.string   "transferee_last_name"
    t.string   "transferee_phone"
    t.string   "transferee_city"
    t.string   "transferee_state"
    t.string   "transferee_zip"
  end

  create_table "organization_locations", force: true do |t|
    t.integer  "organization_id"
    t.integer  "location_id"
    t.string   "location_type"
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
    t.string   "petfinder_shelter_id"
    t.string   "logo_external_url"
  end

  create_table "personality_types", force: true do |t|
    t.string   "name"
    t.integer  "animal_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: true do |t|
    t.string   "name"
    t.integer  "animal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_uid"
    t.string   "image_name"
    t.string   "external_url"
  end

  create_table "queue_classic_jobs", force: true do |t|
    t.text     "q_name",    null: false
    t.text     "method",    null: false
    t.text     "args",      null: false
    t.datetime "locked_at"
  end

  add_index "queue_classic_jobs", ["q_name", "id"], name: "idx_qc_on_name_only_unlocked", where: "(locked_at IS NULL)", using: :btree

  create_table "registration_clubs", force: true do |t|
    t.string   "name"
    t.integer  "animal_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.boolean  "administrator"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.string   "group_type"
    t.boolean  "receive_notifications", default: true
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
    t.string   "recommended_dosage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "animal_type_id"
    t.integer  "frequency"
    t.string   "series_name"
    t.integer  "series_number"
    t.integer  "series_interval"
    t.integer  "series_next_id"
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

  create_table "weights", force: true do |t|
    t.float    "measure_num"
    t.string   "measure_unit"
    t.date     "measure_date"
    t.integer  "animal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
