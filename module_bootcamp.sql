-- module users
CREATE TABLE business_entity (
    entity_id SERIAL PRIMARY KEY
);

-- module program
CREATE TABLE program_entity (
    prog_entity_id SERIAL PRIMARY KEY,
    entity_id SERIAL,
    FOREIGN KEY (entity_id) REFERENCES business_entity(entity_id)
);

-- module master
CREATE TABLE status (
    status VARCHAR(15) PRIMARY KEY
);

-- module users
CREATE TABLE users (
    user_entity_id SERIAL PRIMARY KEY,
    entity_id SERIAL,
    FOREIGN KEY (entity_id) REFERENCES business_entity(entity_id)
);

-- module hr
CREATE TABLE employee (
    emp_entity_id SERIAL PRIMARY KEY
);

-- MODULE BOOTCAMP

CREATE TABLE program_apply (
    prap_user_entity_id INTEGER,
    prap_prog_entity_id INTEGER,
    prap_test_score INTEGER,
    prap_gpa INTEGER,
    prap_iq_test INTEGER,
    prap_review VARCHAR(256),
    prap_modified_date TIMESTAMP,
    prap_status VARCHAR(15),
    FOREIGN KEY (prap_user_entity_id) REFERENCES users(user_entity_id),
    FOREIGN KEY (prap_prog_entity_id) REFERENCES program_entity(prog_entity_id),
    FOREIGN KEY (prap_status) REFERENCES status(status),
    CONSTRAINT program_apply_pk PRIMARY KEY (prap_user_entity_id, prap_prog_entity_id)
);

CREATE TABLE program_apply_progress (
    parog_id SERIAL,
    parog_user_entity_id INTEGER,
    parog_prog_entity_id INTEGER,
    parog_action_date TIMESTAMP,
    parog_modified_date TIMESTAMP,
    parog_comment VARCHAR(512),
    parog_progress_name VARCHAR(15),
    parog_emp_entity_id INTEGER,
    parog_status VARCHAR(15),
    FOREIGN KEY (parog_user_entity_id) REFERENCES users(user_entity_id),
    FOREIGN KEY (parog_prog_entity_id) REFERENCES program_entity(prog_entity_id),
    FOREIGN KEY (parog_emp_entity_id) REFERENCES employee(emp_entity_id),
    FOREIGN KEY (parog_status) REFERENCES status(status),
    CONSTRAINT program_apply_progress_pk PRIMARY KEY (parog_id, parog_user_entity_id, parog_prog_entity_id)
);

CREATE TABLE batch (
    batch_id SERIAL,
    batch_entity_id INTEGER,
    batch_name VARCHAR(15) UNIQUE,
    batch_description VARCHAR(125),
    batch_start_date TIMESTAMP,
    batch_end_date TIMESTAMP,
    batch_reason VARCHAR(256),
    batch_type VARCHAR(15),
    batch_modified_date TIMESTAMP,
    batch_status VARCHAR(15),
    batch_pic_id INTEGER,
    FOREIGN KEY (batch_entity_id) REFERENCES program_entity(prog_entity_id),
    FOREIGN KEY (batch_status) REFERENCES status(status),
    FOREIGN KEY (batch_pic_id) REFERENCES employee(emp_entity_id),
    CONSTRAINT batch_pk PRIMARY KEY (batch_id, batch_entity_id)
);

CREATE TABLE batch_trainee (
    batr_id SERIAL,
    batr_status VARCHAR(15),
    batr_certificated CHAR(1),
    batre_certificate_link VARCHAR(255),
    batr_access_token VARCHAR(255),
    batr_access_grant CHAR(1),
    batr_review VARCHAR(1024),
    batr_total_score INTEGER,
    batr_modified_date TIMESTAMP,
    batr_trainee_entity_id INTEGER,
    batr_batch_id INTEGER,
    FOREIGN KEY (batr_trainee_entity_id) REFERENCES users(user_entity_id),
    FOREIGN KEY (batr_batch_id) REFERENCES batch(batch_id),
    CONSTRAINT batch_trainee_pk PRIMARY KEY (batr_id, batr_batch_id)
);

CREATE TABLE batch_trainee_evaluation (
    btev_id SERIAL PRIMARY KEY,
    btev_type VARCHAR(15),
    btev_header VARCHAR(256),
    btev_section VARCHAR(256),
    btev_skill VARCHAR(256),
    btev_week INTEGER,
    btev_skor INTEGER,
    btev_note VARCHAR(256),
    btev_modified_date TIMESTAMP,
    btev_batch_id INTEGER,
    btev_trainee_entity_id INTEGER,
    FOREIGN KEY (btev_batch_id) REFERENCES batch(batch_id),
    FOREIGN KEY (btev_trainee_entity_id) REFERENCES users(user_entity_id)
);

CREATE TABLE instructor_programs (
    batch_id INTEGER,
    inpro_entity_id INTEGER,
    inpro_emp_entity_id INTEGER,
    inpro_modified_date TIMESTAMP,
    FOREIGN KEY (batch_id) REFERENCES batch(batch_id),
    FOREIGN KEY (inpro_entity_id) REFERENCES program_entity(prog_entity_id),
    FOREIGN KEY (inpro_emp_entity_id) REFERENCES employee(emp_entity_id),
    CONSTRAINT instructor_programs_pk PRIMARY KEY (batch_id, inpro_entity_id)
);