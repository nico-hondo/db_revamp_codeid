-- 1 master --
CREATE SCHEMA master

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
roac_name varchar(50)unique,
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

-- 2 users --
CREATE SCHEMA users

create table users.business_entity(
	entity_id serial primary key
)
create table users.roles(
    role_id serial Primary Key,
    role_name varchar(35) ,
    role_type varchar(15),
    role_modified_date timestamp
)



create table users.users_roles(
    usro_entity_id integer,
    usro_role_id integer ,
    usro_modified_date timestamp,
    FOREIGN KEY (usro_entity_id) REFERENCES users.users(user_entity_id),
    FOREIGN KEY (usro_role_id) REFERENCES users.roles(role_id),
    CONSTRAINT usro_role_id PRIMARY KEY (usro_entity_id, usro_role_id)
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
    FOREIGN KEY (user_entity_id) REFERENCES users.business_entity (entity_id),
	FOREIGN KEY (user_current_role) REFERENCES users.roles(role_id)
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

CREATE TABLE users.users_education(
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

-- 3 jobHire --
-- create schema
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

-- 4 hr --
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



-- TABLE DEPARTMENT
CREATE TABLE hr.department(
    dept_id serial PRIMARY KEY,
    dept_name varchar(50) UNIQUE,
    dept_modified_date timestamp
)



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



-- TABLE EMPLOYEE PAY HISTORY
CREATE TABLE hr.employee_pay_history(
    ephi_entity_id integer,
    ephi_rate_change_date timestamp,
    ephi_rate_salary integer,
    ephi_pay_frequence smallint CHECK (ephi_pay_frequence in (1,2)),
    ephi_modified_date timestamp,
	constraint entity_pay_history primary key(ephi_entity_id, ephi_rate_change_date),
	foreign key (ephi_entity_id) references hr.employee(emp_entity_id)
)

-- 5 curriculum --
create schema curriculum;

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

-- 6 bootcamp --
-- create schema
Create Schema bootcamp

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

-- 7 sales -
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
 --8 payment --
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

-- insert master --
INSERT INTO master.job_role (joro_name) VALUES
('Pemograman')

INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('1', 'Development', null);
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('2', 'Full Stack', '1');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('3', 'Java Technology', '1');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('4', '.Net Technology', '1');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('5', 'Golang', '1');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('6', 'Mobile Development', null);
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('7', 'Android', '6');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('8', 'Flutter', '6');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('9', 'React Native', '6');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('10', 'Swift', '6');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('11', 'Data Scientist', null);
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('12', 'Hadoop', '11');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('13', 'Python', '11');

select * from master.category

INSERT INTO master.skill_type (skty_name) VALUES ('java');
INSERT INTO master.skill_type (skty_name) VALUES ('dotnet');
INSERT INTO master.skill_type (skty_name) VALUES ('sql');
INSERT INTO master.skill_type (skty_name) VALUES ('softskill');
INSERT INTO master.skill_type (skty_name) VALUES ('hardskill');
INSERT INTO master.skill_type (skty_name) VALUES ('mini project');
INSERT INTO master.skill_type (skty_name) VALUES ('javascript');
INSERT INTO master.skill_type (skty_name) VALUES ('express.js');
INSERT INTO master.skill_type (skty_name) VALUES ('nodejs');
INSERT INTO master.skill_type (skty_name) VALUES ('springboot');
INSERT INTO master.skill_type (skty_name) VALUES ('Final');
INSERT INTO master.skill_type (skty_name) VALUES ('Presentation');
INSERT INTO master.skill_type (skty_name) VALUES ('Technical');


select * from master.skill_type

INSERT INTO master.modules (module_name) VALUES ('Bootcamp'), ('Job');
INSERT INTO master.modules (module_name) VALUES ('Sales');
INSERT INTO master.modules (module_name) VALUES ('Master'), ('User'),('HR'), ('Course'), ('Payment');


select * from master.modules


INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('1', 'Apply Application', '1', 'Bootcamp', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('2', 'Filtering Test', '2', 'Bootcamp', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('3', 'Contract Legal', '3', 'Bootcamp', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('4', 'Briefing Bootcamp', '4', 'Bootcamp', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('5', 'Join Bootcamp', '5', 'Bootcamp', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('6', 'Get Certified', '6', 'Bootcamp', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('7', 'Placement', '7', 'Bootcamp', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('8', 'Idle', '8', 'Bootcamp', '0');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('9', 'Drop Out', '9', 'Bootcamp', '0');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('10', 'Apply Application', '1', 'Job', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('11', 'Interview', '2', 'Job', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('12', 'Contract Legal', '3', 'Job', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('14', 'Placement', '4', 'Job', '1');



select * from master.route_actions


INSERT INTO master.status (status, status_module) VALUES ('certified', 'User');
INSERT INTO master.status (status, status_module) VALUES ('voluntering', 'User');
INSERT INTO master.status (status, status_module) VALUES ('organization', 'User');
INSERT INTO master.status (status, status_module) VALUES ('reward', 'User');
INSERT INTO master.status (status, status_module) VALUES ('fulltime', 'User');
INSERT INTO master.status (status, status_module) VALUES ('freelance', 'User');
INSERT INTO master.status (status, status_module) VALUES ('bachelor', 'User');
INSERT INTO master.status (status, status_module) VALUES ('diploma', 'User');
INSERT INTO master.status (status, status_module) VALUES ('Male', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Female', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Single', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Married', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Hourly', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Salaried', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Active', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('InActive', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Contract', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Prohibation', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Monthly', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Weekly', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Bootcamp', 'Course');
INSERT INTO master.status (status, status_module) VALUES ('Course', 'Course');
INSERT INTO master.status (status, status_module) VALUES ('Online', 'Course');
INSERT INTO master.status (status, status_module) VALUES ('Offline', 'Course');
INSERT INTO master.status (status, status_module) VALUES ('English', 'Course');
INSERT INTO master.status (status, status_module) VALUES ('Bahasa', 'Course');
INSERT INTO master.status (status, status_module) VALUES ('Open', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Running', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Close', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Pending', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Extend', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Passed', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Failed', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Resign', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Publish', 'Job');
INSERT INTO master.status (status, status_module) VALUES ('Draft', 'Job');
INSERT INTO master.status (status, status_module) VALUES ('Cancel', 'Job');
INSERT INTO master.status (status, status_module) VALUES ('Remove', 'Job');
INSERT INTO master.status (status, status_module) VALUES ('Waiting', 'Job');
INSERT INTO master.status (status, status_module) VALUES ('Done', 'Job');
INSERT INTO master.status (status, status_module) VALUES ('New', 'Sales');
INSERT INTO master.status (status, status_module) VALUES ('Shipping', 'Sales');
INSERT INTO master.status (status, status_module) VALUES ('Cancelled', 'Sales');
INSERT INTO master.status (status, status_module) VALUES ('Refunds', 'Sales');
INSERT INTO master.status (status, status_module) VALUES ('Closed', 'Sales');
INSERT INTO master.status (status, status_module) VALUES ('TopUp', 'Payment');
INSERT INTO master.status (status, status_module) VALUES ('Transfer', 'Payment');
INSERT INTO master.status (status, status_module) VALUES ('PayOrder', 'Payment');
INSERT INTO master.status (status, status_module) VALUES ('Refund', 'Payment');
INSERT INTO master.status (status, status_module) VALUES ('Debit', 'Payment');
INSERT INTO master.status (status, status_module) VALUES ('Credit', 'Payment');
INSERT INTO master.status (status, status_module) VALUES ('Payment', 'Payment');
INSERT INTO master.status (status, status_module) VALUES ('Internal', 'User');
INSERT INTO master.status (status, status_module) VALUES ('External', 'User');
INSERT INTO master.status (status, status_module) VALUES ('Outsource', 'User');

/*yang diubah
('Cancelled', 'job') --> ('Cancel', 'job')
('Refund', 'Sales') --> ('Refunds', 'Sales')
('Closed', 'Bootcamp') --> ('Close', 'Bootcamp')
*/

select * from master.status

INSERT INTO master.address_type (adty_id, adty_name) VALUES ('1', 'Home');
INSERT INTO master.address_type (adty_id, adty_name) VALUES ('2', 'Main Office');
INSERT INTO master.address_type (adty_id, adty_name) VALUES ('3', 'Primary');
INSERT INTO master.address_type (adty_id, adty_name) VALUES ('4', 'Shipping');
INSERT INTO master.address_type (adty_id, adty_name) VALUES ('5', 'Billing');
INSERT INTO master.address_type (adty_id, adty_name) VALUES ('6', 'Archive');

select * from master.address_type

INSERT INTO master.country (country_code, country_name) VALUES ('IND', 'Indonesia');

select * from master.country

INSERT INTO master.province (prov_id, prov_name, prov_country_code) VALUES ('1', 'DKI Jakarta', 'IND');
INSERT INTO master.province (prov_id, prov_name, prov_country_code) VALUES ('2', 'Jawa Barat', 'IND');

select * from master.province

INSERT INTO master.city (city_id, city_name, city_prov_id) VALUES ('1', 'Bandung', '2');
INSERT INTO master.city (city_id, city_name, city_prov_id) VALUES ('2', 'Bogor', '2');
INSERT INTO master.city (city_id, city_name, city_prov_id) VALUES ('3', 'Jakarta', '1');

select * from master.city

INSERT INTO master.address (addr_id, addr_line1, addr_line2, addr_postal_code, addr_spatial_location, addr_city_id) VALUES ('1', 'jl. Sambiloto no 20, sumur batu, babakan madang', '-', '56789', '{}', '2');
INSERT INTO master.address (addr_id, addr_line1, addr_line2, addr_postal_code, addr_spatial_location, addr_city_id) VALUES ('2', 'jl. North ridge no 18, sukajaya, babakan madang', '', '67859', '{}', '2');

select * from master.adrress

INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('1', 'Fundamental', 'Minggu pertama kamu akan belajar fundamental c#, mulai dari tipe data, variable, array, condition, iteration dan collection', '1', '1', 'javascript', null);
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('2', 'Data Type', '', '1', '2', 'javascript', '1');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('3', 'Scoping Variable', '', '1', '3', 'javascript', '1');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('4', 'Arrays', '', '1', '4', 'javascript', '1');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('5', 'Control Statement', '', '1', '5', 'javascript', '1');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('6', 'Iteration', '', '1', '6', 'javascript', '1');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('7', 'Collections', '', '1', '7', 'javascript', '1');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('8', 'Quiz', '', '1', '7', 'javascript', '1');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('9', 'Object Oriented Programming', 'OOP wajib kalian kuasain karena OOP akan membantu kita ketika kita develop application yang sangat komplek', '2', '1', 'javascript', null);
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('10', 'Encapsulation', '', '2', '2', 'javascript', '9');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('11', 'Inheritance', '', '2', '3', 'javascript', '9');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('12', 'Abstraction', '', '2', '4', 'javascript', '9');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('13', 'Polymorphism', '', '2', '5', 'javascript', '9');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('14', 'Design Pattern', '', '2', '6', 'javascript', '9');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('15', 'Quiz', '', '2', '2', 'javascript', '9');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('16', 'Database', '', '3', '2', 'javascript', null);
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('17', 'Create Database', '', '3', '3', 'javascript', '16');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('18', 'DDL', '', '3', '4', 'javascript', '16');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('19', 'DML', '', '3', '5', 'javascript', '16');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('20', 'Back End', '', '4', '1', 'javascript', null);
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('21', 'NodeJS', '', '4', '2', 'javascript', '20');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('22', 'RestAPI', '', '4', '3', 'javascript', '20');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('23', 'ORM Sequelize', '', '4', '4', 'javascript', '20');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('24', 'First Project', '', '4', '5', 'javascript', '20');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('25', 'Front End', '', '5', '1', 'javascript', null);
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('26', 'HTML & CSS', '', '5', '2', 'javascript', '25');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('27', 'ReactJS', '', '5', '3', 'javascript', '25');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('28', 'Redux', '', '5', '4', 'javascript', '25');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('29', 'GraphQL', '', '5', '5', 'javascript', '25');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('30', 'Microservices', '', '6', '1', 'javascript', null);
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('31', 'Docker', '', '6', '2', 'javascript', '30');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('32', 'Kubernates', '', '6', '3', 'javascript', '30');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('33', 'Kafka', '', '6', '4', 'javascript', '30');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('34', 'Mini Project', '', '7', '1', 'javascript', null);
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('35', 'Revamp CodeAcademy', '', '7', '2', 'javascript', '34');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('36', 'Back End', '', '8', '3', 'javascript', '34');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('37', 'Front End', '', '9', '4', 'javascript', '34');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('38', 'Presentation', '', '10', '5', 'javascript', '34');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('39', 'Softskill', '', '11', '1', 'softskill', null);
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('40', 'Learning', '', '11', '2', 'softskill', '39');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('41', 'Disicpline', '', '11', '3', 'softskill', '39');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('42', 'Persistence', '', '11', '4', 'softskill', '39');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('43', 'Problem Solving', '', '11', '5', 'softskill', '39');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('44', 'Communication', '', '11', '6', 'softskill', '39');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('45', 'TeamWork', '', '11', '7', 'softskill', '39');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('46', 'Final Evaluation', '', '12', '1', 'Final', null);
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('47', 'Struktur programming language', '', '12', '2', 'Final', '46');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('48', 'Logika', '', '12', '3', 'Final', '46');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('49', 'OOP', '', '12', '4', 'Final', '46');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('50', 'Database', '', '12', '5', 'Final', '46');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('51', 'Webservices', '', '12', '6', 'Final', '46');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('52', 'Microservices', '', '12', '7', 'Final', '46');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('53', 'Tugas Harian', '', '12', '8', 'Final', '46');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('54', 'Presentation', '', '12', '1', 'Presentation', null);
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('55', 'Business Process', '', '12', '2', 'Presentation', '54');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('56', 'Performance', '', '12', '3', 'Presentation', '54');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('57', 'Media Material', '', '12', '4', 'Presentation', '54');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('58', 'Logic & Technical', '', '12', '5', 'Presentation', '54');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('59', 'Knowledge', '', '12', '6', 'Presentation', '54');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('60', 'Technical', '', '12', '1', 'Technical', null);
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('61', 'Fundamental & Logic', '', '12', '2', 'Technical', '60');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('62', 'OOP', '', '12', '3', 'Technical', '60');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('63', 'Database DDL & DDL', '', '12', '4', 'Technical', '60');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('64', 'Project', '', '12', '5', 'Technical', '60');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('65', 'Webservices', '', '12', '6', 'Technical', '60');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('66', 'Microservices', '', '12', '7', 'Technical', '60');
INSERT INTO master.skill_template (skte_id, skte_skil, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('67', 'Deployment', '', '12', '8', 'Technical', '60');

select * from master.skill_template

INSERT INTO master.job_type (joty_id, joty_name) VALUES ('1', 'Magang');
INSERT INTO master.job_type (joty_id, joty_name) VALUES ('2', 'Full-Time');
INSERT INTO master.job_type (joty_id, joty_name) VALUES ('3', 'Part-Time');
INSERT INTO master.job_type (joty_id, joty_name) VALUES ('4', 'Freelance');
INSERT INTO master.job_type (joty_id, joty_name) VALUES ('5', 'Contract');
INSERT INTO master.job_type (joty_id, joty_name) VALUES ('6', 'Prohibation');

select * from master.job_type

-- insert users --

INSERT INTO users.business_entity 
VALUES 
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9)

INSERT INTO users.roles (role_id, role_name, role_type)
VALUES 
(1, 'Candidat', 'External'),
(2, 'Candidat', 'External'),
(3, 'Recruiter', 'Internal'),
(4, 'Instructor', 'Internal'),
(5, 'Sales', 'Internal'),
(6, 'Manager', 'Internal'),
(7, 'Vice President', 'Internal'),
(8, 'Account Manager', 'Internal'),
(9, 'Student', 'External'),
(10, 'Administrator', 'Internal'),
(11, 'Outsource', 'Internal'),
(12, 'Employee', 'Internal')

select * from users.roles

INSERT INTO users.users (user_entity_id, user_name, user_password, user_first_name, user_last_name, user_email_promotion, user_demographic, user_photo, user_current_role)
VALUES
(1, 'kangdian', 'yadfaldjfapdjf;ajfpasdf', 'kang', 'dian', 1, '{"latitude":12.90,"longitude":-99.989}', 'photo.png', 4),
(2, 'nofal', 'ajdfja;dfpadjfadf', 'nofal', 'firdaus', 0, '{"latitude":12.90,"longitude":-99.989}', 'nofal.png', 4),
(3, 'abdul101', 'ajdfja;dfpadjfadf', 'Abdul', 'Razaq', 1, '{"latitude":12.90,"longitude":-99.989}', 'abdul.png', 1),
(4, 'ratih', 'yadlfjadjfa', 'ratih wina', 'ludwig', 0, '{"latitude":12.90,"longitude":-99.989}', 'ratih.png', 11),
(5, 'eka', 'ynyaldjf;adfadfad;faldfsa', 'Eka', 'Nugroho', 0, '{"latitude":12.90,"longitude":-99.989}', 'eka.png', 8),
(6, 'novia', 'lajdfljaljdfajdf;a', 'novia', 'slebew', 1, '{"latitude":12.90,"longitude":-99.989}', 'novia.png', 9),
(7, 'novelina', 'lkadjfajdf;adf', 'novelina', 'lina', 0, '{"latitude":12.90,"longitude":-99.989}', 'lina.png', 3),
(8, 'yugo', 'aldjfadfa;dfjlajdf;a', 'yugo', 'ardan', 1, '{"latitude":12.90,"longitude":-99.989}', 'yugo.png', 1),
(9, 'andhika', 'ladfljafjadfas;f', 'andhika', 'pratama', 1, '{"latitude":12.90,"longitude":-99.989}', 'andhika.png', 2)

INSERT INTO users.users_roles (usro_entity_id, usro_role_id)
VALUES
(1, 1),
(2, 1),
(3, 3),
(4, 5)

select * from users.users_roles



INSERT INTO users.phone_number_type (ponty_code)
VALUES
('Home'),
('Cell')

INSERT INTO users.users_phones (uspo_entity_id, uspo_number, uspo_ponty_code)
VALUES
(1, '8139809091', 'Cell'),
(1, '022-7890987', 'Home'),
(2, '089898989', 'Cell')

INSERT INTO users.users_address (etad_addr_id, etad_entity_id, etad_adty_id)
VALUES
(1, 1, 1),
(2, 2, 2)

INSERT INTO users.users_email (pmail_entity_id, pmail_address)
VALUES 
(1, 'dian@code.id'),
(1, 'dian@gmail.com'),
(2, 'nofal@code.id')

INSERT INTO users.users_media ( usme_entity_id, usme_file_link, usme_filename, usme_filesize, usme_filetype, usme_note)
VALUES
(1, 'https://', 'ijazah.png', 2345, 'jpg', 'ijazah'),
(1, 'https://', 'cv.docx', 1890, 'word', 'cv')

INSERT INTO users.users_education (usdu_entity_id, usdu_school, usdu_degree, usdu_field_study, usdu_start_date, usdu_end_date, usdu_grade, usdu_activities)
VALUES
(1, 'MIT', 'Bachelor', 'Informatic', '2000-07-12', '2005-08-12', 3.45, 'im bachelor with cumlaude')

INSERT INTO users.users_experiences (usex_entity_id, usex_title, usex_profile_headline, usex_employment_type, usex_company_name, usex_is_current, usex_start_date, usex_end_date, usex_industry, usex_description, usex_experience_type, usex_city_id)
VALUES
(1, 'Head Of Bootcamp','Software Engineer', 'fulltime', 'Code.id', '1', '2019-07-12', '2020-07-12', 'Consultant IT', 'i bleieve...', 'company', 1),
(1, 'Motivator','Act of Volunteer', 'freelance', 'Government', '0', '2019-07-12', '2020-07-12', 'Government', 'Helping people to Learn', 'voluntering', 1)

INSERT INTO users.users_experiences_skill (uesk_usex_id, uesk_uski_id)
VALUES
(1, 1),
(1, 2),
(1, 3)

INSERT INTO users.users_skill (uski_entity_id, uski_skty_name)
VALUES
(1, 'java'),
(1, 'dotnet'),
(2, 'javascript')

-- insert curriculum --
insert into curriculum.program_entity (prog_entity_id, prog_title, prog_headline, prog_type, prog_learning_type, prog_rating, prog_total_trainee, prog_image, prog_best_seller, prog_price, prog_language, prog_modified_date, prog_duration, prog_duration_type, prog_tag_skill, prog_city_id, prog_cate_id, prog_created_by, prog_status) values
(1, 'Javascript Fullstack From Zero To Expert', 'Modern javascript for everyone with projects, challenge and theory. More Course in one !', 'course', 'online', null, null, 'javascript.png', null, 750.000, 'bahasa', null, null, null, null, 1, 2, null, 'publish' ),
(2, 'Java Technology', 'Join bootcamp and become java developer', 'bootcamp', 'online', null, null, 'java.png', null, null, null, null, null, null, null, 2, 3, null, null ),
(3, 'Golang', 'Develop application with golang', 'course', 'online', null, null, null, null, null, null, null, null, null, null, null, 4, null, null )

insert into curriculum.program_entity_description (pred_prog_entity_id, pred_item_learning, pred_item_include, pred_requirement, pred_description, pred_target_level) values
( 1,
    '{"items" : [
        "Become an advanced, confident, and modern JavaScript developer from scratch",
        "Become job-ready by understanding how JavaScript really works behind the scenes",
        "JavaScript fundamentals: variables, if/else, operators, boolean logic, functions, arrays, objects, loops, strings, etc."
    ]}',
    '{"items" : [
        {"value" : "69 hours on-demand video", "icon" : "video"},
        {"value" : "22 articles", "icon" : "list"},
        {"value" : "18 downloadable resources", "icon" : "download"},
        {"value" : "Full lifetime access", "icon" : "infinite"},
        {"value" : "Access on mobile and TV", "icon" : "phone"},
        {"value" : "Certificate of completion", "icon" : "reward"}
    ]}',
    '{"items" : [
        "No coding experience is necessary to take this course! I take you from beginner to expert!",
        "Any computer and OS will work — Windows, macOS or Linux. We will set up your text editor in the course.",
        "A basic understanding of HTML and CSS is a plus, but not a must! The course includes an HTML and CSS crash course."
    ]}',
    '{"items" : "JavaScript is the most popular programming language in the world. It powers the entire modern web. It provides millions of high-paying jobs all over the world."}',
    '{"items" : "Take this course if you want to gain a true and deep understanding of JavaScript"}'
);

insert into curriculum.program_reviews (prow_user_entity_id,prow_prog_entity_id,prow_review,prow_rating,prow_modified_date)
values
(1,1,'Course javascript sangat comprehensif, mudah diikutin, trainer sangat menguasai materi',4,'2023-02-23'),
(2,2,'Very good, has allowed me to grasp the basic syntax and structure of Golang. Also provides effective challenges.',7,'2023-05-30'),
(3,3,'we going to practice variables and strings in JavaScript so you can hone your skills and feel confident taking them to the real world.',5,'2023-03-12')

select * from curriculum.program_reviews

insert into curriculum.sections (sect_prog_entity_id,sect_title,sect_description,sect_total_section,sect_total_lecture,sect_total_minute,sect_modified_date)
values
(1,'Javascript Fundamental',null,12,5,60,'2022-08-01'),
(1,'Iteration',null,23,8,120,'2022-03-10'),
(1,'Data Structure',null,8,7,80,'2023-01-15')

select * from curriculum.sections
	
insert into curriculum.section_detail (secd_title,secd_preview,secd_score,secd_note,secd_minute,secd_modified_date)
values
('Course Structure And Project',1,7,'you will learning how to create new project',185,'2023-03-23'),
('Setting up Visual Code',1,9,null,75,'2023-05-15')

select * from curriculum.section_detail

insert into curriculum.section_detail_material (sedm_filename,sedm_filesize,sedm_filetype,sedm_filelink,sedm_modified_date,sedm_secd_id)
values
('video1.mp4',12345,'video','https://codeacademy/assets','2023-01-23',1),
('video2.mp4',2435,'video','https://codeacademy/assets/gol','2023-01-23',2)

-- insert bootcamp --
INSERT INTO bootcamp.program_apply (prap_user_entity_id, prap_prog_entity_id, prap_test_score, prap_gpa, prap_iq_test, prap_review, prap_modified_date, prap_status) 
VALUES 
(2, 3, 75, NULL, 88, 'Personality ok, antusias, komunikasi bagus', '2023-07-06', 'recommended'),
(2, 1, 88, NULL, 88, 'Nice', '2023-07-06', 'passed');

select * from bootcamp.program_apply

-- Insert data into program_apply_progress table
INSERT INTO bootcamp.program_apply_progress (parog_id, parog_user_entity_id, parog_prog_entity_id, parog_action_date, parog_modified_date, parog_comment, parog_progress_name, parog_emp_entity_id, parog_status) 
VALUES 
(1, 2, 3, '2023-07-06', '2023-07-06', NULL, 'done', NULL, NULL),
(2, 2, 3, '2023-07-06', '2023-07-06', NULL, 'done', NULL, NULL),
(3, 2, 3, '2023-07-06', '2023-07-06', NULL, 'done', NULL, NULL),
(4, 2, 3, '2023-07-06', '2023-07-06', NULL, 'done', NULL, NULL),
(5, 2, 3, '2023-07-06', '2023-07-06', 'join bootcamp available di minggu ke 2 dari jadwal', 'done', NULL, NULL),
(6, 2, 3, '2023-07-06', '2023-07-06', NULL, 'done', NULL, NULL),
(7, 2, 3, '2023-07-06', '2023-07-06', NULL, 'done', NULL, NULL);

select * from bootcamp.program_apply_progress 

-- Insert data into batch table
INSERT INTO bootcamp.batch (batch_id, batch_entity_id, batch_name, batch_description, batch_start_date, batch_end_date, batch_reason, batch_type, batch_modified_date, batch_status, batch_pic_id) 
VALUES 
(1, 2, 'Batch#15', NULL, '2022-08-12', '2022-10-12', NULL, 'offline', '2023-07-06', 'New', NULL);

select * from bootcamp.batch

-- Insert data into batch_trainee table
INSERT INTO bootcamp.batch_trainee (batr_id, batr_status, batr_certificated, batre_certificate_link, batr_access_token, batr_access_grant, batr_review, batr_total_score, batr_modified_date, batr_trainee_entity_id, batr_batch_id)
VALUES 
(1, 'running', '0', NULL, NULL, '0', 'selama bootcamp ok nice', 88, '2023-07-06', 3, 1),
(2, 'running', '0', NULL, NULL, '0', 'selama bootcamp ok nice', 86, '2023-07-06', 1, 1);

select * from bootcamp.batch_trainee

-- Insert data into batch_trainee_evaluation table
INSERT INTO bootcamp.batch_trainee_evaluation (btev_id, btev_type, btev_header, btev_section, btev_skill, btev_week, btev_skor, btev_note, btev_modified_date, btev_batch_id, btev_trainee_entity_id)
VALUES 
(1, 'hardskill', 'Fundamental', NULL, 'Database', 1, 4, NULL, '2023-07-06', 1, 3),
(2, 'softskill', 'Fundamental', NULL, 'Database', 2, 4, NULL, '2023-07-06', 1, 3),
(3, 'hardskill', 'Fundamental', NULL, 'OOP', 3, 3, NULL, '2023-07-06', 1, 3),
(4, 'softskill', NULL, NULL, 'Dicipline', 4, 4, NULL, '2023-07-06', 1, 3);

select * from bootcamp.batch_trainee_evaluation 

-- Insert data into instructor_programs table
INSERT INTO bootcamp.instructor_programs (batch_id, inpro_entity_id, inpro_emp_entity_id, inpro_modified_date) 
VALUES 
(1, 2, 1, NULL),
(1, 2, 4, NULL);


select * from bootcamp.instructor_programs



-- insert jobhire --
INSERT INTO jobhire.job_category (joca_id, joca_name) 
	VALUES 
		(1, 'Software Engineer'),
		(2, 'Business Development'),
		(3, 'Marketing'),
		(4, 'Operations')

INSERT INTO jobHire.client (clit_id, clit_name, clit_about, clit_addr_id, clit_emra_id)
	VALUES
		(1, 'Code ID', 'CODE.ID is a software development service company that focuses on helping clients turn their best ideas into a product, application, or website.',null,null),
		(2, 'Telkomsel', 'adalah operator telekomunikasi seluler pertama di Indonesia yang berbasis teknologi jaringan GSM Dual Band (900 & 1800), GPRS, WiFi, EDGE, 3G, HSDPA dan HSPA di seluruh Indonesia',null,null),
		(3, 'Astra Internasional', 'PT Astra International Tbk. (IDX: ASII) adalah sebuah konglomerat multinasional yang berkantor pusat di Jakarta, Indonesia',null,null);
		
INSERT INTO jobhire.job_post (jopo_entity_id, jopo_number,jopo_title, jopo_min_salary,  jopo_max_salary ,jopo_start_date, jopo_end_date, jopo_emp_entity_id, jopo_clit_id ,jopo_joro_id, jopo_joty_id, jopo_joca_id, jopo_status, jopo_min_experience, jopo_max_experience,  jopo_primary_skill  )
	VALUES
		(1,'JOB20220727-0001', 'Java Developer', 9000000, 16000000, '12-07-2022', '12-08-2022', 7 , 3, 1, 5, 1, 'publish', 1, 3, 'java,sql')
		
		
INSERT INTO jobhire.talent_apply(taap_user_entity_id, taap_entity_id, taap_intro, taap_scoring, taap_modified_date, taap_status)
	VALUES
		(1, 1, 'Perkenalkan nama saya andhika, saya data scienties anthusias', 8, '2022-07-12', 'Interview')

INSERT INTO jobHire.talent_apply_progress(tapr_id, taap_user_entity_id, taap_entity_id, tapr_modified_date, tapr_status)
	VALUES
		(1, 1, 1, '2022-07-15', 'done'),
		(2, 1, 1, '2022-07-15', 'done'),
		(3, 1, 1, '2022-07-18', 'waiting'),
		(4, 1, 1, '2022-07-18', 'waiting');

INSERT INTO jobhire.job_post_desc (jopo_entity_id)
	VALUES
		(1) 
		
	-- insert hr --
INSERT INTO  hr.employee (emp_entity_id, emp_emp_number, emp_national_id, emp_birth_date, emp_marital_status, emp_gender, emp_hire_date, emp_salaried_flag, emp_vacation_hours, emp_sickleave_hours, emp_current_flag, emp_type, emp_joro_id)
VALUES
(1, 202207001, 13419981009004, '1998-03-12', 'M', 'M','2020-01-10', '1', 12, 12, 1, 'Internal', 1),
(4, 202207002, 13420021009004, '2002-01-12', 'S', 'F','2020-01-11', '1', 12, 12, 1, 'Outsource', 1),
(5, 202205001, 13419771009005, '1977-01-12', 'M', 'M','2020-01-12', '1', 12, 12, 1, 'Internal', 1),
(7, 202205035, 13419771009006, '1998-03-12', 'S', 'F','2020-01-13', '1', 12, 12, 1, 'Outsource', 1);

INSERT INTO hr.employee_client_contract (ecco_entity_id, ecco_contract_no, ecco_contract_date, ecco_start_date, ecco_end_date, ecco_notes, ecco_media_link, ecco_joty_id, ecco_account_manager, ecco_clit_id, ecco_status) 
VALUES
(4, '002/HR-CODE.ID/PKWTT/I/2022', '2022-06-13', '2022-06-13', '2023-06-13', 'Karyawan Outsource', 'https://codeacademy/assets/contract.pdf', 1, 5, 1, 'Contract');

INSERT INTO hr.department (dept_name)
VALUES
('Development'),
('Sales'),
('Bootcamp Academy');

INSERT INTO hr.employee_department_history (edhi_entity_id, edhi_start_date, edhi_end_date, edhi_dept_id)
VALUES
(1, '2019-07-12', '2020-07-12', 1),
(4, '2020-07-12', '2021-07-12', 3);

INSERT INTO hr.employee_pay_history (ephi_entity_id, ephi_rate_change_date, ephi_rate_salary, ephi_pay_frequence)
VALUES
(1,'2019-07-12', 6000000, 1),
(4,'2020-07-12', 7000000, 1);

-- insert sales --

INSERT INTO sales.special_offer (spof_id, spof_description, spof_discount, spof_start_date,spof_end_date,spof_min_qty,spof_max_qty, spof_cate_id)
VALUES (1, 'Dapatkan discount 50%, untuk 5 orang', 50,'2022-10-27', '2022-07-27', 1, 5, 1);

INSERT INTO sales.special_offer_programs (soco_spof_id, soco_prog_entity_id )
VALUES (1, 1),
       (1, 3);

INSERT INTO sales.cart_items (cait_id, cait_quantity, cait_user_entity_id, cait_prog_entity_id)
VALUES (1, 1, 3, 1),
       (2, 1, 3, 3);

INSERT INTO sales.sales_order_header (sohe_id, sohe_order_date, sohe_due_date, sohe_ship_date,sohe_order_number,sohe_account_number,sohe_subtotal, sohe_tax, sohe_total_due, sohe_status)
VALUES (1, '2022-06-22', '2022-06-30',  '2022-06-28', 'ORD#20220727-0000001', 131899555, 0, 50000, 1, 'Closed');


INSERT INTO sales.sales_order_detail (sode_id, sode_qty, sode_unit_price, sode_unit_discount,sode_line_total,sode_sohe_id,sode_prog_entity_id)
VALUES (1, 1, 100000, 50, 50000, 1, 1);

-- insert payment --

INSERT INTO payment.bank (bank_entity_id, bank_code, bank_name) VALUES
(6, 'BCA', 'Bank Central Asia'),
(7, 'BNI', 'Bank Negara Indonesia'),
(8, 'MAN', 'Bank Mandiri'),
(9, 'JAGO', 'Bank Jago');
SELECT * FROM payment.bank;

INSERT INTO payment.fintech (fint_entity_id, fint_code, fint_name) VALUES
(7, 'GOTO', 'Payment GoTo'),
(8, 'OVO', 'OVO'),
(9, 'SP', 'Shopee Paylater');
SELECT * FROM payment.fintech;

INSERT INTO payment.users_account (usac_bank_entity_id, usac_user_entity_id, usac_account_number, usac_saldo, usac_type, usac_status) VALUES
(8, 3, 131899555, 100000, 'debit', 'active'),
(9, 3, 087654321, 50000, 'payment', 'inactive');
SELECT * FROM payment.users_account;

INSERT INTO payment.transaction_payment (trpa_id, trpa_code_number, trpa_order_number, trpa_debit, trpa_credit, trpa_type, trpa_note, trpa_modified_date, trpa_source_id, trpa_target_id, trpa_user_entity_id) VALUES
(1, 20220727#000001, null, 0,	50000, 'top-up', 'topup bank ke goto', null, 131899555, 087654321, 3),	
(2,	20220727#000002, null, 50000,	0, 'top-up', 'receive topup', null, 087654321, 131899555, 3),
(3,	20220727#000003, null, null, 10000, 'order', 'bayar shoppe order', null, 131899555, 99999, 3);

SELECT * FROM payment.transaction_payment;
