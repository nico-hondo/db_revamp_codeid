-- INSERT MASTER

INSERT INTO master.job_role (joro_name) VALUES
('Pemograman')

INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('1', 'Development', null);
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('2', 'Full Stack', '1');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('3', 'Java Technology', '1');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('4', '.Net Technology', '1');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('5', 'Golang', '1');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('6', 'Mobile Development', null);
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('7', 'Android', '6');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('8', 'Flutter', '6');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('9', 'React Native', '6');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('10', 'Swift', '6');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('11', 'Data Scientist', null);
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('12', 'Hadoop', '11');
INSERT INTO master.category (cate_id, cate_name, cate_cate_id) VALUES ('13', 'Python', '11');

select * from master.category

INSERT INTO master.skill_type (skty_name) VALUES ('java');
INSERT INTO master.skill_type (skty_name) VALUES ('dotnet');
INSERT INTO master.skill_type (skty_name) VALUES ('sql');
INSERT INTO master.skill_type (skty_name) VALUES ('softskill');
INSERT INTO master.skill_type (skty_name) VALUES ('hardskill');
INSERT INTO master.skill_type (skty_name) VALUES ('mini project');
INSERT INTO master.skill_type (skty_name) VALUES ('javascript');
INSERT INTO master.skill_type (skty_name) VALUES ('express.js');
INSERT INTO master.skill_type (skty_name) VALUES ('nodejs');
INSERT INTO master.skill_type (skty_name) VALUES ('springboot');
INSERT INTO master.skill_type (skty_name) VALUES ('Final');
INSERT INTO master.skill_type (skty_name) VALUES ('Presentation');
INSERT INTO master.skill_type (skty_name) VALUES ('Technical');


select * from master.skill_type

INSERT INTO master.modules (module_name) VALUES ('Bootcamp'), ('Job');
INSERT INTO master.modules (module_name) VALUES ('Sales');
INSERT INTO master.modules (module_name) VALUES ('Master'), ('User'),('HR'), ('Course'), ('Payment');


select * from master.modules


INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('1', 'Apply Application', '1', 'Bootcamp', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('2', 'Filtering Test', '2', 'Bootcamp', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('3', 'Contract Legal', '3', 'Bootcamp', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('4', 'Briefing Bootcamp', '4', 'Bootcamp', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('5', 'Join Bootcamp', '5', 'Bootcamp', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('6', 'Get Certified', '6', 'Bootcamp', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('7', 'Placement', '7', 'Bootcamp', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('8', 'Idle', '8', 'Bootcamp', '0');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('9', 'Drop Out', '9', 'Bootcamp', '0');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('10', 'Apply Application', '1', 'Job', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('11', 'Interview', '2', 'Job', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('12', 'Contract Legal', '3', 'Job', '1');
INSERT INTO master.route_actions (roac_id, roac_name, roac_orderby, roac_module_name, roac_display) VALUES ('14', 'Placement', '4', 'Job', '1');

select * from master.route_actions


INSERT INTO master.status (status, status_module) VALUES ('certified', 'User');
INSERT INTO master.status (status, status_module) VALUES ('voluntering', 'User');
INSERT INTO master.status (status, status_module) VALUES ('organization', 'User');
INSERT INTO master.status (status, status_module) VALUES ('reward', 'User');
INSERT INTO master.status (status, status_module) VALUES ('fulltime', 'User');
INSERT INTO master.status (status, status_module) VALUES ('freelance', 'User');
INSERT INTO master.status (status, status_module) VALUES ('bachelor', 'User');
INSERT INTO master.status (status, status_module) VALUES ('diploma', 'User');
INSERT INTO master.status (status, status_module) VALUES ('Male', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Female', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Single', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Married', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Hourly', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Salaried', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Active', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('InActive', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Contract', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Prohibation', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Monthly', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Weekly', 'HR');
INSERT INTO master.status (status, status_module) VALUES ('Bootcamp', 'Course');
INSERT INTO master.status (status, status_module) VALUES ('Course', 'Course');
INSERT INTO master.status (status, status_module) VALUES ('Online', 'Course');
INSERT INTO master.status (status, status_module) VALUES ('Offline', 'Course');
INSERT INTO master.status (status, status_module) VALUES ('English', 'Course');
INSERT INTO master.status (status, status_module) VALUES ('Bahasa', 'Course');
INSERT INTO master.status (status, status_module) VALUES ('Open', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Running', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Close', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Pending', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Extend', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Passed', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Failed', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Resign', 'Bootcamp');
INSERT INTO master.status (status, status_module) VALUES ('Publish', 'Job');
INSERT INTO master.status (status, status_module) VALUES ('Draft', 'Job');
INSERT INTO master.status (status, status_module) VALUES ('Cancel', 'Job');
INSERT INTO master.status (status, status_module) VALUES ('Remove', 'Job');
INSERT INTO master.status (status, status_module) VALUES ('Waiting', 'Job');
INSERT INTO master.status (status, status_module) VALUES ('Done', 'Job');
INSERT INTO master.status (status, status_module) VALUES ('New', 'Sales');
INSERT INTO master.status (status, status_module) VALUES ('Shipping', 'Sales');
INSERT INTO master.status (status, status_module) VALUES ('Cancelled', 'Sales');
INSERT INTO master.status (status, status_module) VALUES ('Refunds', 'Sales');
INSERT INTO master.status (status, status_module) VALUES ('Closed', 'Sales');
INSERT INTO master.status (status, status_module) VALUES ('TopUp', 'Payment');
INSERT INTO master.status (status, status_module) VALUES ('Transfer', 'Payment');
INSERT INTO master.status (status, status_module) VALUES ('PayOrder', 'Payment');
INSERT INTO master.status (status, status_module) VALUES ('Refund', 'Payment');
INSERT INTO master.status (status, status_module) VALUES ('Debit', 'Payment');
INSERT INTO master.status (status, status_module) VALUES ('Credit', 'Payment');
INSERT INTO master.status (status, status_module) VALUES ('Payment', 'Payment');
INSERT INTO master.status (status, status_module) VALUES ('Internal', 'User');
INSERT INTO master.status (status, status_module) VALUES ('External', 'User');
INSERT INTO master.status (status, status_module) VALUES ('Outsource', 'User');

select * from master.status

INSERT INTO master.address_type (adty_id, adty_name) VALUES ('1', 'Home');
INSERT INTO master.address_type (adty_id, adty_name) VALUES ('2', 'Main Office');
INSERT INTO master.address_type (adty_id, adty_name) VALUES ('3', 'Primary');
INSERT INTO master.address_type (adty_id, adty_name) VALUES ('4', 'Shipping');
INSERT INTO master.address_type (adty_id, adty_name) VALUES ('5', 'Billing');
INSERT INTO master.address_type (adty_id, adty_name) VALUES ('6', 'Archive');

select * from master.address_type

INSERT INTO master.country (country_code, country_name) VALUES ('IND', 'Indonesia');

select * from master.country

INSERT INTO master.province (prov_id, prov_name, prov_country_code) VALUES ('1', 'DKI Jakarta', 'IND');
INSERT INTO master.province (prov_id, prov_name, prov_country_code) VALUES ('2', 'Jawa Barat', 'IND');

select * from master.province

INSERT INTO master.city (city_id, city_name, city_prov_id) VALUES ('1', 'Bandung', '2');
INSERT INTO master.city (city_id, city_name, city_prov_id) VALUES ('2', 'Bogor', '2');
INSERT INTO master.city (city_id, city_name, city_prov_id) VALUES ('3', 'Jakarta', '1');

select * from master.city

INSERT INTO master.address (addr_id, addr_line1, addr_line2, addr_postal_code, addr_spatial_location, addr_city_id) VALUES ('1', 'jl. Sambiloto no 20, sumur batu, babakan madang', '-', '56789', '{}', '2');
INSERT INTO master.address (addr_id, addr_line1, addr_line2, addr_postal_code, addr_spatial_location, addr_city_id) VALUES ('2', 'jl. North ridge no 18, sukajaya, babakan madang', '', '67859', '{}', '2');

select * from master.adrress

INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('1', 'Fundamental', 'Minggu pertama kamu akan belajar fundamental c#, mulai dari tipe data, variable, array, condition, iteration dan collection', '1', '1', 'javascript', null);
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('2', 'Data Type', '', '1', '2', 'javascript', '1');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('3', 'Scoping Variable', '', '1', '3', 'javascript', '1');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('4', 'Arrays', '', '1', '4', 'javascript', '1');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('5', 'Control Statement', '', '1', '5', 'javascript', '1');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('6', 'Iteration', '', '1', '6', 'javascript', '1');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('7', 'Collections', '', '1', '7', 'javascript', '1');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('8', 'Quiz', '', '1', '7', 'javascript', '1');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('9', 'Object Oriented Programming', 'OOP wajib kalian kuasain karena OOP akan membantu kita ketika kita develop application yang sangat komplek', '2', '1', 'javascript', null);
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('10', 'Encapsulation', '', '2', '2', 'javascript', '9');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('11', 'Inheritance', '', '2', '3', 'javascript', '9');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('12', 'Abstraction', '', '2', '4', 'javascript', '9');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('13', 'Polymorphism', '', '2', '5', 'javascript', '9');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('14', 'Design Pattern', '', '2', '6', 'javascript', '9');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('15', 'Quiz', '', '2', '2', 'javascript', '9');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('16', 'Database', '', '3', '2', 'javascript', null);
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('17', 'Create Database', '', '3', '3', 'javascript', '16');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('18', 'DDL', '', '3', '4', 'javascript', '16');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('19', 'DML', '', '3', '5', 'javascript', '16');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('20', 'Back End', '', '4', '1', 'javascript', null);
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('21', 'NodeJS', '', '4', '2', 'javascript', '20');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('22', 'RestAPI', '', '4', '3', 'javascript', '20');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('23', 'ORM Sequelize', '', '4', '4', 'javascript', '20');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('24', 'First Project', '', '4', '5', 'javascript', '20');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('25', 'Front End', '', '5', '1', 'javascript', null);
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('26', 'HTML & CSS', '', '5', '2', 'javascript', '25');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('27', 'ReactJS', '', '5', '3', 'javascript', '25');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('28', 'Redux', '', '5', '4', 'javascript', '25');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('29', 'GraphQL', '', '5', '5', 'javascript', '25');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('30', 'Microservices', '', '6', '1', 'javascript', null);
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('31', 'Docker', '', '6', '2', 'javascript', '30');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('32', 'Kubernates', '', '6', '3', 'javascript', '30');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('33', 'Kafka', '', '6', '4', 'javascript', '30');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('34', 'Mini Project', '', '7', '1', 'javascript', null);
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('35', 'Revamp CodeAcademy', '', '7', '2', 'javascript', '34');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('36', 'Back End', '', '8', '3', 'javascript', '34');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('37', 'Front End', '', '9', '4', 'javascript', '34');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('38', 'Presentation', '', '10', '5', 'javascript', '34');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('39', 'Softskill', '', '11', '1', 'softskill', null);
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('40', 'Learning', '', '11', '2', 'softskill', '39');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('41', 'Disicpline', '', '11', '3', 'softskill', '39');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('42', 'Persistence', '', '11', '4', 'softskill', '39');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('43', 'Problem Solving', '', '11', '5', 'softskill', '39');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('44', 'Communication', '', '11', '6', 'softskill', '39');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('45', 'TeamWork', '', '11', '7', 'softskill', '39');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('46', 'Final Evaluation', '', '12', '1', 'Final', null);
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('47', 'Struktur programming language', '', '12', '2', 'Final', '46');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('48', 'Logika', '', '12', '3', 'Final', '46');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('49', 'OOP', '', '12', '4', 'Final', '46');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('50', 'Database', '', '12', '5', 'Final', '46');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('51', 'Webservices', '', '12', '6', 'Final', '46');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('52', 'Microservices', '', '12', '7', 'Final', '46');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('53', 'Tugas Harian', '', '12', '8', 'Final', '46');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('54', 'Presentation', '', '12', '1', 'Presentation', null);
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('55', 'Business Process', '', '12', '2', 'Presentation', '54');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('56', 'Performance', '', '12', '3', 'Presentation', '54');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('57', 'Media Material', '', '12', '4', 'Presentation', '54');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('58', 'Logic & Technical', '', '12', '5', 'Presentation', '54');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('59', 'Knowledge', '', '12', '6', 'Presentation', '54');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('60', 'Technical', '', '12', '1', 'Technical', null);
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('61', 'Fundamental & Logic', '', '12', '2', 'Technical', '60');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('62', 'OOP', '', '12', '3', 'Technical', '60');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('63', 'Database DDL & DDL', '', '12', '4', 'Technical', '60');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('64', 'Project', '', '12', '5', 'Technical', '60');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('65', 'Webservices', '', '12', '6', 'Technical', '60');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('66', 'Microservices', '', '12', '7', 'Technical', '60');
INSERT INTO master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skty_name, skte_skte_id) VALUES ('67', 'Deployment', '', '12', '8', 'Technical', '60');

select * from master.skill

INSERT INTO master.job_type (joty_id, joty_name) VALUES ('1', 'Magang');
INSERT INTO master.job_type (joty_id, joty_name) VALUES ('2', 'Full-Time');
INSERT INTO master.job_type (joty_id, joty_name) VALUES ('3', 'Part-Time');
INSERT INTO master.job_type (joty_id, joty_name) VALUES ('4', 'Freelance');
INSERT INTO master.job_type (joty_id, joty_name) VALUES ('5', 'Contract');
INSERT INTO master.job_type (joty_id, joty_name) VALUES ('6', 'Prohibation');

select * from master.job_type

insert into master.job_role(joro_id, joro_name)
values
(1, 'Software Developer'),
(2, 'Data Engineer'),
(3, 'Java Developer'),
(4, 'QA')

select * from master.job_role