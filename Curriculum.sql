create schema curriculum

create table curriculum.program_entity_description(
	pred_prog_entity_id integer primary key,
	pred_item_learning varchar,
	pred_item_include varchar,
	pred_requirement varchar,
	pred_description varchar,
	pred_target_level varchar
)

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
	prog_best_seller char(1) CHECK (prog_best_seller in (0, 1)),
	prog_price integer,
	prog_language varchar(35),
	prog_modified_date timestamp,
	prog_duration integer,
	prog_duration_type varchar(15) CHECK (prog_duration_type in ('month', 'week','days')),
	prog_tag_skill varchar(512),
	prog_city_id integer,
	prog_cate_id integer,
	prog_created_by integer,
	prog_status varchar(15) CHECK (prog_status in('draft','publish'))
	foreign key (prog_city_id) references master.city (city_id),
	foreign key (prog_cate_id) references master.category (cate_id),
	foreign key (prog_created_by) references users.users (created_by),
	foreign key (prog_status) references master.status (status)								
)
	
-- CREATE SEQUENCE prog_entity_id TABLE PROGRAM ENTITY
CREATE SEQUENCE seq_prog_entity_id
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1

create or replace function progEntityIdSeq() 
	returns varchar as $$
	select lpad(''||nextval('seq_prog_entity_id'),4,'0')
end;$$ 
language sql

alter table curriculum.program_entity alter column prog_entity_id set default progEntityIdSeq()

create table curriculum.program_reviews(
	prow_user_entity_id integer,
	prow_prog_entity_id integer,
	prow_review varchar(512),
	prow_rating integer,
	prow_modified_date timestamp,
	constraint prow_user_entity_id primary key (prow_user_entity_id, prow_prog_entity_id),
	foreign key (prow_user_entity_id) references master.users (user_entity_id),
	foreign key (prow_prog_entity_id) references curriculum.program_entity (prog_entity_id)	
)
	
create table curriculum.sections(
	sect_title varchar(100),
	sect_description varchar(256),
	sect_total_section integer,
	sect_total_lecture integer,
	sect_total_minute integer,
	sect_modified_date timestamp,
	sect_prog_entity_id integer,
	sect_id serial,
	constraint sect_id primary key (sect_id, sect_prog_entity_id)
	foreign key (sect_prog_entity_id) references curriculum.program_entity (prog_entity_id)	
	
)
	
-- CREATE SEQUENCE sect_id TABLE SECTIONS
CREATE SEQUENCE seq_sect_id
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1

create or replace function sectIdSeq() 
	returns varchar as $$
	select lpad(''||nextval('seq_sect_id'),4,'0')
end;$$ 
language sql

alter table curriculum.sections alter column sect_id set default sectIdSeq()
	
create table curriculum.section_detail(
	secd_id serial primary key,
	secd_title varchar(256),
	secd_preview char(1) check (secd_preview in(0,1)),
	secd_score integer,
	secd_note varchar(256),
	secd_minute integer,
	secd_modified_date timestamp,
	secd_sect_id integer,
	foreign key (secd_sect_id) references curriculum.sections (sect_id)	
)
	
-- CREATE SEQUENCE secd_id TABLE SECTION DETAIL
CREATE SEQUENCE seq_secd_id
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1

create or replace function secdIdSeq() 
	returns varchar as $$
	select lpad(''||nextval('seq_secd_id'),4,'0')
end;$$ 
language sql

alter table curriculum.section_detail alter column secd_id set default secdIdSeq()
	
create table curriculum.section_detail_material(
	sedm_id serial primary key,
	sedm_filename varchar(55),
	sedm_filesize integer,
	sedm_filetype varchar(15),
	sedm_filelink varchar(255),
	sedm_modified_date timestamp,
	foreign key (sedm_secd_id) references curriculum.section_detail (secd_id)
)
	
-- CREATE SEQUENCE sedm_id TABLE SECTION DETAIL MATERIAL
CREATE SEQUENCE seq_sedm_id
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1

create or replace function sedmIdSeq() 
	returns varchar as $$
	select lpad(''||nextval('seq_sedm_id'),4,'0')
end;$$ 
language sql

alter table curriculum.section_detail_material alter column sedm_id set default sedmIdSeq()