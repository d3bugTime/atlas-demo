-- Add new schema named "public"
CREATE SCHEMA IF NOT EXISTS "public";
-- Set comment to schema: "public"
COMMENT ON SCHEMA "public" IS 'standard public schema';
-- Create "users" table
CREATE TABLE "public"."users" (
  "user_id" serial NOT NULL,
  "email" character varying(255) NOT NULL,
  "password" character varying(255) NOT NULL,
  "name" character varying(100) NOT NULL,
  "last_name" character varying(100) NOT NULL,
  "phone" character varying(20) NULL, -- New added column
  PRIMARY KEY ("user_id"),
  CONSTRAINT "users_email_key" UNIQUE ("email")
);
-- Create "teacher" table
CREATE TABLE "public"."teacher" (
  "teacher_id" serial NOT NULL,
  "user_id" integer NOT NULL,
  "registration_number" character varying(100) NOT NULL,
  "title" character varying(150) NOT NULL,
  "institution" character varying(255) NOT NULL,
  "verified" boolean NOT NULL DEFAULT false,
  PRIMARY KEY ("teacher_id"),
  CONSTRAINT "teacher_registration_number_key" UNIQUE ("registration_number"),
  CONSTRAINT "teacher_user_id_key" UNIQUE ("user_id"),
  CONSTRAINT "fk_teacher_user" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("user_id") ON UPDATE NO ACTION ON DELETE CASCADE
);
-- Create "role" table
CREATE TABLE "public"."role" (
  "role_id" serial NOT NULL,
  "name" character varying(50) NOT NULL,
  PRIMARY KEY ("role_id"),
  CONSTRAINT "role_name_key" UNIQUE ("name")
);
-- Create "user_role" table
CREATE TABLE "public"."user_role" (
  "user_role_id" serial NOT NULL,
  "user_id" integer NOT NULL,
  "role_id" integer NOT NULL,
  PRIMARY KEY ("user_role_id"),
  CONSTRAINT "uk_user_role_unique" UNIQUE ("user_id", "role_id"),
  CONSTRAINT "fk_user_role_role" FOREIGN KEY ("role_id") REFERENCES "public"."role" ("role_id") ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT "fk_user_role_user" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("user_id") ON UPDATE NO ACTION ON DELETE CASCADE
);
-- Create index "idx_user_role_role_id" to table: "user_role"
CREATE INDEX "idx_user_role_role_id" ON "public"."user_role" ("role_id");
-- Create index "idx_user_role_user_id" to table: "user_role"
CREATE INDEX "idx_user_role_user_id" ON "public"."user_role" ("user_id");
