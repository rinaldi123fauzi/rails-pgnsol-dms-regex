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

ActiveRecord::Schema.define(version: 2022_01_19_090650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "category_of_findings", primary_key: "category_of_finding_id", id: :integer, default: -> { "nextval('category_of_findings_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cpars", id: :serial, force: :cascade do |t|
    t.string "cpar_no"
    t.integer "ncr_id"
    t.date "issued_date"
    t.string "request"
    t.string "to_responsible_discipline"
    t.string "issued_by"
    t.string "checked"
    t.string "approved"
    t.string "project_manager"
    t.string "category"
    t.string "potential_risk"
    t.string "root_cause"
    t.string "propose_corrective_action"
    t.string "resources_required_corrective"
    t.date "evective_corrective_date"
    t.string "person_in_charge_corrective"
    t.string "propose_preventive_action"
    t.string "resources_required_preventive"
    t.date "evective_preventive_date"
    t.string "person_in_charge_preventive"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dak_templates", force: :cascade do |t|
    t.string "description"
    t.string "file_upload"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "issued_by"
  end

  create_table "distributions", id: :serial, force: :cascade do |t|
    t.integer "document_id"
    t.integer "internal_audit_id"
    t.string "sender"
    t.string "receiver"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.string "attachment_file"
  end

  create_table "divisions", force: :cascade do |t|
    t.string "nama_divisi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document_classifications", primary_key: "document_classification_id", id: :integer, default: -> { "nextval('document_classifications_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "sub_document_type_id"
    t.string "classification_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "document_references", primary_key: "document_reference_id", id: :integer, default: -> { "nextval('document_references_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "reference_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "document_requests", id: :serial, force: :cascade do |t|
    t.integer "document_id"
    t.integer "internal_audit_id"
    t.string "requester"
    t.string "status_request"
    t.string "reason_request"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "document_reference_id"
    t.date "request_date"
    t.date "approve_date"
    t.date "end_date"
    t.string "file_copy", limit: 255
    t.string "division", limit: 255
    t.string "receiver"
    t.string "attachment_file"
    t.string "sub_status_request"
    t.string "reject_reason"
    t.string "position"
  end

  create_table "document_revisions", id: :serial, force: :cascade do |t|
    t.integer "document_id"
    t.string "description"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "file_upload"
    t.string "status"
  end

  create_table "document_types", primary_key: "document_type_id", id: :integer, default: -> { "nextval('document_types_id_seq1'::regclass)" }, force: :cascade do |t|
    t.string "type_name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "akses"
  end

  create_table "documents", primary_key: "document_id", id: :integer, default: -> { "nextval('documents_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "document_code"
    t.string "document_seq_no"
    t.string "revision", limit: 32
    t.string "document_title"
    t.string "issued_by"
    t.string "checked_by"
    t.string "approved_by"
    t.string "file_upload"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "document_date"
    t.string "reason"
    t.string "description_revision"
    t.string "checker"
    t.string "approve"
    t.integer "document_type_id"
    t.integer "sub_document_type_id"
    t.integer "document_reference_id"
    t.string "save_location", limit: 255
    t.date "save_date"
    t.string "keterangan", limit: 255
    t.string "sifat", limit: 255
    t.string "penanggung_jawab", limit: 255
    t.integer "document_classification_id"
    t.datetime "deleted_at", precision: 6
    t.integer "sub2_document_type_id"
  end

  create_table "fields", primary_key: "field_id", id: :integer, default: -> { "nextval('wr_docs_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "description_field"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "akses"
  end

  create_table "findings", primary_key: "finding_id", id: :integer, default: -> { "nextval('findings_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "finding_no"
    t.date "date"
    t.string "project_name"
    t.integer "category_of_finding_id"
    t.string "place"
    t.string "reference"
    t.string "clausul"
    t.string "description_finding"
    t.string "auditor"
    t.string "auditeee"
    t.string "status"
    t.string "file_photo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "followup_audits", force: :cascade do |t|
    t.bigint "internal_audit_id"
    t.string "notes"
    t.string "descriptions"
    t.string "file_upload"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "issued_by"
    t.index ["internal_audit_id"], name: "index_followup_audits_on_internal_audit_id"
  end

  create_table "internal_audits", id: :serial, force: :cascade do |t|
    t.string "report_no"
    t.date "audit_date"
    t.string "issued_by"
    t.string "description"
    t.string "file_upload"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.string "fungsi_audit"
    t.string "division"
    t.integer "tindak_lanjut"
  end

  create_table "internal_wr_audits", id: :serial, force: :cascade do |t|
    t.string "report_no"
    t.date "audit_date"
    t.string "issued_by"
    t.string "description"
    t.string "file_upload"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "log_activities", id: :serial, force: :cascade do |t|
    t.integer "member_id"
    t.string "document_code"
    t.datetime "activity_date", precision: 6
    t.text "activity"
    t.string "controller"
    t.string "action"
    t.string "browser"
    t.string "ip_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "members", primary_key: "member_id", id: :integer, default: -> { "nextval('members_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "nama"
    t.string "email"
    t.datetime "last_login", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "access_token", limit: 255
    t.string "status", limit: 50
  end

  create_table "ncrs", primary_key: "ncr_id", id: :integer, default: -> { "nextval('ncrs_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "ncr_no"
    t.integer "finding_id"
    t.date "issued_date"
    t.string "discipline"
    t.string "subject"
    t.string "issued_by"
    t.date "target_completion"
    t.string "description_non_conformance"
    t.string "original_requirement"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "permissions", primary_key: "permission_id", id: :integer, default: -> { "nextval('positions_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "member_id"
    t.integer "role_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "report_distributions", id: :serial, force: :cascade do |t|
    t.integer "report_id"
    t.string "sender"
    t.string "receiver"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
  end

  create_table "reports", primary_key: "report_id", id: :integer, default: -> { "nextval('reports_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "project_name"
    t.string "issued_by"
    t.date "date"
    t.string "file_upload"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles", primary_key: "role_id", id: :integer, default: -> { "nextval('roles_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "nama_role"
    t.string "keterangan"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sub2_document_types", primary_key: "sub2_document_type_id", id: :integer, default: -> { "nextval('sub2_document_types_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "sub_document_type_id"
    t.string "sub2_type_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sub2_fields", primary_key: "sub2_field_id", id: :integer, default: -> { "nextval('sub2_fields_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "sub_field_id"
    t.string "sub2_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "field_id"
    t.string "akses"
  end

  create_table "sub3_fields", primary_key: "sub3_field_id", id: :integer, default: -> { "nextval('sub3_fields_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "sub2_field_id"
    t.string "sub3_name_field"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sub_field_id"
    t.integer "field_id"
    t.string "akses"
  end

  create_table "sub4_fields", primary_key: "sub4_field_id", id: :integer, default: -> { "nextval('sub4_fields_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "sub3_field_id"
    t.string "sub4_name_field"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sub2_field_id"
    t.integer "sub_field_id"
    t.integer "field_id"
    t.string "akses"
  end

  create_table "sub_document_types", primary_key: "sub_document_type_id", id: :integer, default: -> { "nextval('sub_document_types_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "document_type_id"
    t.string "sub_type_name"
    t.string "sub_description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sub_fields", primary_key: "sub_field_id", id: :integer, default: -> { "nextval('sub_fields_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "field_id"
    t.string "description_sub_field"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "akses"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: 6
    t.datetime "last_sign_in_at", precision: 6
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wr_doc_distributions", id: :serial, force: :cascade do |t|
    t.integer "wr_doc_id"
    t.string "sender"
    t.string "receiver"
    t.date "date"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "attachment_file"
  end

  create_table "wr_doc_requests", id: :serial, force: :cascade do |t|
    t.integer "wr_doc_id"
    t.string "requester"
    t.string "status_request"
    t.string "reason_request"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "wr_doc_type_id"
    t.date "request_date"
    t.date "approve_date"
    t.date "end_date"
    t.string "file_copy", limit: 255
    t.string "division", limit: 255
    t.string "receiver"
    t.string "attachment_file"
    t.string "sub_status_request"
    t.string "reject_reason"
    t.string "position"
  end

  create_table "wr_doc_revisions", primary_key: "wr_doc_revision_id", id: :integer, default: -> { "nextval('wr_doc_revisions_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "wr_doc_id"
    t.string "description"
    t.date "date"
    t.string "file_upload"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wr_doc_types", primary_key: "wr_doc_type_id", id: :integer, default: -> { "nextval('document_types_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "document_name"
    t.string "desc_document"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wr_docs", primary_key: "wr_doc_id", id: :integer, default: -> { "nextval('wr_docs_id_seq1'::regclass)" }, force: :cascade do |t|
    t.string "document_code"
    t.string "document_title"
    t.integer "field_id"
    t.integer "sub_field_id"
    t.string "issued_by"
    t.string "checked_by"
    t.string "approved_by"
    t.date "date"
    t.string "file_upload"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "revision", limit: 32
    t.string "status"
    t.string "description_revision"
    t.string "checker"
    t.string "approve"
    t.integer "wr_doc_type_id"
    t.string "save_location", limit: 255
    t.date "save_date"
    t.string "keterangan", limit: 255
    t.string "sifat", limit: 255
    t.string "penanggung_jawab", limit: 255
    t.datetime "deleted_at", precision: 6
    t.integer "sub2_field_id"
    t.integer "sub3_field_id"
    t.integer "sub4_field_id"
  end

  add_foreign_key "cpars", "ncrs", primary_key: "ncr_id", name: "ncrs"
  add_foreign_key "distributions", "documents", primary_key: "document_id", name: "documents", on_update: :cascade, on_delete: :cascade
  add_foreign_key "distributions", "internal_audits", name: "internal_audits", on_update: :nullify, on_delete: :nullify
  add_foreign_key "document_classifications", "sub_document_types", primary_key: "sub_document_type_id", name: "fk_sub_document_types", on_update: :cascade, on_delete: :cascade
  add_foreign_key "document_requests", "documents", primary_key: "document_id", name: "documents", on_update: :cascade, on_delete: :cascade
  add_foreign_key "document_requests", "internal_audits", name: "internal_audits", on_update: :nullify, on_delete: :nullify
  add_foreign_key "document_revisions", "documents", primary_key: "document_id", name: "documents"
  add_foreign_key "documents", "document_classifications", primary_key: "document_classification_id", name: "fk_document_classifications", on_update: :cascade, on_delete: :cascade
  add_foreign_key "documents", "document_references", primary_key: "document_reference_id", name: "document_references", on_update: :cascade, on_delete: :cascade
  add_foreign_key "documents", "document_types", primary_key: "document_type_id", name: "document_types", on_update: :cascade, on_delete: :cascade
  add_foreign_key "documents", "sub2_document_types", primary_key: "sub2_document_type_id", name: "sub2_document_type", on_update: :cascade, on_delete: :cascade
  add_foreign_key "documents", "sub_document_types", primary_key: "sub_document_type_id", name: "sub_document_types", on_update: :cascade, on_delete: :cascade
  add_foreign_key "findings", "category_of_findings", primary_key: "category_of_finding_id", name: "category_of_findings"
  add_foreign_key "followup_audits", "internal_audits", on_delete: :cascade
  add_foreign_key "log_activities", "members", primary_key: "member_id", name: "fk_members"
  add_foreign_key "ncrs", "findings", primary_key: "finding_id", name: "findings"
  add_foreign_key "permissions", "members", primary_key: "member_id", name: "members", on_update: :nullify, on_delete: :nullify
  add_foreign_key "permissions", "roles", primary_key: "role_id", name: "roles", on_update: :nullify, on_delete: :nullify
  add_foreign_key "report_distributions", "reports", primary_key: "report_id", name: "reports"
  add_foreign_key "sub2_document_types", "sub_document_types", primary_key: "sub_document_type_id", name: "sub_document_types", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sub2_fields", "fields", primary_key: "field_id", name: "fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sub2_fields", "sub_fields", primary_key: "sub_field_id", name: "sub_fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sub3_fields", "fields", primary_key: "field_id", name: "fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sub3_fields", "sub2_fields", primary_key: "sub2_field_id", name: "sub2_fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sub3_fields", "sub_fields", primary_key: "sub_field_id", name: "sub_fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sub4_fields", "fields", primary_key: "field_id", name: "fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sub4_fields", "sub2_fields", primary_key: "sub2_field_id", name: "sub2_fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sub4_fields", "sub3_fields", primary_key: "sub3_field_id", name: "sub3_fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sub4_fields", "sub_fields", primary_key: "sub_field_id", name: "sub_fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sub_document_types", "document_types", primary_key: "document_type_id", name: "document_types", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sub_fields", "fields", primary_key: "field_id", name: "fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wr_doc_distributions", "wr_docs", primary_key: "wr_doc_id", name: "wr_docs"
  add_foreign_key "wr_doc_requests", "wr_docs", primary_key: "wr_doc_id", name: "wr_docs", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wr_doc_revisions", "wr_docs", primary_key: "wr_doc_id", name: "wr_docs"
  add_foreign_key "wr_docs", "fields", primary_key: "field_id", name: "fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wr_docs", "sub2_fields", primary_key: "sub2_field_id", name: "sub2_fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wr_docs", "sub3_fields", primary_key: "sub3_field_id", name: "sub3_fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wr_docs", "sub4_fields", primary_key: "sub4_field_id", name: "sub4_fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wr_docs", "sub_fields", primary_key: "sub_field_id", name: "sub_fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wr_docs", "wr_doc_types", primary_key: "wr_doc_type_id", name: "wr_doc_types", on_update: :cascade
end
