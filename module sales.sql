create table special_offer (
	spof_id serial primary key ,
	spof_description varchar(256) ,
	spof_discount int ,
	spof_type varchar(15) ,
	spof_start_date timestamp ,
	spof_end_date timestamp ,
	spof_min_qty int ,
	spof_max_qty int ,
	spof_cate_id int foreign key//
)

create table special_offer_programs (
	soco_id serial primary key ,
	soco_spof_id serial ,
	soco_prog_entity_id int ,
	soco_status varchar (15) ,
	soco_modified_date timestamp ,
	foreign key (soco_spof_id) references special_offer(spof_id) ,
	foreign key (soco_prog_entity_id) references curriculum.program_entity(prog_entity_id),
	constraint special_offer_programs_pk primary key(soco_id,soco_spof_id,soco_prog_entity_id)
)

create table program_entity (
	prog_entity_id serial primary key ,
)

create table users (
	user_entity_id int primary key ,
)

create table cart_items (
	cait_id serial primary key ,
	cait_quantity int ,
	cait_unit_price money ,
	cait_modified_date timestamp ,
	cait_user_entity_id int ,
	cait_prog_entity_id int ,
	foreign key (cait_user_entity_id) references users.users(user_entity_id) ,
	foreign key (cait_prog_entity_id) references curriculum.program_entity(prog_entity_id)
)

create table status (
	status varchar (15) primary key
)

create table sales_	order_header (
	sohe_id serial primary key ,
	sohe_order_date timestamp ,
	sohe_due_date timestamp ,
	sohe_ship_date timestamp ,
	sohe_order_number varchar(25) unique ,
	sohe_account_number varchar(25) ,
	sohe_trpa_code_number varchar(25) ,
	sohe_subtotal money ,
	sohe_tax money ,
	sohe_total_due int ,
	sohe_license_code varchar (512) unique ,
	sohe_modified_date timestamp ,
	sohe_user_entity_id int ,
	sohe_status varchar(15) ,
	foreign key (sohe_user_entity_id) references users.users(user_entity_id),
	foreign key (sohe_status) references master.status(status)
)

create table sales.sales_order_detail (
	sode_id int ,
	sode_qty int ,
	sode_unit_price money ,
	sode_unit_discount money ,
	sode_line_total int ,
	sode_modified_date timestamp ,
	sode_sohe_id int ,
	sode_prog_entity_id int
	foreign key (sode_user_entity_id) references users.users(user_entity_id)
)




