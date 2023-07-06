---- create schema --------

create schema curriculum

create schema master

create schema users

----- create table & sequence ---------

create table curriculum.program_entity_description(
	pred_prog_entity_id integer primary key,
	pred_item_learning json,
	pred_item_include json,
	pred_requirement json,
	pred_description json,
	pred_target_level json
)

create table master.city(
	city_id serial primary key
)

create table master.category(
	cate_id serial primary key
)

create table master.status(
	status varchar(15) primary key
)

create table users.users(
	created_by varchar(20) unique,
	user_entity_id integer unique,
	foreign key (user_entity_id) references users.business_entity (entity_id),
	constraint user_entity_id primary key (user_entity_id, created_by)
)

create table curriculum.program_entity(
	prog_entity_id serial primary key,
	prog_title varchar(256),
	prog_headline varchar(512),
	prog_type varchar(15) CHECK (prog_type IN ('bootcamp','course')),
	prog_learning_type varchar(15) CHECK (prog_learning_type IN ('online', 'offline','both')),
	prog_rating integer,
	prog_total_trainee integer,
	prog_image varchar(256),
	prog_best_seller char(1) CHECK (prog_best_seller in ('0', '1')),
	prog_price integer,
	prog_language varchar(35),
	prog_modified_date timestamp,
	prog_duration integer,
	prog_duration_type varchar(15) CHECK (prog_duration_type in ('month', 'week','days')),
	prog_tag_skill varchar(512),
	prog_city_id integer unique,
	prog_cate_id integer unique,
	prog_created_by integer,
	prog_status varchar(15) CHECK (prog_status in('draft','publish')),
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

create table users.business_entity(
	entity_id serial primary key
)

create table curriculum.program_reviews(
	prow_user_entity_id integer,
	prow_prog_entity_id integer,
	prow_review varchar(512),
	prow_rating integer,
	prow_modified_date timestamp,
	foreign key (prow_user_entity_id) references users.users (user_entity_id),
	foreign key (prow_prog_entity_id) references curriculum.program_entity (prog_entity_id),
	constraint prow_user_entity_id primary key (prow_user_entity_id, prow_prog_entity_id)
)

create table curriculum.sections(
	sect_title varchar(100),
	sect_description varchar(256),
	sect_total_section integer,
	sect_total_lecture integer,
	sect_total_minute integer,
	sect_modified_date timestamp,
	sect_prog_entity_id integer,
	sect_id serial unique,
	constraint sect_id primary key (sect_id, sect_prog_entity_id),
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
	secd_id serial primary key unique,
	secd_title varchar(256),
	secd_preview char(1) CHECK (secd_preview in ('0' ,'1')),
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
	sedm_id serial primary key unique,
	sedm_filename varchar(55),
	sedm_filesize integer,
	sedm_filetype varchar(15),
	sedm_filelink varchar(255),
	sedm_modified_date timestamp,
	sedm_secd_id integer,
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


----- insert into table ---------

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

select * from curriculum.program_entity_description

insert into master.city (city_id) values
(1),
(2)

insert into master.category (cate_id) values
(2),
(3),
(4)

insert into master.status (status) values
('publish')

insert into users.users (created_by,user_entity_id) values
('kangdian', 1),
('nofal', 2),
('abdul101', 3),
('ratih', 4),
('eka', 5),
('novia', 6),
('novelina', 7),
('yugo', 8),
('andhika', 9)

insert into curriculum.program_entity (prog_entity_id, prog_title, prog_headline, prog_type, prog_learning_type, prog_rating, prog_total_trainee, prog_image, prog_best_seller, prog_price, prog_language, prog_modified_date, prog_duration, prog_duration_type, prog_tag_skill, prog_city_id, prog_cate_id, prog_created_by, prog_status) values
(1, 'Javascript Fullstack From Zero To Expert', 'Modern javascript for everyone with projects, challenge and theory. More Course in one !', 'course', 'online', null, null, 'javascript.png', null, 750.000, 'bahasa', null, null, null, null, 1, 2, null, 'publish' ),
(2, 'Java Technology', 'Join bootcamp and become java developer', 'bootcamp', 'online', null, null, 'java.png', null, null, null, null, null, null, null, 2, 3, null, null ),
(3, 'Golang', 'Develop application with golang', 'course', 'online', null, null, null, null, null, null, null, null, null, null, null, 4, null, null )

select * from curriculum.program_entity
	
insert into users.business_entity (entity_id) values
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9)

insert into curriculum.program_reviews (prow_user_entity_id,prow_prog_entity_id,prow_review,prow_rating,prow_modified_date)
values
(6,1,'Course javascript sangat comprehensif, mudah diikutin, trainer sangat menguasai materi',4,'2023-02-23'),
(2,2,'Very good, has allowed me to grasp the basic syntax and structure of Golang. Also provides effective challenges.',7,'2023-05-30'),
(4,3,'we going to practice variables and strings in JavaScript so you can hone your skills and feel confident taking them to the real world.',5,'2023-03-12')

select * from curriculum.program_reviews

insert into curriculum.sections (sect_id,sect_prog_entity_id,sect_title,sect_description,sect_total_section,sect_total_lecture,sect_total_minute,sect_modified_date)
values
(1,1,'Javascript Fundamental',null,12,5,60,'2022-08-01'),
(2,1,'Iteration',null,23,8,120,'2022-03-10'),
(3,1,'Data Structure',null,8,7,80,'2023-01-15')

select * from curriculum.sections
	
insert into curriculum.section_detail (secd_id,secd_title,secd_preview,secd_score,secd_note,secd_minute,secd_modified_date)
values
(1,'Course Structure And Project',1,7,'you will learning how to create new project',185,'2023-03-23'),
(2,'Setting up Visual Code',1,9,null,75,'2023-05-15')

select * from curriculum.section_detail

insert into curriculum.section_detail_material (sedm_id,sedm_filename,sedm_filesize,sedm_filetype,sedm_filelink,sedm_modified_date,sedm_secd_id)
values
(1,'video1.mp4',12345,'MP4','https://codeacademy/assets','2023-01-23',1),
(2,'video2.mp4',2435,'MP4','https://codeacademy/assets/gol','2023-01-23',2)

select * from curriculum.section_detail_material
	


