create table users.roles(
    role_id serial Primary Key,
    role_name varchar(35) unique,
    role_type varchar(15),
    role_modified_date timestamp
)

create table users.users_roles(
    usro_entity_id integer Primary Key,
    usro_role_id integer,
    usro_modified_date timestamp,
    FOREIGN KEY (usro_entity_id) REFERENCES business_entity(entity_id),
    FOREIGN KEY (usro_role_id) REFERENCES users.roles(role_id),
    CONSTRAINT usro_role_id PRIMARY KEY (usro_role_id)
)

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
    FOREIGN KEY (user_entity_id) REFERENCES business_entity (entity_id),
    FOREIGN KEY (user_current_role) REFERENCES users.users_roles (usro_role_id)
)

CREATE TABLE users.users_experiences(
    usex_id SERIAL PRIMARY KEY,
    usex_entity_id INTEGER,
    usex_title VARCHAR(255),
    usex_profile_headline VARCHAR(512),
    usex_employment_type VARCHAR(15) CHECK (usex_employment_type IN ('fulltime', 'freelance')),
    usex_company_name VARCHAR(255),
    usex_is_current CHAR (1),
    usex_start_date TIMESTAMP,
    usex_end_date TIMESTAMP,
    usex_industry VARCHAR(15),
    usex_description VARCHAR(512),
    usex_experience_type VARCHAR(15) CHECK (usex_experience_type IN ('company', 'certified', 'voluntering', 'organization', 'reward')),
    usex_city_id INTEGER,
    FOREIGN KEY (usex_entity_id) REFERENCES users.users (user_entity_id),
    FOREIGN KEY (usex_city_id) REFERENCES master.city (city_id),
    CONSTRAINT usex_entity_id PRIMARY KEY (usex_enity_id)
)

CREATE TABLE users.users_skill (
    uski_id SERIAL PRIMARY KEY,
    uski_entity_id INTEGER ,
    uski_modified_date TIMESTAMP,
    uski_skty_name VARCHAR(15),
    FOREIGN KEY (uski_entity_id) REFERENCES users.users (user_entity_id),
    FOREIGN KEY (uski_skty_name) REFERENCES master.skill_type (skty_name),
    CONSTRAINT uski_entity_id PRIMARY KEY (uski_entity_id)
)

CREATE TABLE users.users_experiences_skill (
    uesk_usex_id INTEGER,
    uesk_uski_id INTEGER,
    CONSTRAINT uesk PRIMARY KEY (uesk_usex_id, uesk_uski_id),
    FOREIGN KEY (uesk_usex_id) REFERENCES users.users_experiences (usex_id),
    FOREIGN KEY (uesk_uski_id) REFERENCES users.users_skill (uski_id)
)

CREATE TABLE users.users_license(
    usli_id SERIAL PRIMARY KEY,
    usli_license_code VARCHAR(512) UNIQUE,
    usli_modified_date TIMESTAMP,
    usli_status VARCHAR(15) CHECK (usli_status IN ('Active', 'NonActive')),
    usli_entity_id INTEGER,
    CONSTRAINT entity_id PRIMARY KEY (usli_entity_id),
    FOREIGN KEY (usli_entity_id) REFERENCES users.users (user_entity_id)
)

CREATE TABLE users.users_email (
    pmail_entity_id INTEGER,
    pmail_id SERIAL,
    pmail_address VARCHAR(50),
    pmail_modified_date TIMESTAMP,
    CONSTRAINT pmail PRIMARY KEY (pmail_entity_id, pmail_id),
    FOREIGN KEY (pmail_entity_id) REFERENCES users.users (user_entity_id)
)

CREATE TABLE users.users_media(
    usme_id SERIAL PRIMARY KEY,
    usme_entity_id INTEGER,
    usme_file_link VARCHAR(255),
    usme_filename VARCHAR(55),
    usme_filesize INTEGER,
    usme_filetype VARCHAR(15) CHECK (usme_filetype IN ('jpg', 'pdf', 'word')),
    usme_note VARCHAR(55),
    usme_modified_date TIMESTAMP,
    CONSTRAINT media_id PRIMARY KEY (usme_entity_id),
    FOREIGN KEY (esme_entity_id) REFERENCES users.users (user_entity_id)
)

CREATE TABLE users.users_eductaion(
    usdu_id SERIAL PRIMARY KEY,
    usdu_entity_id INTEGER,
    usdu_school VARCHAR(255),
    usdu_degree VARCHAR(15) CHECK (usdy_degree IN ('Bachelor', 'Diploma')),
    usdu_field_study VARCHAR(125),
    usdu_graduate_year VARCHAR(4),
    usdu_start_date TIMESTAMP,
    usdu_end_date TIMESTAMP,
    usdu_grade VARCHAR(5),
    usdu_activities VARCHAR(512),
    usdu_description VARCHAR(512),
    usdu_modified_date TIMESTAMP,
    CONSTRAINT education PRIMARY KEY (usdu_entity_id),
    FOREIGN KEY (usdu_entity_id) REFERENCES users.users (user_entity_id)
)

CREATE TABLE phone_number_type (
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
    FOREIGN KEY (uspo_ponty_code) REFERENCES phone_number_type (ponty_code)
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