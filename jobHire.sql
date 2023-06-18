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