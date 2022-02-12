/*
 Navicat Premium Data Transfer

 Source Server         : local_postgresql_database
 Source Server Type    : PostgreSQL
 Source Server Version : 90602
 Source Host           : localhost:5432
 Source Catalog        : dms_prod
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 90602
 File Encoding         : 65001

 Date: 04/09/2019 14:45:25
*/


-- ----------------------------
-- Sequence structure for category_of_findings_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "category_of_findings_id_seq";
CREATE SEQUENCE "category_of_findings_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for cpars_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "cpars_id_seq";
CREATE SEQUENCE "cpars_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for distributions_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "distributions_id_seq";
CREATE SEQUENCE "distributions_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for document_classifications_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "document_classifications_id_seq";
CREATE SEQUENCE "document_classifications_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for document_references_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "document_references_id_seq";
CREATE SEQUENCE "document_references_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for document_requests_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "document_requests_id_seq";
CREATE SEQUENCE "document_requests_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for document_revisions_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "document_revisions_id_seq";
CREATE SEQUENCE "document_revisions_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for document_types_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "document_types_id_seq";
CREATE SEQUENCE "document_types_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for document_types_id_seq1
-- ----------------------------
DROP SEQUENCE IF EXISTS "document_types_id_seq1";
CREATE SEQUENCE "document_types_id_seq1" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for documents_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "documents_id_seq";
CREATE SEQUENCE "documents_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for findings_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "findings_id_seq";
CREATE SEQUENCE "findings_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for internal_audits_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "internal_audits_id_seq";
CREATE SEQUENCE "internal_audits_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for internal_wr_audits_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "internal_wr_audits_id_seq";
CREATE SEQUENCE "internal_wr_audits_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for log_activities_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "log_activities_id_seq";
CREATE SEQUENCE "log_activities_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for members_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "members_id_seq";
CREATE SEQUENCE "members_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for ncrs_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "ncrs_id_seq";
CREATE SEQUENCE "ncrs_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for positions_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "positions_id_seq";
CREATE SEQUENCE "positions_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for report_distributions_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "report_distributions_id_seq";
CREATE SEQUENCE "report_distributions_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for reports_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "reports_id_seq";
CREATE SEQUENCE "reports_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for roles_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "roles_id_seq";
CREATE SEQUENCE "roles_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sub_document_types_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "sub_document_types_id_seq";
CREATE SEQUENCE "sub_document_types_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sub_fields_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "sub_fields_id_seq";
CREATE SEQUENCE "sub_fields_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for users_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "users_id_seq";
CREATE SEQUENCE "users_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for wr_doc_distributions_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "wr_doc_distributions_id_seq";
CREATE SEQUENCE "wr_doc_distributions_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for wr_doc_requests_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "wr_doc_requests_id_seq";
CREATE SEQUENCE "wr_doc_requests_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for wr_doc_revisions_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "wr_doc_revisions_id_seq";
CREATE SEQUENCE "wr_doc_revisions_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for wr_docs_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "wr_docs_id_seq";
CREATE SEQUENCE "wr_docs_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for wr_docs_id_seq1
-- ----------------------------
DROP SEQUENCE IF EXISTS "wr_docs_id_seq1";
CREATE SEQUENCE "wr_docs_id_seq1" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for ar_internal_metadata
-- ----------------------------
DROP TABLE IF EXISTS "ar_internal_metadata";
CREATE TABLE "ar_internal_metadata" (
  "key" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "value" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Records of ar_internal_metadata
-- ----------------------------
BEGIN;
INSERT INTO "ar_internal_metadata" VALUES ('environment', 'development', '2019-04-18 06:33:14.189822', '2019-04-18 06:33:14.189822');
COMMIT;

-- ----------------------------
-- Table structure for category_of_findings
-- ----------------------------
DROP TABLE IF EXISTS "category_of_findings";
CREATE TABLE "category_of_findings" (
  "category_of_finding_id" int4 NOT NULL DEFAULT nextval('category_of_findings_id_seq'::regclass),
  "category_name" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Table structure for cpars
-- ----------------------------
DROP TABLE IF EXISTS "cpars";
CREATE TABLE "cpars" (
  "id" int4 NOT NULL DEFAULT nextval('cpars_id_seq'::regclass),
  "cpar_no" varchar COLLATE "pg_catalog"."default",
  "ncr_id" int4,
  "issued_date" date,
  "request" varchar COLLATE "pg_catalog"."default",
  "to_responsible_discipline" varchar COLLATE "pg_catalog"."default",
  "issued_by" varchar COLLATE "pg_catalog"."default",
  "checked" varchar COLLATE "pg_catalog"."default",
  "approved" varchar COLLATE "pg_catalog"."default",
  "project_manager" varchar COLLATE "pg_catalog"."default",
  "category" varchar COLLATE "pg_catalog"."default",
  "potential_risk" varchar COLLATE "pg_catalog"."default",
  "root_cause" varchar COLLATE "pg_catalog"."default",
  "propose_corrective_action" varchar COLLATE "pg_catalog"."default",
  "resources_required_corrective" varchar COLLATE "pg_catalog"."default",
  "evective_corrective_date" date,
  "person_in_charge_corrective" varchar COLLATE "pg_catalog"."default",
  "propose_preventive_action" varchar COLLATE "pg_catalog"."default",
  "resources_required_preventive" varchar COLLATE "pg_catalog"."default",
  "evective_preventive_date" date,
  "person_in_charge_preventive" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Table structure for distributions
-- ----------------------------
DROP TABLE IF EXISTS "distributions";
CREATE TABLE "distributions" (
  "id" int4 NOT NULL DEFAULT nextval('distributions_id_seq'::regclass),
  "document_id" int4,
  "internal_audit_id" int4,
  "sender" varchar COLLATE "pg_catalog"."default",
  "receiver" varchar COLLATE "pg_catalog"."default",
  "date" date,
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL,
  "status" varchar COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for document_classifications
-- ----------------------------
DROP TABLE IF EXISTS "document_classifications";
CREATE TABLE "document_classifications" (
  "document_classification_id" int4 NOT NULL DEFAULT nextval('document_classifications_id_seq'::regclass),
  "sub_document_type_id" int4,
  "classification_name" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Table structure for document_references
-- ----------------------------
DROP TABLE IF EXISTS "document_references";
CREATE TABLE "document_references" (
  "document_reference_id" int4 NOT NULL DEFAULT nextval('document_references_id_seq'::regclass),
  "reference_name" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Records of document_references
-- ----------------------------
BEGIN;
INSERT INTO "document_references" VALUES (1, 'Pedoman', '2019-06-13 09:56:59.180206', '2019-06-13 09:56:59.180206');
INSERT INTO "document_references" VALUES (2, 'Prosedur Operasi', '2019-06-13 09:57:55.114532', '2019-06-13 09:57:55.114532');
INSERT INTO "document_references" VALUES (3, 'Instruksi Kerja', '2019-06-13 09:59:03.068696', '2019-06-13 09:59:03.068696');
COMMIT;

-- ----------------------------
-- Table structure for document_requests
-- ----------------------------
DROP TABLE IF EXISTS "document_requests";
CREATE TABLE "document_requests" (
  "id" int4 NOT NULL DEFAULT nextval('document_requests_id_seq'::regclass),
  "document_id" int4,
  "internal_audit_id" int4,
  "requester" varchar COLLATE "pg_catalog"."default",
  "status_request" varchar COLLATE "pg_catalog"."default",
  "reason_request" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL,
  "document_reference_id" int4,
  "approve_date" date,
  "reason_reject" varchar(255) COLLATE "pg_catalog"."default",
  "request_date" date,
  "end_date" date
)
;

-- ----------------------------
-- Records of document_requests
-- ----------------------------
BEGIN;
INSERT INTO "document_requests" VALUES (40, 37, NULL, 'staf', 'Approved', 'testing', '2019-08-28 09:53:35.724217', '2019-08-28 09:56:43.738036', NULL, '2019-08-28', NULL, '2019-08-28', '2019-08-31');
COMMIT;

-- ----------------------------
-- Table structure for document_revisions
-- ----------------------------
DROP TABLE IF EXISTS "document_revisions";
CREATE TABLE "document_revisions" (
  "id" int4 NOT NULL DEFAULT nextval('document_revisions_id_seq'::regclass),
  "document_id" int4,
  "description" varchar COLLATE "pg_catalog"."default",
  "date" date,
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL,
  "file_upload" varchar COLLATE "pg_catalog"."default",
  "status" varchar COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for document_types
-- ----------------------------
DROP TABLE IF EXISTS "document_types";
CREATE TABLE "document_types" (
  "document_type_id" int4 NOT NULL DEFAULT nextval('document_types_id_seq1'::regclass),
  "type_name" varchar COLLATE "pg_catalog"."default",
  "description" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Records of document_types
-- ----------------------------
BEGIN;
INSERT INTO "document_types" VALUES (2, 'DAK', 'DAK', '2019-06-10 16:03:48.574628', '2019-06-10 16:03:48.574628');
INSERT INTO "document_types" VALUES (1, 'Corporate', 'Corporate', '2019-06-09 10:54:11.62462', '2019-06-10 15:22:19.458209');
INSERT INTO "document_types" VALUES (3, 'testing', 'testing', '2019-06-20 04:58:04.619223', '2019-06-20 04:58:04.619223');
COMMIT;

-- ----------------------------
-- Table structure for documents
-- ----------------------------
DROP TABLE IF EXISTS "documents";
CREATE TABLE "documents" (
  "document_id" int4 NOT NULL DEFAULT nextval('documents_id_seq'::regclass),
  "document_code" varchar COLLATE "pg_catalog"."default",
  "document_seq_no" varchar COLLATE "pg_catalog"."default",
  "revision" varchar(32) COLLATE "pg_catalog"."default",
  "document_title" varchar COLLATE "pg_catalog"."default",
  "issued_by" varchar COLLATE "pg_catalog"."default",
  "checked_by" varchar COLLATE "pg_catalog"."default",
  "approved_by" varchar COLLATE "pg_catalog"."default",
  "file_upload" varchar COLLATE "pg_catalog"."default",
  "status" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL,
  "document_date" date,
  "reason" varchar COLLATE "pg_catalog"."default",
  "description_revision" varchar COLLATE "pg_catalog"."default",
  "checker" varchar COLLATE "pg_catalog"."default",
  "approve" varchar COLLATE "pg_catalog"."default",
  "document_type_id" int4,
  "sub_document_type_id" int4,
  "document_reference_id" int4,
  "save_location" varchar(255) COLLATE "pg_catalog"."default",
  "save_date" date,
  "keterangan" varchar(255) COLLATE "pg_catalog"."default",
  "sifat" varchar(255) COLLATE "pg_catalog"."default",
  "penanggung_jawab" varchar(255) COLLATE "pg_catalog"."default",
  "document_classification_id" int4
)
;

-- ----------------------------
-- Records of documents
-- ----------------------------
BEGIN;
INSERT INTO "documents" VALUES (37, 'testing-1-1', NULL, '0', 'testing', 'inputer quality management', NULL, NULL, 'QM201908_101024_testing-1-1.pdf', 'Open', '2019-08-25 03:10:25.356836', '2019-08-25 03:10:25.356836', '2019-08-11', NULL, NULL, NULL, NULL, 2, 7, 3, 'Lt.3', '2019-08-08', '', 'Tidak Rahasia', 'Testing', NULL);
COMMIT;

-- ----------------------------
-- Table structure for fields
-- ----------------------------
DROP TABLE IF EXISTS "fields";
CREATE TABLE "fields" (
  "field_id" int4 NOT NULL DEFAULT nextval('wr_docs_id_seq'::regclass),
  "description_field" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Records of fields
-- ----------------------------
BEGIN;
INSERT INTO "fields" VALUES (2, 'Power Plant', '2019-04-18 23:45:47.689124', '2019-04-18 23:45:47.689124');
INSERT INTO "fields" VALUES (3, 'Renewable Energy', '2019-04-18 23:46:34.293417', '2019-04-18 23:46:34.293417');
INSERT INTO "fields" VALUES (4, 'Civil Property', '2019-04-18 23:47:29.912699', '2019-04-18 23:47:29.912699');
INSERT INTO "fields" VALUES (5, 'Civil Infrastructure', '2019-04-18 23:48:38.250934', '2019-04-18 23:48:38.250934');
INSERT INTO "fields" VALUES (6, 'Water', '2019-04-18 23:49:18.870804', '2019-04-18 23:49:18.870804');
INSERT INTO "fields" VALUES (7, 'QA/QC', '2019-04-18 23:50:04.52304', '2019-04-18 23:50:04.52304');
INSERT INTO "fields" VALUES (8, 'HSSE', '2019-04-18 23:51:03.746188', '2019-04-18 23:51:03.746188');
INSERT INTO "fields" VALUES (9, 'Telecomunication', '2019-04-18 23:51:59.380494', '2019-04-18 23:51:59.380494');
INSERT INTO "fields" VALUES (10, 'Storage Tank', '2019-04-18 23:54:31.764964', '2019-04-18 23:54:31.764964');
INSERT INTO "fields" VALUES (11, 'Mini LNG', '2019-04-18 23:55:30.654693', '2019-04-18 23:55:30.654693');
INSERT INTO "fields" VALUES (12, 'Gas', '2019-04-18 23:55:30.654693', '2019-04-18 23:55:30.654693');
INSERT INTO "fields" VALUES (1, 'Oil', '2019-04-18 23:44:59.114142', '2019-04-18 23:44:59.114142');
INSERT INTO "fields" VALUES (17, 'testing', '2019-06-20 04:57:49.486654', '2019-06-20 04:57:49.486654');
INSERT INTO "fields" VALUES (18, 'Civil', '2019-06-20 06:33:45.054711', '2019-06-20 06:33:45.054711');
INSERT INTO "fields" VALUES (19, 'Electrical', '2019-06-20 07:39:36.307847', '2019-06-20 07:39:36.307847');
INSERT INTO "fields" VALUES (20, 'Instrumentasi', '2019-06-20 07:40:33.385681', '2019-06-20 07:40:33.385681');
INSERT INTO "fields" VALUES (21, 'Mechanical Piping', '2019-06-20 07:41:41.399018', '2019-06-20 07:41:41.399018');
INSERT INTO "fields" VALUES (22, 'Pipeline', '2019-06-20 07:41:56.870425', '2019-06-20 07:41:56.870425');
INSERT INTO "fields" VALUES (23, 'Subduct Optical Fiber', '2019-06-20 07:44:51.519136', '2019-06-20 07:44:51.519136');
INSERT INTO "fields" VALUES (24, 'Submarine Optical Fiber', '2019-06-20 07:45:34.782901', '2019-06-20 07:45:34.782901');
INSERT INTO "fields" VALUES (25, 'Aerial Optical Fiber', '2019-06-20 07:45:59.101843', '2019-06-20 07:45:59.101843');
COMMIT;

-- ----------------------------
-- Table structure for findings
-- ----------------------------
DROP TABLE IF EXISTS "findings";
CREATE TABLE "findings" (
  "finding_id" int4 NOT NULL DEFAULT nextval('findings_id_seq'::regclass),
  "finding_no" varchar COLLATE "pg_catalog"."default",
  "date" date,
  "project_name" varchar COLLATE "pg_catalog"."default",
  "category_of_finding_id" int4,
  "place" varchar COLLATE "pg_catalog"."default",
  "reference" varchar COLLATE "pg_catalog"."default",
  "clausul" varchar COLLATE "pg_catalog"."default",
  "description_finding" varchar COLLATE "pg_catalog"."default",
  "auditor" varchar COLLATE "pg_catalog"."default",
  "auditeee" varchar COLLATE "pg_catalog"."default",
  "status" varchar COLLATE "pg_catalog"."default",
  "file_photo" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Table structure for internal_audits
-- ----------------------------
DROP TABLE IF EXISTS "internal_audits";
CREATE TABLE "internal_audits" (
  "internal_audit_id" int4 NOT NULL DEFAULT nextval('internal_audits_id_seq'::regclass),
  "report_no" varchar COLLATE "pg_catalog"."default",
  "audit_date" date,
  "issued_by" varchar COLLATE "pg_catalog"."default",
  "description" varchar COLLATE "pg_catalog"."default",
  "file_upload" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Table structure for internal_wr_audits
-- ----------------------------
DROP TABLE IF EXISTS "internal_wr_audits";
CREATE TABLE "internal_wr_audits" (
  "id" int4 NOT NULL DEFAULT nextval('internal_wr_audits_id_seq'::regclass),
  "report_no" varchar COLLATE "pg_catalog"."default",
  "audit_date" date,
  "issued_by" varchar COLLATE "pg_catalog"."default",
  "description" varchar COLLATE "pg_catalog"."default",
  "file_upload" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Table structure for log_activities
-- ----------------------------
DROP TABLE IF EXISTS "log_activities";
CREATE TABLE "log_activities" (
  "id" int4 NOT NULL DEFAULT nextval('log_activities_id_seq'::regclass),
  "member_id" int4,
  "document_code" varchar COLLATE "pg_catalog"."default",
  "activity_date" timestamp(6),
  "activity" text COLLATE "pg_catalog"."default",
  "controller" varchar COLLATE "pg_catalog"."default",
  "action" varchar COLLATE "pg_catalog"."default",
  "browser" varchar COLLATE "pg_catalog"."default",
  "ip_address" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Records of log_activities
-- ----------------------------
BEGIN;
INSERT INTO "log_activities" VALUES (1, 6, NULL, '2019-09-03 05:40:07', 'inputer quality management has been login ', 'sessions', 'create', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101 Firefox/68.0', '::1', '2019-09-02 22:40:07.534966', '2019-09-02 22:40:07.534966');
INSERT INTO "log_activities" VALUES (2, 6, NULL, '2019-09-03 05:42:28', 'inputer quality management has been logout ', 'sessions', 'destroy', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101 Firefox/68.0', '::1', '2019-09-02 22:42:28.857493', '2019-09-02 22:42:28.857493');
INSERT INTO "log_activities" VALUES (3, 1, NULL, '2019-09-04 02:06:41', 'Rinaldi Fauzi has been login ', 'sessions', 'create', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '::1', '2019-09-04 02:06:41.642134', '2019-09-04 02:06:41.642134');
INSERT INTO "log_activities" VALUES (4, 1, NULL, '2019-09-04 02:07:45', 'Rinaldi Fauzi has been logout ', 'sessions', 'destroy', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '::1', '2019-09-04 02:07:45.164406', '2019-09-04 02:07:45.164406');
INSERT INTO "log_activities" VALUES (5, 1, NULL, '2019-09-04 02:08:17', 'Rinaldi Fauzi has been login ', 'sessions', 'create', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '::1', '2019-09-04 02:08:17.724133', '2019-09-04 02:08:17.724133');
COMMIT;

-- ----------------------------
-- Table structure for members
-- ----------------------------
DROP TABLE IF EXISTS "members";
CREATE TABLE "members" (
  "member_id" int4 NOT NULL DEFAULT nextval('members_id_seq'::regclass),
  "username" varchar COLLATE "pg_catalog"."default",
  "password_digest" varchar COLLATE "pg_catalog"."default",
  "nama" varchar COLLATE "pg_catalog"."default",
  "email" varchar COLLATE "pg_catalog"."default",
  "last_login" timestamp(6),
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Records of members
-- ----------------------------
BEGIN;
INSERT INTO "members" VALUES (2, 'dirut', '$2a$10$GL1Epr.rlsJ.sQZwIMtQD.9.pWsOF1MG1lW/bmossWXNzAEG6j50S', 'Direktur Utama', 'dirut@gmail.com', '2019-04-18 09:04:00', '2019-04-18 09:04:42.037913', '2019-04-18 09:04:42.037913');
INSERT INTO "members" VALUES (3, 'kadiv', '$2a$10$NURYdW9TCnvpkKl/SGsy5u/mw0gm7.Vh/K/YfKHQ61/1KToryJSXu', 'kadiv', 'kadiv@gmail.com', '2019-04-22 02:49:00', '2019-04-22 02:49:38.294319', '2019-04-22 02:49:38.294319');
INSERT INTO "members" VALUES (4, 'staf', '$2a$10$uOSwpHbPTaWyq5DLBfsZzu5DJU1RGQJtv8Jfib4BPg2Ad/0ovJ..G', 'staf', 'rinalfauzi@gmail.com', '2019-05-13 03:56:00', '2019-05-06 03:57:48.58566', '2019-05-06 11:50:41.262792');
INSERT INTO "members" VALUES (6, 'inputer.qm', '$2a$10$ETACZFRorWtrsePXEyR4fuqsN5B5rQdWG69epxgQaFZwTzK/fAVSO', 'inputer quality management', 'inputer.qm@gmail.com', '2019-05-12 09:45:00', '2019-05-12 09:45:41.827499', '2019-05-12 09:45:41.827499');
INSERT INTO "members" VALUES (7, 'inputer.wr', '$2a$10$mH6dbFpWyC134fWCAi6Qo.IQ9Jb2PU7Ecaifm5TKYiv.cn4Utquhq', 'inputer work reference', 'inputer.wr@gmail.com', '2019-05-12 09:46:00', '2019-05-12 09:46:57.733714', '2019-05-12 09:46:57.733714');
INSERT INTO "members" VALUES (8, 'checker.qm', '$2a$10$DgvBNYXoKmFu7cqvJjZfveHn6zN3NHXxYBF.C6Gf1DikpE65.V.Wu', 'checker quality management', 'checker.qm@gmail.com', '2019-05-12 09:47:00', '2019-05-12 09:48:08.329895', '2019-05-12 09:48:08.329895');
INSERT INTO "members" VALUES (9, 'checker.wr', '$2a$10$enBIMv0wmHT.2Uc55Q7.Jest3faG5gm5q84jXhuq7Z56AvqukWnyG', 'checker work reference', 'checker.wr@gmail.com', '2019-05-12 09:48:00', '2019-05-12 09:49:43.625501', '2019-05-12 09:49:43.625501');
INSERT INTO "members" VALUES (13, 'staf1', '$2a$10$jEjDme/Gn1mYQJ6FM3go9eBvzpGbNVUw.X0wDm8xyQAbM.jQSP9b6', 'staf1', 'staf@gmail.com', '2019-06-20 06:53:00', '2019-06-20 06:54:26.247355', '2019-06-20 06:54:26.247355');
INSERT INTO "members" VALUES (14, 'staf2', '$2a$10$rRHWo2yHxkz42VaLp/xKleUe14ruMN2H3Cp93MeiTMnQ2NNNjfi1G', 'staf2', 'staf2@gmail.com', '2019-06-20 06:55:00', '2019-06-20 06:55:48.006083', '2019-06-20 06:55:48.006083');
INSERT INTO "members" VALUES (16, 'muhammad.sanjaya', '$2a$10$joBpAWkIlg4RTO9B6nUlv.d6Fp3m3gc5eDDKXd/J72howtAAEtQci', 'MUHAMMAD SANJAYA', 'muhammad.sanjaya@pgn-solution.co.id', NULL, '2019-07-10 04:57:30.085012', '2019-07-10 04:57:30.085012');
INSERT INTO "members" VALUES (15, 'boyke.tobing', '$2a$10$1ymHMQ8Zg3mTbiNM52jq6.q4WSorptOvKXsMKQ77DFzhxdN/keKV.', 'BOYKE TOBING', 'boyke.tobing@pgn-solution.co.id', NULL, '2019-07-10 04:57:12.113367', '2019-07-22 02:21:05.836344');
INSERT INTO "members" VALUES (17, 'harsi.sy', '$2a$10$XlArqA4NRWrftZFUv.Pkgelkig2JS.XgXP29EFc1XGgs81biCdv4G', 'HARSI SY', 'harsi.sy@pgn-solution.co.id', NULL, '2019-07-10 06:12:25.241423', '2019-07-10 06:12:25.241423');
INSERT INTO "members" VALUES (18, 'pahrizan.abadi', '$2a$10$Ekpdr.ev7bOuFSZld/9M3OtWWplZvZI7sdkWrz6KVcrUxDvs.HBri', 'PAHRIZAN ABADI', 'pahrizan.abadi@pgn-solution.co.id', NULL, '2019-07-10 06:12:57.166842', '2019-07-10 06:12:57.166842');
INSERT INTO "members" VALUES (19, 'naek.sirait', '$2a$10$ICgykSWRdcUX.K5JMUGHROhpvoQN7LP04wyqI33blEAlPX52OVmBy', 'NAEK SIRAIT', 'naek.sirait@pgn-solution.co.id', NULL, '2019-07-10 06:13:15.932694', '2019-07-10 06:13:15.932694');
INSERT INTO "members" VALUES (20, 'adi.ekawan', '$2a$10$.sdn30C7mx2p.TlrvO566uHvK58dAQ3Yzy6Nsjnhy4dQzu0PK2yrW', 'ADI EKAWAN', 'adi.ekawan@pgn-solution.co.id', NULL, '2019-07-10 06:13:29.724296', '2019-07-10 06:13:29.724296');
INSERT INTO "members" VALUES (21, 'akhsin.nasrudin', '$2a$10$Jw90D8b2/91GDvE/1fScje3bZPV07ti11Tm3naPXaB.1EywioeTQG', 'AKHSIN NASRUDIN', 'akhsin.nasrudin@pgn-solution.co.id', NULL, '2019-07-10 06:13:45.086261', '2019-07-10 06:13:45.086261');
INSERT INTO "members" VALUES (22, 'iqbal.fuady', '$2a$10$tieuCjstvXsT7Cec7ClLGe1SPkre4Dek6Xa6BOu5S841ukXRcAGoW', 'IQBAL FUADY', 'iqbal.fuady@pgn-solution.co.id', NULL, '2019-07-10 06:14:03.344444', '2019-07-10 06:14:03.344444');
INSERT INTO "members" VALUES (23, 'bamba', '$2a$10$SURinEUkyIoI5OOf.m6uPuuUConH8DQo4I9w8y9WAvfR5ji8ng4xK', 'BAMBA', 'bamba@pgn-solution.co.id', NULL, '2019-07-10 07:06:11.142895', '2019-07-10 07:06:11.142895');
INSERT INTO "members" VALUES (25, 'azhar', '$2a$10$.m4ChGiUFj1tDukZ3/vfgO1kGPHJAcVT5AYZuu.xFLJVuGaum2GEO', 'AZHAR', 'azhar@pgn-solution.co.id', NULL, '2019-07-29 04:34:23.234179', '2019-07-29 09:56:33.870239');
INSERT INTO "members" VALUES (12, 'superadmin', '$2a$10$Dx/qEa1JpM.7/.oeMrshjOMwzYaDSjNBrzP2iJxKqL0aFZDjfIv32', 'superadmin', 'superadmin@gmail.com', '2019-05-31 01:08:00', '2019-05-31 01:09:35.31521', '2019-07-30 07:51:24.336282');
INSERT INTO "members" VALUES (1, 'rinaldi.fauzi', '$2a$10$chkEC21tUS/k9URHEHe8he06PzoSNJlJ.zBSUeaowAjTCoXhqqfkK', 'Rinaldi Fauzi', 'rinalfauzi@gmail.com', '2019-04-18 06:38:00', '2019-04-18 06:39:08.276265', '2019-09-04 02:08:16.989097');
COMMIT;

-- ----------------------------
-- Table structure for ncrs
-- ----------------------------
DROP TABLE IF EXISTS "ncrs";
CREATE TABLE "ncrs" (
  "ncr_id" int4 NOT NULL DEFAULT nextval('ncrs_id_seq'::regclass),
  "ncr_no" varchar COLLATE "pg_catalog"."default",
  "finding_id" int4,
  "issued_date" date,
  "discipline" varchar COLLATE "pg_catalog"."default",
  "subject" varchar COLLATE "pg_catalog"."default",
  "issued_by" varchar COLLATE "pg_catalog"."default",
  "target_completion" date,
  "description_non_conformance" varchar COLLATE "pg_catalog"."default",
  "original_requirement" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS "permissions";
CREATE TABLE "permissions" (
  "permission_id" int4 NOT NULL DEFAULT nextval('positions_id_seq'::regclass),
  "member_id" int4,
  "role_id" int4,
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Records of permissions
-- ----------------------------
BEGIN;
INSERT INTO "permissions" VALUES (1, 1, 2, '2019-04-18 14:29:00', '2019-04-18 14:29:02');
INSERT INTO "permissions" VALUES (4, 4, 10, '2019-05-06 04:05:20.500757', '2019-05-06 04:05:20.500757');
INSERT INTO "permissions" VALUES (3, 3, 12, '2019-04-22 02:54:26.326091', '2019-04-22 02:54:26.326091');
INSERT INTO "permissions" VALUES (2, 1, 12, '2019-04-18 09:06:21.131698', '2019-05-06 12:02:08.344618');
INSERT INTO "permissions" VALUES (5, 6, 6, '2019-05-12 09:51:21.38005', '2019-05-12 09:51:21.38005');
INSERT INTO "permissions" VALUES (6, 7, 7, '2019-05-12 09:52:23.772828', '2019-05-12 09:52:23.772828');
INSERT INTO "permissions" VALUES (7, 8, 8, '2019-05-12 09:53:35.691541', '2019-05-12 09:53:35.691541');
INSERT INTO "permissions" VALUES (8, 9, 9, '2019-05-12 09:54:40.278105', '2019-05-12 09:54:40.278105');
INSERT INTO "permissions" VALUES (12, 13, 10, '2019-06-20 06:56:35.794929', '2019-06-20 06:56:35.794929');
INSERT INTO "permissions" VALUES (13, 14, 10, '2019-06-20 06:56:55.931916', '2019-06-20 06:56:55.931916');
INSERT INTO "permissions" VALUES (15, 16, 1, '2019-07-10 04:57:57.799884', '2019-07-27 06:44:00.5729');
INSERT INTO "permissions" VALUES (14, 15, 1, '2019-07-10 04:57:43.403507', '2019-07-27 06:44:20.07639');
INSERT INTO "permissions" VALUES (18, 17, 1, '2019-07-10 06:15:15.124853', '2019-07-27 06:44:36.061111');
INSERT INTO "permissions" VALUES (19, 18, 1, '2019-07-10 06:15:38.760693', '2019-07-27 06:44:49.125566');
INSERT INTO "permissions" VALUES (20, 19, 1, '2019-07-10 06:16:04.7707', '2019-07-27 06:45:35.22351');
INSERT INTO "permissions" VALUES (17, 20, 1, '2019-07-10 06:14:42.888595', '2019-07-27 06:45:49.383713');
INSERT INTO "permissions" VALUES (21, 21, 1, '2019-07-10 06:16:49.139765', '2019-07-27 06:46:34.14779');
INSERT INTO "permissions" VALUES (16, 22, 1, '2019-07-10 06:14:17.070077', '2019-07-27 06:47:05.054982');
INSERT INTO "permissions" VALUES (22, 23, 1, '2019-07-10 07:06:47.984702', '2019-07-27 06:47:23.108886');
INSERT INTO "permissions" VALUES (11, 12, 1, '2019-05-31 01:11:02.558386', '2019-07-30 08:02:02.493205');
INSERT INTO "permissions" VALUES (24, 25, 1, '2019-07-29 04:35:01.936526', '2019-07-29 04:35:01.936526');
COMMIT;

-- ----------------------------
-- Table structure for report_distributions
-- ----------------------------
DROP TABLE IF EXISTS "report_distributions";
CREATE TABLE "report_distributions" (
  "id" int4 NOT NULL DEFAULT nextval('report_distributions_id_seq'::regclass),
  "report_id" int4,
  "sender" varchar COLLATE "pg_catalog"."default",
  "receiver" varchar COLLATE "pg_catalog"."default",
  "date" date,
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL,
  "status" varchar COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of report_distributions
-- ----------------------------
BEGIN;
INSERT INTO "report_distributions" VALUES (1, 2, 'Rinaldi Fauzi', 'Rinaldi Fauzi', '2019-05-19', '2019-05-19 06:07:56.082941', '2019-05-19 06:07:56.082941', 'Pending');
INSERT INTO "report_distributions" VALUES (2, 2, 'Rinaldi Fauzi', 'staf', '2019-05-19', '2019-05-19 06:07:56.365391', '2019-05-19 06:07:56.365391', 'Pending');
INSERT INTO "report_distributions" VALUES (3, 2, 'Rinaldi Fauzi', 'inputer quality management', '2019-05-19', '2019-05-19 06:07:56.64725', '2019-05-19 06:07:56.64725', 'Pending');
COMMIT;

-- ----------------------------
-- Table structure for reports
-- ----------------------------
DROP TABLE IF EXISTS "reports";
CREATE TABLE "reports" (
  "report_id" int4 NOT NULL DEFAULT nextval('reports_id_seq'::regclass),
  "project_name" varchar COLLATE "pg_catalog"."default",
  "issued_by" varchar COLLATE "pg_catalog"."default",
  "date" date,
  "file_upload" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Records of reports
-- ----------------------------
BEGIN;
INSERT INTO "reports" VALUES (1, '', 'Rinaldi Fauzi', NULL, NULL, '2019-05-19 04:47:30.403238', '2019-05-19 04:47:30.403238');
INSERT INTO "reports" VALUES (2, 'testing_1', 'Rinaldi Fauzi', '2019-05-20', 'REPORT201905_122118_testing_1.pdf', '2019-05-19 05:21:18.483732', '2019-05-19 05:21:18.483732');
COMMIT;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS "roles";
CREATE TABLE "roles" (
  "role_id" int4 NOT NULL DEFAULT nextval('roles_id_seq'::regclass),
  "nama_role" varchar COLLATE "pg_catalog"."default",
  "keterangan" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
INSERT INTO "roles" VALUES (1, 'Off', 'Tidak Aktif', '2019-04-18 14:28:43', '2019-04-18 14:28:46');
INSERT INTO "roles" VALUES (2, 'SuperAdmin', 'SuperAdmin', '2019-04-18 09:02:47.827475', '2019-04-18 09:02:47.827475');
INSERT INTO "roles" VALUES (3, 'Admin', 'Admin', '2019-04-18 09:03:30.670831', '2019-04-18 09:03:30.670831');
INSERT INTO "roles" VALUES (4, 'DIRUT', 'Direktur Utama', '2019-04-18 14:28:43', '2019-04-18 14:28:43');
INSERT INTO "roles" VALUES (5, 'Direktur', 'Direktur', '2019-04-18 14:28:43', '2019-04-18 14:28:43');
INSERT INTO "roles" VALUES (6, 'Inputer QM', 'Inputer Quality Management', '2019-04-18 14:28:43', '2019-04-18 14:28:43');
INSERT INTO "roles" VALUES (7, 'Inputer WR', 'Inputer Work Reference', '2019-04-18 14:28:43', '2019-04-18 14:28:43');
INSERT INTO "roles" VALUES (8, 'Checker QM', 'Checker Quality Management', '2019-04-18 14:28:43', '2019-04-18 14:28:43');
INSERT INTO "roles" VALUES (9, 'Checker WR', 'Checker Work Reference', '2019-04-18 14:28:43', '2019-04-18 14:28:43');
INSERT INTO "roles" VALUES (10, 'Staff', 'Staff', '2019-04-18 14:28:43', '2019-04-18 14:28:43');
INSERT INTO "roles" VALUES (11, 'Satuan Kerja', 'Kepala Satuan Kerja', '2019-04-18 14:28:43', '2019-04-18 14:28:43');
INSERT INTO "roles" VALUES (12, 'Kadiv', 'Kepala Divisi', '2019-04-18 14:28:43', '2019-04-18 14:28:43');
INSERT INTO "roles" VALUES (13, 'Kadep', 'Kepala Departemen', '2019-04-18 14:28:43', '2019-04-18 14:28:43');
INSERT INTO "roles" VALUES (14, 'PM', 'Project Manager', '2019-04-18 14:28:43', '2019-04-18 14:28:43');
COMMIT;

-- ----------------------------
-- Table structure for schema_migrations
-- ----------------------------
DROP TABLE IF EXISTS "schema_migrations";
CREATE TABLE "schema_migrations" (
  "version" varchar COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of schema_migrations
-- ----------------------------
BEGIN;
INSERT INTO "schema_migrations" VALUES ('20160907132658');
INSERT INTO "schema_migrations" VALUES ('20190418063410');
INSERT INTO "schema_migrations" VALUES ('20190418071122');
INSERT INTO "schema_migrations" VALUES ('20190418071423');
INSERT INTO "schema_migrations" VALUES ('20190418132042');
INSERT INTO "schema_migrations" VALUES ('20190419054701');
INSERT INTO "schema_migrations" VALUES ('20190419112711');
INSERT INTO "schema_migrations" VALUES ('20190422033808');
INSERT INTO "schema_migrations" VALUES ('20190423030752');
INSERT INTO "schema_migrations" VALUES ('20190423031239');
INSERT INTO "schema_migrations" VALUES ('20190425010800');
INSERT INTO "schema_migrations" VALUES ('20190428112139');
INSERT INTO "schema_migrations" VALUES ('20190503025415');
INSERT INTO "schema_migrations" VALUES ('20190503091750');
INSERT INTO "schema_migrations" VALUES ('20190506022842');
INSERT INTO "schema_migrations" VALUES ('20190507150737');
INSERT INTO "schema_migrations" VALUES ('20190508013900');
INSERT INTO "schema_migrations" VALUES ('20190508015532');
INSERT INTO "schema_migrations" VALUES ('20190508025722');
INSERT INTO "schema_migrations" VALUES ('20190508032706');
INSERT INTO "schema_migrations" VALUES ('20190508033129');
INSERT INTO "schema_migrations" VALUES ('20190510072643');
INSERT INTO "schema_migrations" VALUES ('20190510073859');
INSERT INTO "schema_migrations" VALUES ('20190511081132');
INSERT INTO "schema_migrations" VALUES ('20190512133014');
INSERT INTO "schema_migrations" VALUES ('20190512133100');
INSERT INTO "schema_migrations" VALUES ('20190512144040');
INSERT INTO "schema_migrations" VALUES ('20190512144112');
INSERT INTO "schema_migrations" VALUES ('20190518023500');
INSERT INTO "schema_migrations" VALUES ('20190518024916');
INSERT INTO "schema_migrations" VALUES ('20190518031619');
INSERT INTO "schema_migrations" VALUES ('20190518032236');
INSERT INTO "schema_migrations" VALUES ('20190518033423');
INSERT INTO "schema_migrations" VALUES ('20190519054003');
INSERT INTO "schema_migrations" VALUES ('20190519055821');
INSERT INTO "schema_migrations" VALUES ('20190529044125');
INSERT INTO "schema_migrations" VALUES ('20190529063229');
INSERT INTO "schema_migrations" VALUES ('20190609095817');
INSERT INTO "schema_migrations" VALUES ('20190609100104');
INSERT INTO "schema_migrations" VALUES ('20190609100516');
INSERT INTO "schema_migrations" VALUES ('20190609100629');
INSERT INTO "schema_migrations" VALUES ('20190613085046');
INSERT INTO "schema_migrations" VALUES ('20190617070234');
INSERT INTO "schema_migrations" VALUES ('20190618040430');
INSERT INTO "schema_migrations" VALUES ('20190708072427');
INSERT INTO "schema_migrations" VALUES ('20190831011319');
INSERT INTO "schema_migrations" VALUES ('20190902125020');
COMMIT;

-- ----------------------------
-- Table structure for sub_document_types
-- ----------------------------
DROP TABLE IF EXISTS "sub_document_types";
CREATE TABLE "sub_document_types" (
  "sub_document_type_id" int4 NOT NULL DEFAULT nextval('sub_document_types_id_seq'::regclass),
  "document_type_id" int4,
  "sub_type_name" varchar COLLATE "pg_catalog"."default",
  "sub_description" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Records of sub_document_types
-- ----------------------------
BEGIN;
INSERT INTO "sub_document_types" VALUES (3, 1, 'Fakta Komitmen', 'Fakta Komitmen', '2019-06-10 16:05:40.249801', '2019-06-10 16:05:40.249801');
INSERT INTO "sub_document_types" VALUES (4, 1, 'Struktur Organisasi', 'Struktur Organisasi', '2019-06-10 16:06:55.901366', '2019-06-10 16:06:55.901366');
INSERT INTO "sub_document_types" VALUES (5, 2, 'Keuangan', 'Keuangan', '2019-06-10 23:43:50.885865', '2019-06-10 23:43:50.885865');
INSERT INTO "sub_document_types" VALUES (6, 2, 'Logistik & Administrasi', 'Logistik & Administrasi', '2019-06-10 23:45:38.065307', '2019-06-10 23:45:38.065307');
INSERT INTO "sub_document_types" VALUES (1, 1, 'Proses Bisnis', 'Proses Bisnis', '2019-06-09 10:55:55.545776', '2019-06-10 23:39:08.657642');
INSERT INTO "sub_document_types" VALUES (2, 1, 'Strategi / Sasaran Mutu', 'Strategi / Sasaran Mutu', '2019-06-09 10:59:51.726322', '2019-06-10 16:08:01.019118');
INSERT INTO "sub_document_types" VALUES (7, 2, 'Informasi Komunikasi dan Teknologi', '', '2019-06-17 01:17:30.950104', '2019-06-17 01:17:30.950104');
INSERT INTO "sub_document_types" VALUES (8, 3, 'testing', 'testing', '2019-06-20 04:58:34.140438', '2019-06-20 04:58:34.140438');
COMMIT;

-- ----------------------------
-- Table structure for sub_fields
-- ----------------------------
DROP TABLE IF EXISTS "sub_fields";
CREATE TABLE "sub_fields" (
  "sub_field_id" int4 NOT NULL DEFAULT nextval('sub_fields_id_seq'::regclass),
  "field_id" int4,
  "description_sub_field" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Records of sub_fields
-- ----------------------------
BEGIN;
INSERT INTO "sub_fields" VALUES (1, 5, 'General', '2019-05-07 16:17:53.707058', '2019-05-07 16:17:53.707058');
INSERT INTO "sub_fields" VALUES (2, 5, 'Sipil', '2019-05-07 21:08:57.068041', '2019-05-07 21:08:57.068041');
INSERT INTO "sub_fields" VALUES (4, 2, 'General', '2019-05-29 06:02:01.885039', '2019-05-29 06:02:48.52835');
INSERT INTO "sub_fields" VALUES (5, 2, 'Elektrikal', '2019-05-29 06:04:14.472427', '2019-05-29 06:04:14.472427');
INSERT INTO "sub_fields" VALUES (6, 2, 'Mechanical', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (9, 2, 'Sipil', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (10, 2, 'Piping', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (11, 2, 'QA / QC', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (12, 2, 'Instrumen', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (13, 2, 'Telekom', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (14, 2, 'Proses', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (15, 11, 'General', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (17, 11, 'Mechanical', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (18, 11, 'Proses', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (19, 11, 'Instrumen', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (20, 11, 'Sipil', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (21, 11, 'HSE', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (22, 11, 'QA / QC', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (23, 11, 'Piping', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (25, 11, 'Elektrikal', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (26, 11, 'Proses', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (27, 1, 'General', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (28, 1, 'Mechanical', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (29, 1, 'Pipeline', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (30, 1, 'Sipil', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (31, 1, 'QA / QC', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (32, 4, 'General', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (33, 4, 'Sipil', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (34, 4, 'Mechanical', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (35, 4, 'Elektrikal', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (36, 8, 'General', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (37, 8, 'HSE', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (38, 7, 'General', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (39, 7, 'QA / QC', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (40, 3, 'General', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (41, 3, 'Mechanical', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (42, 3, 'Sipil', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (43, 3, 'Elektrikal', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (44, 3, 'Instrumen', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (45, 3, 'QA / QC', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (46, 3, 'HSE', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (47, 3, 'Process', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (48, 9, 'General', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (49, 9, 'Telekom', '2019-05-29 06:05:08.544882', '2019-05-29 06:05:08.544882');
INSERT INTO "sub_fields" VALUES (52, 18, 'General', '2019-06-20 06:34:54.144793', '2019-06-20 06:34:54.144793');
INSERT INTO "sub_fields" VALUES (51, 12, 'General', '2019-06-20 04:57:13.238596', '2019-06-20 07:38:22.438288');
INSERT INTO "sub_fields" VALUES (53, 6, 'General', '2019-06-20 07:49:51.094604', '2019-06-20 07:49:51.094604');
INSERT INTO "sub_fields" VALUES (54, 10, 'General', '2019-06-20 08:03:55.407383', '2019-06-20 08:03:55.407383');
INSERT INTO "sub_fields" VALUES (55, 19, 'General', '2019-06-27 03:29:33.124088', '2019-06-27 03:29:33.124088');
INSERT INTO "sub_fields" VALUES (56, 20, 'General', '2019-06-27 03:30:22.243645', '2019-06-27 03:30:22.243645');
INSERT INTO "sub_fields" VALUES (57, 21, 'General', '2019-06-27 03:30:36.430454', '2019-06-27 03:30:36.430454');
INSERT INTO "sub_fields" VALUES (58, 25, 'General', '2019-06-27 03:31:39.906033', '2019-06-27 03:31:39.906033');
INSERT INTO "sub_fields" VALUES (59, 23, 'General', '2019-06-27 03:32:26.466299', '2019-06-27 03:32:26.466299');
INSERT INTO "sub_fields" VALUES (60, 24, 'General', '2019-06-27 03:32:50.502036', '2019-06-27 03:32:50.502036');
INSERT INTO "sub_fields" VALUES (61, 22, 'General', '2019-06-27 03:33:28.198939', '2019-06-27 03:33:28.198939');
INSERT INTO "sub_fields" VALUES (62, 10, 'Mechanical', '2019-07-01 04:11:27.020272', '2019-07-01 04:11:27.020272');
INSERT INTO "sub_fields" VALUES (63, 10, 'Sipil', '2019-07-01 04:12:21.444351', '2019-07-01 04:12:21.444351');
INSERT INTO "sub_fields" VALUES (64, 6, 'Pipeline', '2019-07-01 04:25:43.584138', '2019-07-01 04:25:43.584138');
INSERT INTO "sub_fields" VALUES (65, 10, 'QAQC', '2019-07-01 04:29:54.451894', '2019-07-01 04:29:54.451894');
INSERT INTO "sub_fields" VALUES (66, 11, 'Instrumen', '2019-07-01 04:31:03.770827', '2019-07-01 04:31:03.770827');
INSERT INTO "sub_fields" VALUES (67, 11, 'Elektrikal', '2019-07-01 04:31:37.500311', '2019-07-01 04:31:37.500311');
INSERT INTO "sub_fields" VALUES (68, 11, 'Proses', '2019-07-01 04:32:17.055511', '2019-07-01 04:32:17.055511');
INSERT INTO "sub_fields" VALUES (69, 25, 'Mechanical', '2019-07-02 07:30:02.04502', '2019-07-02 07:30:02.04502');
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "users";
CREATE TABLE "users" (
  "id" int4 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
  "email" varchar COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "encrypted_password" varchar COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "reset_password_token" varchar COLLATE "pg_catalog"."default",
  "reset_password_sent_at" timestamp(6),
  "remember_created_at" timestamp(6),
  "sign_in_count" int4 NOT NULL DEFAULT 0,
  "current_sign_in_at" timestamp(6),
  "last_sign_in_at" timestamp(6),
  "current_sign_in_ip" varchar COLLATE "pg_catalog"."default",
  "last_sign_in_ip" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Table structure for wr_doc_distributions
-- ----------------------------
DROP TABLE IF EXISTS "wr_doc_distributions";
CREATE TABLE "wr_doc_distributions" (
  "id" int4 NOT NULL DEFAULT nextval('wr_doc_distributions_id_seq'::regclass),
  "wr_doc_id" int4,
  "sender" varchar COLLATE "pg_catalog"."default",
  "receiver" varchar COLLATE "pg_catalog"."default",
  "date" date,
  "status" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Table structure for wr_doc_requests
-- ----------------------------
DROP TABLE IF EXISTS "wr_doc_requests";
CREATE TABLE "wr_doc_requests" (
  "id" int4 NOT NULL DEFAULT nextval('wr_doc_requests_id_seq'::regclass),
  "wr_doc_id" int4,
  "requester" varchar COLLATE "pg_catalog"."default",
  "status_request" varchar COLLATE "pg_catalog"."default",
  "reason_request" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL,
  "wr_doc_type_id" int4,
  "approve_date" date,
  "request_date" date,
  "end_date" date
)
;

-- ----------------------------
-- Table structure for wr_doc_revisions
-- ----------------------------
DROP TABLE IF EXISTS "wr_doc_revisions";
CREATE TABLE "wr_doc_revisions" (
  "wr_doc_revision_id" int4 NOT NULL DEFAULT nextval('wr_doc_revisions_id_seq'::regclass),
  "wr_doc_id" int4,
  "description" varchar COLLATE "pg_catalog"."default",
  "date" date,
  "file_upload" varchar COLLATE "pg_catalog"."default",
  "status" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Table structure for wr_doc_types
-- ----------------------------
DROP TABLE IF EXISTS "wr_doc_types";
CREATE TABLE "wr_doc_types" (
  "wr_doc_type_id" int4 NOT NULL DEFAULT nextval('document_types_id_seq'::regclass),
  "document_name" varchar COLLATE "pg_catalog"."default",
  "desc_document" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Records of wr_doc_types
-- ----------------------------
BEGIN;
INSERT INTO "wr_doc_types" VALUES (1, 'PEDOMAN', 'PEDOMAN', '2019-05-29 13:35:16', '2019-05-29 13:35:19');
INSERT INTO "wr_doc_types" VALUES (2, 'PROSEDUR OPERASI', 'PROSEDUR OPERASI', '2019-05-29 13:35:45', '2019-05-29 13:35:48');
INSERT INTO "wr_doc_types" VALUES (3, 'PROSEDUR KERJA', 'PROSEDUR KERJA', '2019-05-29 13:36:12', '2019-05-29 13:36:14');
COMMIT;

-- ----------------------------
-- Table structure for wr_docs
-- ----------------------------
DROP TABLE IF EXISTS "wr_docs";
CREATE TABLE "wr_docs" (
  "wr_doc_id" int4 NOT NULL DEFAULT nextval('wr_docs_id_seq1'::regclass),
  "document_code" varchar COLLATE "pg_catalog"."default",
  "document_title" varchar COLLATE "pg_catalog"."default",
  "field_id" int4,
  "sub_field_id" int4,
  "issued_by" varchar COLLATE "pg_catalog"."default",
  "checked_by" varchar COLLATE "pg_catalog"."default",
  "approved_by" varchar COLLATE "pg_catalog"."default",
  "date" date,
  "file_upload" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL,
  "revision" varchar(32) COLLATE "pg_catalog"."default",
  "status" varchar COLLATE "pg_catalog"."default",
  "description_revision" varchar COLLATE "pg_catalog"."default",
  "checker" varchar COLLATE "pg_catalog"."default",
  "approve" varchar COLLATE "pg_catalog"."default",
  "wr_doc_type_id" int4,
  "save_location" varchar(255) COLLATE "pg_catalog"."default",
  "save_date" date,
  "keterangan" varchar(255) COLLATE "pg_catalog"."default",
  "sifat" varchar(255) COLLATE "pg_catalog"."default",
  "penanggung_jawab" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of wr_docs
-- ----------------------------
BEGIN;
INSERT INTO "wr_docs" VALUES (44, '001.doc.2019', 'dokumen pertama', 8, 36, 'inputer work reference', NULL, NULL, '2019-08-18', 'WR201908_134722_001.doc.2019.pdf', '2019-08-18 06:47:23.515628', '2019-08-27 12:13:33.388596', '0', 'Open', NULL, NULL, NULL, 1, 'Lt.3 barat', '2010-03-11', 'cinta karena cinta...', 'Rahasia', 'Testing');
COMMIT;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "category_of_findings_id_seq"
OWNED BY "category_of_findings"."category_of_finding_id";
SELECT setval('"category_of_findings_id_seq"', 6, false);
ALTER SEQUENCE "cpars_id_seq"
OWNED BY "cpars"."id";
SELECT setval('"cpars_id_seq"', 6, false);
ALTER SEQUENCE "distributions_id_seq"
OWNED BY "distributions"."id";
SELECT setval('"distributions_id_seq"', 4, false);
ALTER SEQUENCE "document_classifications_id_seq"
OWNED BY "document_classifications"."document_classification_id";
SELECT setval('"document_classifications_id_seq"', 2, false);
ALTER SEQUENCE "document_references_id_seq"
OWNED BY "document_references"."document_reference_id";
SELECT setval('"document_references_id_seq"', 5, false);
ALTER SEQUENCE "document_requests_id_seq"
OWNED BY "document_requests"."id";
SELECT setval('"document_requests_id_seq"', 42, true);
ALTER SEQUENCE "document_revisions_id_seq"
OWNED BY "document_revisions"."id";
SELECT setval('"document_revisions_id_seq"', 4, false);
ALTER SEQUENCE "document_types_id_seq"
OWNED BY "wr_doc_types"."wr_doc_type_id";
SELECT setval('"document_types_id_seq"', 8, true);
ALTER SEQUENCE "document_types_id_seq1"
OWNED BY "document_types"."document_type_id";
SELECT setval('"document_types_id_seq1"', 7, true);
ALTER SEQUENCE "documents_id_seq"
OWNED BY "documents"."document_id";
SELECT setval('"documents_id_seq"', 39, true);
ALTER SEQUENCE "findings_id_seq"
OWNED BY "findings"."finding_id";
SELECT setval('"findings_id_seq"', 6, false);
ALTER SEQUENCE "internal_audits_id_seq"
OWNED BY "internal_audits"."internal_audit_id";
SELECT setval('"internal_audits_id_seq"', 10, true);
ALTER SEQUENCE "internal_wr_audits_id_seq"
OWNED BY "internal_wr_audits"."id";
SELECT setval('"internal_wr_audits_id_seq"', 6, true);
ALTER SEQUENCE "log_activities_id_seq"
OWNED BY "log_activities"."id";
SELECT setval('"log_activities_id_seq"', 6, true);
ALTER SEQUENCE "members_id_seq"
OWNED BY "members"."member_id";
SELECT setval('"members_id_seq"', 28, true);
ALTER SEQUENCE "ncrs_id_seq"
OWNED BY "ncrs"."ncr_id";
SELECT setval('"ncrs_id_seq"', 6, false);
ALTER SEQUENCE "positions_id_seq"
OWNED BY "permissions"."permission_id";
SELECT setval('"positions_id_seq"', 27, true);
ALTER SEQUENCE "report_distributions_id_seq"
OWNED BY "report_distributions"."id";
SELECT setval('"report_distributions_id_seq"', 8, true);
ALTER SEQUENCE "reports_id_seq"
OWNED BY "reports"."report_id";
SELECT setval('"reports_id_seq"', 7, true);
ALTER SEQUENCE "roles_id_seq"
OWNED BY "roles"."role_id";
SELECT setval('"roles_id_seq"', 21, true);
ALTER SEQUENCE "sub_document_types_id_seq"
OWNED BY "sub_document_types"."sub_document_type_id";
SELECT setval('"sub_document_types_id_seq"', 12, true);
ALTER SEQUENCE "sub_fields_id_seq"
OWNED BY "sub_fields"."sub_field_id";
SELECT setval('"sub_fields_id_seq"', 73, true);
ALTER SEQUENCE "users_id_seq"
OWNED BY "users"."id";
SELECT setval('"users_id_seq"', 8, false);
ALTER SEQUENCE "wr_doc_distributions_id_seq"
OWNED BY "wr_doc_distributions"."id";
SELECT setval('"wr_doc_distributions_id_seq"', 4, false);
ALTER SEQUENCE "wr_doc_requests_id_seq"
OWNED BY "wr_doc_requests"."id";
SELECT setval('"wr_doc_requests_id_seq"', 6, true);
ALTER SEQUENCE "wr_doc_revisions_id_seq"
OWNED BY "wr_doc_revisions"."wr_doc_revision_id";
SELECT setval('"wr_doc_revisions_id_seq"', 4, false);
ALTER SEQUENCE "wr_docs_id_seq"
OWNED BY "fields"."field_id";
SELECT setval('"wr_docs_id_seq"', 4, false);
ALTER SEQUENCE "wr_docs_id_seq1"
OWNED BY "wr_docs"."wr_doc_id";
SELECT setval('"wr_docs_id_seq1"', 46, true);

-- ----------------------------
-- Primary Key structure for table ar_internal_metadata
-- ----------------------------
ALTER TABLE "ar_internal_metadata" ADD CONSTRAINT "ar_internal_metadata_pkey" PRIMARY KEY ("key");

-- ----------------------------
-- Primary Key structure for table category_of_findings
-- ----------------------------
ALTER TABLE "category_of_findings" ADD CONSTRAINT "category_of_findings_pkey" PRIMARY KEY ("category_of_finding_id");

-- ----------------------------
-- Primary Key structure for table cpars
-- ----------------------------
ALTER TABLE "cpars" ADD CONSTRAINT "cpars_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table distributions
-- ----------------------------
ALTER TABLE "distributions" ADD CONSTRAINT "distributions_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table document_classifications
-- ----------------------------
ALTER TABLE "document_classifications" ADD CONSTRAINT "document_classifications_pkey" PRIMARY KEY ("document_classification_id");

-- ----------------------------
-- Primary Key structure for table document_references
-- ----------------------------
ALTER TABLE "document_references" ADD CONSTRAINT "document_references_pkey" PRIMARY KEY ("document_reference_id");

-- ----------------------------
-- Primary Key structure for table document_requests
-- ----------------------------
ALTER TABLE "document_requests" ADD CONSTRAINT "document_requests_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table document_revisions
-- ----------------------------
ALTER TABLE "document_revisions" ADD CONSTRAINT "document_revisions_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table document_types
-- ----------------------------
ALTER TABLE "document_types" ADD CONSTRAINT "document_types_pkey1" PRIMARY KEY ("document_type_id");

-- ----------------------------
-- Primary Key structure for table documents
-- ----------------------------
ALTER TABLE "documents" ADD CONSTRAINT "documents_pkey" PRIMARY KEY ("document_id");

-- ----------------------------
-- Primary Key structure for table fields
-- ----------------------------
ALTER TABLE "fields" ADD CONSTRAINT "wr_docs_pkey" PRIMARY KEY ("field_id");

-- ----------------------------
-- Primary Key structure for table findings
-- ----------------------------
ALTER TABLE "findings" ADD CONSTRAINT "findings_pkey" PRIMARY KEY ("finding_id");

-- ----------------------------
-- Primary Key structure for table internal_audits
-- ----------------------------
ALTER TABLE "internal_audits" ADD CONSTRAINT "internal_audits_pkey" PRIMARY KEY ("internal_audit_id");

-- ----------------------------
-- Primary Key structure for table internal_wr_audits
-- ----------------------------
ALTER TABLE "internal_wr_audits" ADD CONSTRAINT "internal_wr_audits_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table log_activities
-- ----------------------------
ALTER TABLE "log_activities" ADD CONSTRAINT "log_activities_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table members
-- ----------------------------
ALTER TABLE "members" ADD CONSTRAINT "members_pkey" PRIMARY KEY ("member_id");

-- ----------------------------
-- Primary Key structure for table ncrs
-- ----------------------------
ALTER TABLE "ncrs" ADD CONSTRAINT "ncrs_pkey" PRIMARY KEY ("ncr_id");

-- ----------------------------
-- Primary Key structure for table permissions
-- ----------------------------
ALTER TABLE "permissions" ADD CONSTRAINT "positions_pkey" PRIMARY KEY ("permission_id");

-- ----------------------------
-- Primary Key structure for table report_distributions
-- ----------------------------
ALTER TABLE "report_distributions" ADD CONSTRAINT "report_distributions_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table reports
-- ----------------------------
ALTER TABLE "reports" ADD CONSTRAINT "reports_pkey" PRIMARY KEY ("report_id");

-- ----------------------------
-- Primary Key structure for table roles
-- ----------------------------
ALTER TABLE "roles" ADD CONSTRAINT "roles_pkey" PRIMARY KEY ("role_id");

-- ----------------------------
-- Primary Key structure for table schema_migrations
-- ----------------------------
ALTER TABLE "schema_migrations" ADD CONSTRAINT "schema_migrations_pkey" PRIMARY KEY ("version");

-- ----------------------------
-- Primary Key structure for table sub_document_types
-- ----------------------------
ALTER TABLE "sub_document_types" ADD CONSTRAINT "sub_document_types_pkey" PRIMARY KEY ("sub_document_type_id");

-- ----------------------------
-- Primary Key structure for table sub_fields
-- ----------------------------
ALTER TABLE "sub_fields" ADD CONSTRAINT "sub_fields_pkey" PRIMARY KEY ("sub_field_id");

-- ----------------------------
-- Indexes structure for table users
-- ----------------------------
CREATE UNIQUE INDEX "index_users_on_email" ON "users" USING btree (
  "email" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" USING btree (
  "reset_password_token" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE "users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table wr_doc_distributions
-- ----------------------------
ALTER TABLE "wr_doc_distributions" ADD CONSTRAINT "wr_doc_distributions_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table wr_doc_requests
-- ----------------------------
ALTER TABLE "wr_doc_requests" ADD CONSTRAINT "wr_doc_requests_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table wr_doc_revisions
-- ----------------------------
ALTER TABLE "wr_doc_revisions" ADD CONSTRAINT "wr_doc_revisions_pkey" PRIMARY KEY ("wr_doc_revision_id");

-- ----------------------------
-- Primary Key structure for table wr_doc_types
-- ----------------------------
ALTER TABLE "wr_doc_types" ADD CONSTRAINT "document_types_pkey" PRIMARY KEY ("wr_doc_type_id");

-- ----------------------------
-- Primary Key structure for table wr_docs
-- ----------------------------
ALTER TABLE "wr_docs" ADD CONSTRAINT "wr_docs_pkey1" PRIMARY KEY ("wr_doc_id");

-- ----------------------------
-- Foreign Keys structure for table cpars
-- ----------------------------
ALTER TABLE "cpars" ADD CONSTRAINT "ncrs" FOREIGN KEY ("ncr_id") REFERENCES "ncrs" ("ncr_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table distributions
-- ----------------------------
ALTER TABLE "distributions" ADD CONSTRAINT "documents" FOREIGN KEY ("document_id") REFERENCES "documents" ("document_id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "distributions" ADD CONSTRAINT "internal_audits" FOREIGN KEY ("internal_audit_id") REFERENCES "internal_audits" ("internal_audit_id") ON DELETE SET NULL ON UPDATE SET NULL;

-- ----------------------------
-- Foreign Keys structure for table document_classifications
-- ----------------------------
ALTER TABLE "document_classifications" ADD CONSTRAINT "fk_sub_document_types" FOREIGN KEY ("sub_document_type_id") REFERENCES "sub_document_types" ("sub_document_type_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table document_requests
-- ----------------------------
ALTER TABLE "document_requests" ADD CONSTRAINT "documents" FOREIGN KEY ("document_id") REFERENCES "documents" ("document_id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "document_requests" ADD CONSTRAINT "internal_audits" FOREIGN KEY ("internal_audit_id") REFERENCES "internal_audits" ("internal_audit_id") ON DELETE SET NULL ON UPDATE SET NULL;

-- ----------------------------
-- Foreign Keys structure for table document_revisions
-- ----------------------------
ALTER TABLE "document_revisions" ADD CONSTRAINT "documents" FOREIGN KEY ("document_id") REFERENCES "documents" ("document_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table documents
-- ----------------------------
ALTER TABLE "documents" ADD CONSTRAINT "document_references" FOREIGN KEY ("document_reference_id") REFERENCES "document_references" ("document_reference_id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "documents" ADD CONSTRAINT "document_types" FOREIGN KEY ("document_type_id") REFERENCES "document_types" ("document_type_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "documents" ADD CONSTRAINT "fk_document_classifications" FOREIGN KEY ("document_classification_id") REFERENCES "document_classifications" ("document_classification_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "documents" ADD CONSTRAINT "sub_document_types" FOREIGN KEY ("sub_document_type_id") REFERENCES "sub_document_types" ("sub_document_type_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table findings
-- ----------------------------
ALTER TABLE "findings" ADD CONSTRAINT "category_of_findings" FOREIGN KEY ("category_of_finding_id") REFERENCES "category_of_findings" ("category_of_finding_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table log_activities
-- ----------------------------
ALTER TABLE "log_activities" ADD CONSTRAINT "fk_members" FOREIGN KEY ("member_id") REFERENCES "members" ("member_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table ncrs
-- ----------------------------
ALTER TABLE "ncrs" ADD CONSTRAINT "findings" FOREIGN KEY ("finding_id") REFERENCES "findings" ("finding_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table permissions
-- ----------------------------
ALTER TABLE "permissions" ADD CONSTRAINT "members" FOREIGN KEY ("member_id") REFERENCES "members" ("member_id") ON DELETE SET NULL ON UPDATE SET NULL;
ALTER TABLE "permissions" ADD CONSTRAINT "roles" FOREIGN KEY ("role_id") REFERENCES "roles" ("role_id") ON DELETE SET NULL ON UPDATE SET NULL;

-- ----------------------------
-- Foreign Keys structure for table report_distributions
-- ----------------------------
ALTER TABLE "report_distributions" ADD CONSTRAINT "reports" FOREIGN KEY ("report_id") REFERENCES "reports" ("report_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table sub_document_types
-- ----------------------------
ALTER TABLE "sub_document_types" ADD CONSTRAINT "document_types" FOREIGN KEY ("document_type_id") REFERENCES "document_types" ("document_type_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table sub_fields
-- ----------------------------
ALTER TABLE "sub_fields" ADD CONSTRAINT "fields" FOREIGN KEY ("field_id") REFERENCES "fields" ("field_id") ON DELETE SET NULL ON UPDATE SET NULL;

-- ----------------------------
-- Foreign Keys structure for table wr_doc_distributions
-- ----------------------------
ALTER TABLE "wr_doc_distributions" ADD CONSTRAINT "wr_docs" FOREIGN KEY ("wr_doc_id") REFERENCES "wr_docs" ("wr_doc_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table wr_doc_requests
-- ----------------------------
ALTER TABLE "wr_doc_requests" ADD CONSTRAINT "wr_docs" FOREIGN KEY ("wr_doc_id") REFERENCES "wr_docs" ("wr_doc_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table wr_doc_revisions
-- ----------------------------
ALTER TABLE "wr_doc_revisions" ADD CONSTRAINT "wr_docs" FOREIGN KEY ("wr_doc_id") REFERENCES "wr_docs" ("wr_doc_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table wr_docs
-- ----------------------------
ALTER TABLE "wr_docs" ADD CONSTRAINT "fields" FOREIGN KEY ("field_id") REFERENCES "fields" ("field_id") ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE "wr_docs" ADD CONSTRAINT "sub_fields" FOREIGN KEY ("sub_field_id") REFERENCES "sub_fields" ("sub_field_id") ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE "wr_docs" ADD CONSTRAINT "wr_doc_types" FOREIGN KEY ("wr_doc_type_id") REFERENCES "wr_doc_types" ("wr_doc_type_id") ON DELETE NO ACTION ON UPDATE CASCADE;
