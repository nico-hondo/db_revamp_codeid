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
);

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
);

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
);

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
);

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
);


INSERT INTO  hr.employee (emp_entity_id, emp_emp_number, emp_national_id, emp_birth_date, emp_marital_status, emp_gender, emp_hire_date, emp_salaried_flag, emp_vacation_hours, emp_sickleave_hours, emp_current_flag, emp_modified_date, emp_type, emp_joro_id, emp_emp_entity_id)
VALUES
(1, 202207001, 13419981009004, '1998-03-12', 'M', 'M','2020-01-10', '1', 12, 12, 1, '2023-07-06', 'Internal', 1, 5)
(4, 202207002, 13420021009004, '2002-01-12', 'S', 'F','2020-01-11', '1', 12, 12, 1, '2023-07-06', 'Outsource', 2, 1)
(5, 202205001, 13419771009005, '1977-01-12', 'M', 'M','2020-01-12', '1', 12, 12, 1, '2023-07-06', 'Internal', 3, 1)
(7, 202205035, 13419771009006, '1998-03-12', 'S', 'F','2020-01-13', '1', 12, 12, 1, '2023-07-06', 'Outsource', 4, 5)

INSERT INTO hr.employee_client_contract (ecco_entity_id, ecco_contract_no, ecco_contract_date, ecco_start_date, ecco_end_date, ecco_notes, ecco_modified_date, ecco_media_link, ecco_joty_id, ecco_account_manager, ecco_clit_id, ecco_status) 
VALUES
(4, '002/HR-CODE.ID/PKWTT/I/2022', '2022-06-13', '2022-06-13', '2023-06-13', 'Karyawan Outsource', '2023-06-07', 'https://codeacademy/assets/contract.pdf', 1, 5, 1, 'Contract')

INSERT INTO hr.department (dept_name, dept_modified_date)
VALUES
('Development', '2023-06-07')
('Sales', '2023-06-07')
('Bootcamp Academy', '2023-06-07')

INSERT INTO hr.employee_department_history (edhi_entity_id, edhi_start_date, edhi_end_date, edhi_modified_date, edhi_dept_id)
VALUES
(1, '2019-07-12', '2020-07-12', '2023-06-07', 1)
(2, '2020-07-12', '2021-07-12', '2023-06-07', 3)

INSERT INTO hr.employee_pay_history (ephi_entity_id, ephi_rate_change_date, ephi_rate_salary, ephi_pay_frequence, ephi_modified_date)
VALUES
(1,'2019-07-12', 6000000, 1, '2023-06-07')
(2,'2020-07-12', 7000000, 1, '2023-06-07')
