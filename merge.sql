-- Schema Master
create schema master

create table master.status (
status varchar(15)primary key,
status_modified_date timestamp
)

create table master.industry(
indu_code varchar(15)primary key,
indu_name varchar(85)unique
)
drop table  master.industry 

create table master.working_type(
woty_code varchar(15)primary key,
woty_name varchar(55)unique
)
drop table master.working_type 

create table master.category(
cate_id serial primary key,
cate_name varchar(255)unique,
cate_cate_id int,
cate_modified_date timestamp,
foreign key (cate_cate_id) references master.category(cate_id)
)	

create table master.education(
edu_code varchar(5)primary key,
edu_name varchar(55)unique
)

create table master.address_type(
adty_id serial primary key,
adty_name varchar(15)unique,
adty_modified_date timestamp	
)

create table master.job_role(
joro_id serial primary key,
joro_name varchar(55)unique,
joro_modified_date timestamp
)
drop table master.job_role

create table master.job_type(
joty_id serial primary key,
joty_name varchar(55)
)

create table master.skill_type(
skty_name varchar (55)primary key
)

create table master.skill_template(
skte_id serial primary key,
skte_skill varchar(256),
skte_description varchar (256),
skte_week integer,
skte_orderby integer,
skte_modified_date timestamp,
skty_name varchar(55),
skte_skte_id integer,
foreign key (skty_name) references master.skill_type(skty_name),
foreign key (skte_skte_id) references master.skill_template(skte_id)
)
-- drop table master.skil_template

create table master.modules(
module_name varchar(125)primary key
)

create table master.route_actions(
roac_id serial primary key,
roac_name varchar(15)unique,
roac_orderby integer,
roac_display integer,
roac_module_name varchar(125),
foreign key (roac_module_name) references master.modules(module_name)
)

create table master.country(
country_code varchar(3)primary key,
country_name varchar(85)unique,
country_modified_date timestamp
)

create table master.province(
prov_id serial primary key,
prov_code varchar(5)unique,
prov_name varchar(85),
	prov_modified_date timestamp,
	prov_country_code varchar(3),
	foreign key (prov_country_code) references master.country(country_code)
)

create table master.city(
city_id serial primary key,
	city_name varchar(155)unique,
	city_modified_date timestamp,
	city_prov_id integer,
	foreign key (city_prov_id) references master.province(prov_id)
)

create table master.address(
addr_id serial primary key,
addr_line1 varchar(255)unique ,
addr_line2 varchar(255)unique,
addr_postal_code varchar(10)unique,
	addr_spatial_location varchar,
	addr_modified_date timestamp,
	addr_city_id integer,
	foreign key (addr_city_id) references  master.city(city_id)
)

-- Schema Users

create schema users

create table users.business_entity(
	entity_id serial primary key
)

create table users.roles(
    role_id serial Primary Key,
    role_name varchar(35) unique,
    role_type varchar(15),
    role_modified_date timestamp
)

-- drop table users.users_roles
create table users.users(
    user_entity_id integer PRIMARY KEY,
    user_name varchar(15) UNIQUE,
    user_password VARCHAR(256),
    user_first_name VARCHAR(50),
    user_last_name VARCHAR(50),
    user_birth_date TIMESTAMP,
    user_email_promotion INTEGER,
    user_demographic VARCHAR,
    user_modified_date TIMESTAMP,
    user_photo VARCHAR(255),
    user_current_role INTEGER,
    FOREIGN KEY (user_entity_id) REFERENCES users.business_entity (entity_id)
)

create table users.users_roles(
    usro_entity_id integer,
    usro_role_id integer unique,
    usro_modified_date timestamp,
    FOREIGN KEY (usro_entity_id) REFERENCES users.users(user_entity_id),
    FOREIGN KEY (usro_role_id) REFERENCES users.roles(role_id),
    CONSTRAINT usro_role_id PRIMARY KEY (usro_entity_id, usro_role_id)
)

ALTER TABLE users.users
	add constraint fk_user_current_role foreign key(user_current_role) 
		references users.users_roles(usro_role_id)

CREATE TABLE users.users_experiences(
    usex_id SERIAL unique,
    usex_entity_id INTEGER,
    usex_title VARCHAR(255),
    usex_profile_headline VARCHAR(512),
    usex_employment_type VARCHAR(15) CHECK (usex_employment_type IN ('fulltime', 'freelance')),
    usex_company_name VARCHAR(255),
    usex_is_current CHAR (1) check(usex_is_current in('0', '1')),
    usex_start_date TIMESTAMP,
    usex_end_date TIMESTAMP,
    usex_industry VARCHAR(15),
    usex_description VARCHAR(512),
    usex_experience_type VARCHAR(15) CHECK (usex_experience_type IN ('company', 'certified', 'voluntering', 'organization', 'reward')),
    usex_city_id INTEGER,
    FOREIGN KEY (usex_entity_id) REFERENCES users.users (user_entity_id),
    FOREIGN KEY (usex_city_id) REFERENCES master.city (city_id),
    CONSTRAINT usex_id PRIMARY KEY (usex_id, usex_entity_id)
)

CREATE TABLE users.users_skill (
    uski_id SERIAL unique,
    uski_entity_id INTEGER ,
    uski_modified_date TIMESTAMP,
    uski_skty_name VARCHAR(15) unique,
    FOREIGN KEY (uski_entity_id) REFERENCES users.users (user_entity_id),
    FOREIGN KEY (uski_skty_name) REFERENCES master.skill_type (skty_name),
    CONSTRAINT uski_id PRIMARY KEY (uski_id, uski_entity_id)
)

CREATE TABLE users.users_experiences_skill (
    uesk_usex_id INTEGER,
    uesk_uski_id INTEGER,
    FOREIGN KEY (uesk_usex_id) REFERENCES users.users_experiences (usex_id),
    FOREIGN KEY (uesk_uski_id) REFERENCES users.users_skill (uski_id),
	CONSTRAINT uesk_usex_id PRIMARY KEY (uesk_usex_id, uesk_uski_id)
)

CREATE TABLE users.users_license(
    usli_id SERIAL,
    usli_license_code VARCHAR(512) UNIQUE,
    usli_modified_date TIMESTAMP,
    usli_status VARCHAR(15) CHECK (usli_status IN ('Active', 'NonActive')),
    usli_entity_id INTEGER,
    CONSTRAINT usli_id PRIMARY KEY (usli_id, usli_entity_id),
    FOREIGN KEY (usli_entity_id) REFERENCES users.users (user_entity_id)
)

CREATE TABLE users.users_email (
    pmail_entity_id INTEGER,
    pmail_id SERIAL,
    pmail_address VARCHAR(50),
    pmail_modified_date TIMESTAMP,
    CONSTRAINT pmail_id PRIMARY KEY (pmail_entity_id, pmail_id),
    FOREIGN KEY (pmail_entity_id) REFERENCES users.users (user_entity_id)
)

CREATE TABLE users.users_media(
    usme_id SERIAL,
    usme_entity_id INTEGER,
    usme_file_link VARCHAR(255),
    usme_filename VARCHAR(55),
    usme_filesize INTEGER,
    usme_filetype VARCHAR(15) CHECK (usme_filetype IN ('jpg', 'pdf', 'word')),
    usme_note VARCHAR(55),
    usme_modified_date TIMESTAMP,
    CONSTRAINT media_id PRIMARY KEY (usme_id, usme_entity_id),
    FOREIGN KEY (usme_entity_id) REFERENCES users.users (user_entity_id)
)

CREATE TABLE users.users_eductaion(
    usdu_id SERIAL,
    usdu_entity_id INTEGER,
    usdu_school VARCHAR(255),
    usdu_degree VARCHAR(15) CHECK (usdu_degree IN ('Bachelor', 'Diploma')),
    usdu_field_study VARCHAR(125),
    usdu_graduate_year VARCHAR(4),
    usdu_start_date TIMESTAMP,
    usdu_end_date TIMESTAMP,
    usdu_grade VARCHAR(5),
    usdu_activities VARCHAR(512),
    usdu_description VARCHAR(512),
    usdu_modified_date TIMESTAMP,
    CONSTRAINT education PRIMARY KEY (usdu_id, usdu_entity_id),
    FOREIGN KEY (usdu_entity_id) REFERENCES users.users (user_entity_id)
)

CREATE TABLE users.phone_number_type (
    ponty_code VARCHAR(15) PRIMARY KEY,
    ponty_modified_date TIMESTAMP
)

CREATE TABLE users.users_phones (
    uspo_entity_id INTEGER,
    uspo_number VARCHAR(15),
    uspo_modified_date TIMESTAMP,
    uspo_ponty_code VARCHAR(15),
    CONSTRAINT phones PRIMARY KEY (uspo_entity_id, uspo_number),
    FOREIGN KEY (uspo_entity_id) REFERENCES users.users (user_entity_id),
    FOREIGN KEY (uspo_ponty_code) REFERENCES users.phone_number_type (ponty_code)
)

CREATE TABLE users.users_address (
    etad_addr_id INTEGER PRIMARY KEY,
    etad_nodifies_date TIMESTAMP,
    etad_entity_id INTEGER,
    etad_adty_id INTEGER,
    FOREIGN KEY (etad_addr_id) REFERENCES master.address (addr_id),
    FOREIGN KEY (etad_entity_id) REFERENCES users.users (user_entity_id),
    FOREIGN KEY (etad_adty_id) REFERENCES master.address_type (adty_id)
)

-- create schema JOB HIRE
create schema jobHire

create table jobHire.job_post(
    jopo_entity_id serial primary key,
    jopo_number varchar(25) unique,
    jopo_title varchar(256),
    jopo_start_date timestamp,
    jopo_end_date timestamp,
    jopo_min_salary integer,
    jopo_max_salary integer,
    jopo_min_experience integer,
    jopo_max_experience integer,
    jopo_primary_skill varchar(256),
    jopo_secondary_skill varchar(256),
    jopo_publish_date timestamp,
    jopo_modified_date timestamp,
    jopo_emp_entity_id integer,
    jopo_clit_id integer,
    jopo_joro_id integer,
    jopo_joty_id integer,
    jopo_joca_id integer,
    jopo_addr_id integer,
    jopo_work_code varchar(15),
    jopo_edu_code varchar(5),
    jopo_indu_code varchar(15),
    jopo_status varchar(15),
    FOREIGN KEY (jopo_emp_entity_id) REFERENCES hr.employee(emp_entity_id),
    FOREIGN KEY (jopo_clit_id) REFERENCES jobHire.client(clit_id),
    FOREIGN KEY (jopo_joro_id) REFERENCES master.job_role(joro_id),
    FOREIGN KEY (jopo_joty_id) REFERENCES master.job_type(joty_id),
    FOREIGN KEY (jopo_joca_id) REFERENCES jobHire.job_category(joca_id),
    FOREIGN KEY (jopo_addr_id) REFERENCES master.address(addr_id),
    FOREIGN KEY (jopo_work_code) REFERENCES master.working_type(woty_code),
    FOREIGN KEY (jopo_edu_code) REFERENCES master.education(edu_code),
    FOREIGN KEY (jopo_indu_code) REFERENCES master.industry(indu_code),
    FOREIGN KEY (jopo_status) REFERENCES master.status(status)
)

create table jobHire.job_category(
    joca_id serial primary key,
    joca_name varchar(255),
    joca_modified_date timestamp
)

create table jobHire.client(
    clit_id integer primary key,
    clit_name varchar (256) unique,
    clit_about varchar(512),
    clit_modified_date timestamp,
    clit_addr_id integer,
    clit_emra_id integer,
    FOREIGN KEY(clit_addr_id) REFERENCES master.address(addr_id),
    FOREIGN KEY(clit_emra_id) REFERENCES jobHire.employee_range(emra_id)
)

create table jobHire.employee_range(
    emra_id serial primary key,
    emra_range_min integer unique,
    emra_range_max integer unique,
    emra_modified_date timestamp
)
create table jobHire.job_post_desc(
    jopo_entity_id integer primary key,
    jopo_description json,
    jopo_responsibility json,
    jopo_target json,
    jopo_benefit json,
    FOREIGN KEY(jopo_entity_id) REFERENCES jobHire.job_post(jopo_entity_id)
)
create table jobHire.job_photo(
    jopho_id serial primary key,
    jopho_filename varchar(55),
    jopho_filesize integer,
    jopho_filetype varchar(15) check(jopho_filetype in('png', 'jpeg')),
    jopho_modified_date timestamp,
    jopho_entity_id integer,
    FOREIGN KEY(jopho_entity_id) REFERENCES jobHire.job_post(jopo_entity_id)
)
create table jobHire.talent_apply(
    taap_user_entity_id integer unique,
    taap_entity_id integer unique,
    taap_intro varchar,
    taap_scoring integer,
    taap_modified_date timestamp,
    taap_status varchar(15),
    FOREIGN KEY(taap_user_entity_id) REFERENCES users.users(user_entity_id),
    FOREIGN KEY(taap_entity_id) REFERENCES jobHire.job_post(jopo_entity_id),
    FOREIGN KEY(taap_status) REFERENCES master.status(status),
	CONSTRAINT talentapply PRIMARY KEY (taap_user_entity_id, taap_entity_id)
)

drop table jobHire.talent_apply

create table jobHire.talent_apply_progress(
    tapr_id serial,
    taap_user_entity_id integer,
    taap_entity_id integer,
    tapr_modified_date timestamp,
    tapr_status varchar(15),
    tapr_comment varchar(256),
    tapr_progress_name varchar(55),
    FOREIGN KEY(taap_user_entity_id) REFERENCES jobHire.talent_apply(taap_user_entity_id),
    FOREIGN KEY(taap_entity_id) REFERENCES jobHire.talent_apply(taap_entity_id),
	CONSTRAINT talentprogress PRIMARY KEY (tapr_id, taap_user_entity_id, taap_entity_id)
)

-- CREATE SCHEMA HR
CREATE SCHEMA hr

-- TABLE EMPLOYEE
CREATE TABLE hr.employee(
	emp_entity_id integer PRIMARY KEY,
	emp_emp_number varchar(25) UNIQUE,
	emp_national_id varchar(25) UNIQUE,
	emp_birth_date date,
	emp_marital_status char(1) CHECK (emp_marital_status in ('M', 'S')) ,
	emp_gender char(1) CHECK (emp_gender in ('M', 'F')),
	emp_hire_date timestamp,
	emp_salaried_flag char(1) CHECK (emp_salaried_flag in ('0', '1')),
	emp_vacation_hours smallint,
	emp_sickleave_hours smallint,
	emp_current_flag smallint CHECK (emp_current_flag in (0, 1)),
	emp_modified_date timestamp,
	emp_type varchar(15) CHECK (emp_type in ('Internal', 'Outsource')),
	emp_joro_id integer,
	emp_emp_entity_id integer,
	FOREIGN KEY (emp_entity_id) REFERENCES users.users(user_entity_id),
	FOREIGN KEY (emp_joro_id) REFERENCES master.job_role (joro_id),
	FOREIGN KEY (emp_emp_entity_id) REFERENCES hr.employee (emp_entity_id) 
)

-- TABLE EMPLOYEE CLIENT CONTRACT  
CREATE TABLE hr.employee_client_contract(
	ecco_id serial,
	ecco_entity_id integer,
	ecco_contract_no varchar(55),
	ecco_contract_date timestamp,
	ecco_start_date timestamp,
	ecco_end_date timestamp,
	ecco_notes varchar(512),
	ecco_modified_date timestamp,
	ecco_media_link varchar(255),
	ecco_joty_id integer,
	ecco_account_manager integer,
	ecco_clit_id integer,
	ecco_status varchar(15),
    CONSTRAINT employee_cl_pk PRIMARY KEY (ecco_id, ecco_entity_id),
	FOREIGN KEY (ecco_entity_id) REFERENCES hr.employee(emp_entity_id),
	FOREIGN KEY (ecco_joty_id) REFERENCES master.job_type(joty_id),
	FOREIGN KEY (ecco_account_manager) REFERENCES hr.employee(emp_entity_id),
	FOREIGN KEY (ecco_clit_id) REFERENCES jobHire.client(clit_id),
	FOREIGN KEY (ecco_status) REFERENCES master.status(status)
)

drop table hr.employee_client_contract
-- alter table hr.employee_client_contract
-- add constraint accountmanager FOREIGN KEY (ecco_account_manager) REFERENCES hr.employee(emp_entity_id)
-- with [master.job_role(joro_name) = 'Account Manager'];

-- CREATE SEQUENCE ecco_id TABLE EMPLOYEE CLIENT CONTRACT
CREATE SEQUENCE seq_employee_client_contract
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1

create or replace function eccoIdSeq() 
	returns varchar as $$
	select lpad(''||nextval('seq_employee_client_contract'),4,'0')
end;$$ 
language sql

alter table hr.employee_client_contract alter column ecco_id set default eccoIdSeq()


-- TABLE DEPARTMENT
CREATE TABLE hr.department(
    dept_id serial PRIMARY KEY,
    dept_name varchar(50) UNIQUE,
    dept_modified_date timestamp
)

CREATE SEQUENCE seq_department
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1

create or replace function deptIdSeq() 
	returns varchar as $$
	select lpad(''||nextval('seq_department'),4,'0')
end;$$ 
language sql

alter table hr.department alter column dept_id set default deptIdSeq()


-- TABLE EMPLOYEE DEPARTMENT HISTORY
CREATE TABLE hr.employee_department_history(
    edhi_id serial,
    edhi_entity_id integer,
    edhi_start_date timestamp,
    edhi_end_date timestamp,
    edhi_modified_date timestamp,
    edhi_dept_id integer,
    CONSTRAINT employee_depart_history_pk PRIMARY KEY (edhi_id, edhi_entity_id),
    FOREIGN KEY (edhi_entity_id) REFERENCES hr.employee(emp_entity_id),
    FOREIGN KEY (edhi_dept_id) REFERENCES hr.department(dept_id)
)

CREATE SEQUENCE seq_employee_department_history
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1

create or replace function edhiIdSeq() 
	returns varchar as $$
	select lpad(''||nextval('seq_employee_department_history'),4,'0')
end;$$ 
language sql

alter table hr.employee_department_history alter column edhi_id set default edhiIdSeq()


-- TABLE EMPLOYEE PAY HISTORY
CREATE TABLE hr.employee_pay_history(
    ephi_entity_id integer,
    ephi_rate_change_date timestamp,
    ephi_rate_salary integer,
    ephi_pay_frequence smallint CHECK (ephi_pay_frequence in (1,2)),
    ephi_modified_date timestamp,
	-- add constraint
	constraint entity_pay_history primary key(ephi_entity_id, ephi_rate_change_date),
	foreign key (ephi_entity_id) references hr.employee(emp_entity_id)
) 

-- create schema curriculum
create schema curriculum

create table curriculum.program_entity(
	prog_entity_id serial primary key,
	prog_title varchar(256),
	prog_headline varchar(512),
	prog_type varchar(15) CHECK (prog_type IN ('bootcamp','course')),
	prog_learning_type varchar(15) CHECK (prog_learning_type IN ('online', 'offline','both')),
	prog_rating integer,
	prog_total_trainee integer,
	prog_modified_date timestamp,
	prog_image varchar(256),
	prog_best_seller char(1) CHECK (prog_best_seller in ('0', '1')),
	prog_price integer,
	prog_language VARCHAR(35) CHECK (prog_language IN ('english', 'bahasa')),
	prog_duration integer,
	prog_duration_type varchar(15) CHECK (prog_duration_type in ('month', 'week','days')),
	prog_tag_skill varchar(512),
	prog_city_id integer,
	prog_cate_id integer,
	prog_created_by integer,
	prog_status varchar(15),
	foreign key (prog_city_id) references master.city (city_id),
	foreign key (prog_cate_id) references master.category (cate_id),
	foreign key (prog_created_by) references hr.employee(emp_entity_id),
	foreign key (prog_status) references master.status (status)								
)

create table curriculum.program_entity_description(
	pred_prog_entity_id integer primary key,
	pred_item_learning JSON,
	pred_item_include JSON,
	pred_requirement JSON,
	pred_description JSON,
	pred_target_level JSON,
	FOREIGN KEY (pred_prog_entity_id) REFERENCES curriculum.program_entity (prog_entity_id)
)

create table curriculum.program_reviews(
	prow_user_entity_id integer,
	prow_prog_entity_id integer,
	prow_review varchar(512),
	prow_rating integer,
	prow_modified_date timestamp,
	constraint prow_user_entity_id primary key (prow_user_entity_id, prow_prog_entity_id),
	foreign key (prow_user_entity_id) references users.users (user_entity_id),
	foreign key (prow_prog_entity_id) references curriculum.program_entity (prog_entity_id)	
)
	
create table curriculum.sections(
	sect_id serial unique,
	sect_prog_entity_id integer,
	sect_title varchar(100),
	sect_description varchar(256),
	sect_total_section integer,
	sect_total_lecture integer,
	sect_total_minute integer,
	sect_modified_date timestamp,
	constraint sect_id primary key (sect_id, sect_prog_entity_id),
	foreign key (sect_prog_entity_id) references curriculum.program_entity (prog_entity_id)	
)
drop table curriculum.sections
	
create table curriculum.section_detail(
	secd_id serial primary key,
	secd_title varchar(256),
	secd_preview char(1) check (secd_preview in('0','1')),
	secd_score integer,
	secd_note varchar(256),
	secd_minute integer,
	secd_modified_date timestamp,
	secd_sect_id integer,
	foreign key (secd_sect_id) references curriculum.sections (sect_id)	
)
	
create table curriculum.section_detail_material(
	sedm_id serial primary key,
	sedm_filename varchar(55),
	sedm_filesize integer,
	sedm_filetype varchar(15) CHECK (sedm_filetype IN ('video', 'image', 'text', 'link')),
	sedm_filelink varchar(255),
	sedm_modified_date timestamp,
	sedm_secd_id integer,
	foreign key (sedm_secd_id) references curriculum.section_detail (secd_id)
)

-- MODULE BOOTCAMP
-- create schema
create schema bootcamp

-- TABLE PROGRAM APPLY
CREATE TABLE bootcamp.program_apply (
    prap_user_entity_id INTEGER,
    prap_prog_entity_id INTEGER,
    prap_test_score INTEGER,
    prap_gpa INTEGER,
    prap_iq_test INTEGER,
    prap_review VARCHAR(256),
    prap_modified_date TIMESTAMP,
    prap_status VARCHAR(15),
    FOREIGN KEY (prap_user_entity_id) REFERENCES users.users(user_entity_id),
    FOREIGN KEY (prap_prog_entity_id) REFERENCES curriculum.program_entity(prog_entity_id),
    FOREIGN KEY (prap_status) REFERENCES master.status (status),
    CONSTRAINT program_apply_pk PRIMARY KEY (prap_user_entity_id, prap_prog_entity_id)
)

-- TABLE PROGRAM APPLY PROGRESS
CREATE TABLE bootcamp.program_apply_progress (
    parog_id SERIAL,
    parog_user_entity_id INTEGER,
    parog_prog_entity_id INTEGER,
    parog_action_date TIMESTAMP,
    parog_modified_date TIMESTAMP,
    parog_comment VARCHAR(512),
    parog_progress_name VARCHAR(15),
    parog_emp_entity_id INTEGER,
    parog_status VARCHAR(15),
    FOREIGN KEY (parog_user_entity_id) REFERENCES users.users (user_entity_id),
    FOREIGN KEY (parog_prog_entity_id) REFERENCES curriculum.program_entity(prog_entity_id),
    FOREIGN KEY (parog_emp_entity_id) REFERENCES hr.employee(emp_entity_id),
    FOREIGN KEY (parog_status) REFERENCES master.status(status),
    CONSTRAINT program_apply_progress_pk PRIMARY KEY (parog_id, parog_user_entity_id, parog_prog_entity_id)
)

-- TABLE BATCH
CREATE TABLE bootcamp.batch (
    batch_id SERIAL unique,
    batch_entity_id INTEGER,
    batch_name VARCHAR(15) UNIQUE,
    batch_description VARCHAR(125),
    batch_start_date TIMESTAMP,
    batch_end_date TIMESTAMP,
    batch_reason VARCHAR(256),
    batch_type VARCHAR(15) CHECK (batch_type IN ('offline', 'online', 'corporate')),
    batch_modified_date TIMESTAMP,
    batch_status VARCHAR(15),
    batch_pic_id INTEGER,
    FOREIGN KEY (batch_entity_id) REFERENCES curriculum.program_entity(prog_entity_id),
    FOREIGN KEY (batch_status) REFERENCES master.status(status),
    FOREIGN KEY (batch_pic_id) REFERENCES hr.employee(emp_entity_id),
    CONSTRAINT batch_pk PRIMARY KEY (batch_id, batch_entity_id)
)
drop table bootcamp.batch

-- TABLE BATCH TRAINEE
CREATE TABLE bootcamp.batch_trainee (
    batr_id SERIAL,
    batr_status VARCHAR(15) CHECK (batr_status IN ('passed', 'failed', 'resign', 'running')),
    batr_certificated CHAR(1) CHECK (batr_certificated IN ('0', '1')),
    batre_certificate_link VARCHAR(255),
    batr_access_token VARCHAR(255),
    batr_access_grant CHAR(1) CHECK (batr_access_grant IN ('0', '1')),
    batr_review VARCHAR(1024),
    batr_total_score INTEGER,
    batr_modified_date TIMESTAMP,
    batr_trainee_entity_id INTEGER,
    batr_batch_id INTEGER,
    FOREIGN KEY (batr_trainee_entity_id) REFERENCES users.users(user_entity_id),
    FOREIGN KEY (batr_batch_id) REFERENCES bootcamp.batch(batch_id),
    CONSTRAINT batch_trainee_pk PRIMARY KEY (batr_id, batr_batch_id)
)

-- TABLE BATCH TRAINEE EVALUATION
CREATE TABLE bootcamp.batch_trainee_evaluation (
    btev_id SERIAL PRIMARY KEY,
    btev_type VARCHAR(15)CHECK (btev_type IN ('hardskill', 'softskill')),
    btev_header VARCHAR(256),
    btev_section VARCHAR(256),
    btev_skill VARCHAR(256),
    btev_week INTEGER,
    btev_skor INTEGER,
    btev_note VARCHAR(256),
    btev_modified_date TIMESTAMP,
    btev_batch_id INTEGER,
    btev_trainee_entity_id INTEGER,
    FOREIGN KEY (btev_batch_id) REFERENCES bootcamp.batch(batch_id),
    FOREIGN KEY (btev_trainee_entity_id) REFERENCES users.users(user_entity_id)
)

-- TABLE INSTRUCTOR PROGRAMS
CREATE TABLE bootcamp.instructor_programs (
    batch_id INTEGER,
    inpro_entity_id INTEGER,
    inpro_emp_entity_id INTEGER,
    inpro_modified_date TIMESTAMP,
    FOREIGN KEY (batch_id) REFERENCES bootcamp.batch(batch_id),
    FOREIGN KEY (inpro_entity_id) REFERENCES curriculum.program_entity(prog_entity_id),
    FOREIGN KEY (inpro_emp_entity_id) REFERENCES hr.employee(emp_entity_id),
    CONSTRAINT instructor_programs_pk PRIMARY KEY (batch_id, inpro_entity_id, inpro_emp_entity_id)
)

-- create schema sales
create schema sales

create table sales.special_offer (
	spof_id serial primary key ,
	spof_description varchar(256) ,
	spof_discount INTEGER ,
	spof_type varchar(15) ,
	spof_start_date timestamp ,
	spof_end_date timestamp ,
	spof_min_qty INTEGER ,
	spof_max_qty INTEGER ,
	spof_modified_date TIMESTAMP,
	spof_cate_id INTEGER,
	FOREIGN KEY (spof_cate_id) REFERENCES master.category (cate_id)
)

create table sales.special_offer_programs (
	soco_id serial ,
	soco_spof_id serial ,
	soco_prog_entity_id INTEGER ,
	soco_status varchar (15) CHECK (soco_status in ('open', 'cancelled','closed')) ,
	soco_modified_date timestamp ,
	foreign key (soco_spof_id) references sales.special_offer(spof_id) ,
	foreign key (soco_prog_entity_id) references curriculum.program_entity(prog_entity_id),
	constraint special_offer_programs_pk primary key (soco_id, soco_spof_id, soco_prog_entity_id)
)

create table sales.cart_items (
	cait_id serial primary key ,
	cait_quantity INTEGER ,
	cait_unit_price money ,
	cait_modified_date timestamp ,
	cait_user_entity_id INTEGER ,
	cait_prog_entity_id INTEGER ,
	foreign key (cait_user_entity_id) references users.users(user_entity_id) ,
	foreign key (cait_prog_entity_id) references curriculum.program_entity(prog_entity_id)
)

create table sales.sales_order_header (
	sohe_id serial primary key ,
	sohe_order_date timestamp ,
	sohe_due_date timestamp ,
	sohe_ship_date timestamp ,
	sohe_order_number varchar(25) UNIQUE ,
	sohe_account_number varchar(25) ,
	sohe_trpa_code_number varchar(55) ,
	sohe_subtotal money ,
	sohe_tax money ,
	sohe_total_due INTEGER ,
	sohe_license_code varchar (512) unique ,
	sohe_modified_date timestamp ,
	sohe_user_entity_id INTEGER ,
	sohe_status varchar(15) ,
	foreign key (sohe_user_entity_id) references users.users(user_entity_id),
	foreign key (sohe_status) references master.status(status)
)

create table sales.sales_order_detail (
	sode_id INTEGER PRIMARY KEY ,
	sode_qty INTEGER ,
	sode_unit_price money ,
	sode_unit_discount money ,
	sode_line_total INTEGER ,
	sode_modified_date timestamp ,
	sode_sohe_id INTEGER ,
	sode_prog_entity_id INTEGER ,
	foreign key (sode_sohe_id) references sales.sales_order_header (sohe_id),
	FOREIGN KEY (sode_prog_entity_id) REFERENCES curriculum.program_entity (prog_entity_id)
)

-- Module Payment

CREATE SCHEMA payment

CREATE TABLE payment.bank (
    bank_entity_id INT PRIMARY KEY,
    bank_code VARCHAR(10) UNIQUE,
    bank_name VARCHAR(55) UNIQUE,
    bank_modified_date TIMESTAMP,
    FOREIGN KEY (bank_entity_id) REFERENCES users.business_entity (entity_id)
);
SELECT * FROM payment.bank;

CREATE TABLE payment.fintech (
    fint_entity_id INT PRIMARY KEY,
    fint_code VARCHAR(10) UNIQUE,
    fint_name VARCHAR(55) UNIQUE,
    fint_modified_date TIMESTAMP,
    FOREIGN KEY (fint_entity_id) REFERENCES users.business_entity (entity_id)
);
SELECT * FROM payment.fintech;

CREATE TABLE payment.users_account (
	usac_bank_entity_id INT,
	usac_user_entity_id INT,
	usac_account_number VARCHAR(25) UNIQUE,
	usac_saldo NUMERIC,
	usac_type VARCHAR(15) CHECK (usac_type IN ('debit', 'credit-card', 'payment')),
	usac_start_date TIMESTAMP,
	usac_end_date TIMESTAMP,
	usac_modified_date TIMESTAMP,
	usac_status VARCHAR(15) CHECK (usac_status IN ('active', 'inactive', 'blocked')),
	PRIMARY KEY (usac_bank_entity_id, usac_user_entity_id),
	FOREIGN KEY (usac_bank_entity_id) REFERENCES payment.bank (bank_entity_id) ON DELETE CASCADE,
	FOREIGN KEY (usac_bank_entity_id) REFERENCES payment.fintech (fint_entity_id) ON DELETE CASCADE,
	FOREIGN KEY (usac_user_entity_id) REFERENCES users.users (user_entity_id)
);
SELECT * FROM payment.users_account;

CREATE OR REPLACE FUNCTION set_usac_account_number()
	RETURNS TRIGGER AS $$
BEGIN
	IF (TG_OP = 'INSERT') THEN
		SELECT CASE
			WHEN NEW.usac_bank_entity_id IS NOT NULL THEN bank.bank_code || '-' || bank.bank_name
			WHEN NEW.usac_bank_entity_id IS NULL THEN fintech.fint_code || '-' || fintech.fint_name
			ELSE NULL
		END INTO NEW.usac_account_number
		FROM payment.bank
		LEFT JOIN payment.fintech ON FALSE
		WHERE bank.entity_id = NEW.usac_bank_entity_id;
	END IF;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_set_usac_account_number
	BEFORE INSERT ON payment.users_account
	FOR EACH ROW
	EXECUTE FUNCTION set_usac_account_number();
			
CREATE TABLE payment.transaction_payment (
	trpa_id SERIAL PRIMARY KEY,
	trpa_code_number VARCHAR(55) UNIQUE,
	trpa_order_number VARCHAR(25),
	trpa_debit NUMERIC,
	trpa_credit NUMERIC,
	trpa_type VARCHAR(15) CHECK (trpa_type IN ('top-up', 'transfer', 'order', 'refund')),
	trpa_note VARCHAR(255),
	trpa_modified_date TIMESTAMP,
	trpa_source_id VARCHAR(25) NOT NULL,
	trpa_target_id VARCHAR(25) NOT NULL,
	trpa_user_entity_id INT,
	FOREIGN KEY (trpa_user_entity_id) REFERENCES users.users (user_entity_id)
);
SELECT * FROM payment.transaction_payment;

CREATE SEQUENCE trpa_code_number_seq;

CREATE OR REPLACE FUNCTION set_trpa_code_number()
	RETURNS TRIGGER AS $$
BEGIN
	IF (TG_OP = 'INSERT') THEN
		NEW.trpa_code_number := 'TR-' || to_char(current_date, 'YYYYMMDD') || LPAD(NEXTVAL('trpa_code_number_seq')::TEXT, 5, 'O');
		
		SELECT usac_account_number INTO NEW.trpa_source_id
		FROM users_account
		WHERE usac_user_entity_id = NEW.trpa_user_entity_id;
		
		SELECT usac_account_number INTO NEW.trpa_target_id
		FROM users_account
		WHERE usac_user_entity_id = NEW.trpa_user_entity_id;
		
		SELECT user_entity_id INTO NEW.trpa_user_entity_id
		FROM users
		WHERE user_entity_id = NEW.trpa_user_entity_id;
	END IF;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_set_trpa_code_and_ids
	BEFORE INSERT ON payment.transaction_payment
	FOR EACH ROW
	EXECUTE FUNCTION set_trpa_code_number();