create table program_entity_description(
	pred_prog_entity_id serial primary key,
	pred_item_learning varchar,
	pred_item_include varchar,
	pred_requirement varchar,
	pred_description varchar,
	pred_target_level varchar
)

create table program_entity(
	prog_entity_id serial primary key,
	prog_title varchar(256),
	prog_headline varchar(512),
	prog_type varchar(15) CHECK (prog_type IN ('bootcamp','course')),
	prog_learning_type varchar(15) CHECK (prog_learning_type IN ('online', 'offline','both')),
	prog_rating integer,
	prog_total_trainee integer,
	prog_modified_date timestamp,
	prog_image varchar(256),
	prog_best_seller char(1) CHECK (prog_best_seller in (0, 1),
	prog_price integer,
	p
									
									
									
	
)