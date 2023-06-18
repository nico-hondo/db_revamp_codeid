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