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