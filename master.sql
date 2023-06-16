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

foreign key (cate_cate_id) references master.category(cate_cateid)
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

create table master.skil_type(
skty_name varchar (55)primary key
)

create table master.skil_template(
skte_id serial primary key,
skte_skil varchar(256),
skte_description varchar (256),
skte_week integer,
skte_orderby integer,
skte_modified_date timestamp,
skty_name varchar(55),
skte_skte_id integer,
foreign key (skty_name) references master.skil_type(skty_name),
foreign key (skte_skte_id) references master.skil_template(skte_id)
)

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
	foreign key (prov_country_code) references master.province(prov_code)
)

create table master.city(
city_id serial primary key,
	city_name varchar(155)unique,
	city_modified_date timestamp,
	city_prov_id integer,
	foreign key (city_prov_id) references master.province(prov_id )
)

create table master.address(
addr_id serial primary key,
addr_line1 varchar(255)unique ,
addr_line2 varchar(255)unique,
addr_postal_code varchar(10)unique,
	addr_spatial_location varchar,
	addr_modified_date timestamp,
	addr_city_id integer,
	foreign key (addr_city_id) references  master.address(addr_id)
)





















