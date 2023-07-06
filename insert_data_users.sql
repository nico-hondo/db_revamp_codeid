INSERT INTO users.business_entity 
VALUES 
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9)

INSERT INTO users.roles (role_id, role_name, role_type)
VALUES 
(1, "Candidat", "External"),
(2, "Candidat", "External"),
(3, "Recruiter", "Internal"),
(4, "Instructor", "Internal"),
(5, "Sales", "Internal"),
(6, "Manager", "Internal"),
(7, "Vice President", "Internal"),
(8, "Account Manager", "Internal"),
(9, "Student", "External"),
(10, "Administrator", "Internal"),
(11, "Outsource", "Internal"),
(12, "Employee", "Internal")

INSERT INTO users.users (user_entity_id, user_name, user_password, user_first_name, user_last_name, user_email_promotion, user_demographic, user_modified_date, user_photo, user_current_role)
VALUES
(1, "kangdian", "yadfaldjfapdjf;ajfpasdf", "kang", "dian", 1, "{latitude:12.90,longitude:-99.989}", 2022-07-12, "photo.png", 4),
(2, "nofal", "ajdfja;dfpadjfadf", "nofal", "firdaus", 0, "{latitude:12.90,longitude:-99.989}", 2022-07-12, "nofal.png", 4),
(3, "abdul101", "ajdfja;dfpadjfadf", "Abdul", "Razaq", 1, "{latitude:12.90,longitude:-99.989}", 2022-07-12, "abdul.png", 1),
(4, "ratih", "yadlfjadjfa", "ratih wina", "ludwig", 0, "{latitude:12.90,longitude:-99.989}", 2022-07-12, "ratih.png", 11),
(5, "Eka", "ynyaldjf;adfadfad;faldfsa", "Eka", "Nugroho", 0, "{latitude:12.90,longitude:-99.989}", 2022-07-12, "eka.png", 8),
(6, "novia", "lajdfljaljdfajdf;a", "novia", "slebew", 1, "{latitude:12.90,longitude:-99.989}", 2022-07-12, "novia.png", 9),
(7, "novelina", "lkadjfajdf;adf", "novelina", "lina", 0, "{latitude:12.90,longitude:-99.989}", 2022-07-12, "lina.png", 3),
(8, "yugo", "aldjfadfa;dfjlajdf;a", "yugo", "ardan", 1, "{latitude:12.90,longitude:-99.989}", 2022-07-12, "yugo.png", 1),
(9, "andhika", "ladfljafjadfas;f", "andhika", "pratama", 1, "{latitude:12.90,longitude:-99.989}", 2022-07-12, "andhika.png", 2)

INSERT INTO users.users_role (usro_entity_id, usro_role_id, usro_modified_date)
VALUES
(1, 1, '2022-07-12'),
(2, 1, '2022-07-12'),
(3, 3, '2022-07-12'),
(4, 5, '2022-07-12')


INSERT INTO users.phone_number_type (ponty_code, ponty_modified_date)
VALUES
("Home", '2022-07-12'),
("Cell", '2022-07-12')

INSERT INTO users.users_phones (uspo_entity_id, uspo_number, uspo_ponty_code)
VALUES
(1, 8139809091, "Cell"),
(1, 022-7890987, "Home"),
(2, 089898989, "Cell")

INSERT INTO users.users_address (etad_addr_id, etad_entity_id, etad_adty_id)
VALUES
(1, 1, 1),
(2, 2, 2)

INSERT INTO users.users_email (pmail_id, pmail_entity_id, pmail_address)
VALUES 
(1, 1, "dian@code.id"),
(2, 1, "dian@gmail.com"),
(3, 2, "nofal@code.id")

INSERT INTO users.users_media (usme_id, usme_entity_id, usme_file_link, usme_filename, usme_filesize, usme_filetype, usme_note)
VALUES
(1, 1, "https://", "ijazah.png", 2345, "png", "ijazah"),
(2, 1, "https://", "cv.docx", 1890, "word", "cv")

INSERT INTO users.users_education (usdu_id, usdu_entity_id, usdu_school, usdu_degree, usdu_field_study, usdu_start_date, usdu_end_date, usdu_grade, usdu_activities)
VALUES
(1, 1, "MIT", "Bachelor", "Informatic", '2000-07-12', '2005-08-12', 3.45, "i'm bachelor with cumlaude")

INSERT INTO users.users_experiences (usex_id, usex_entity_id, usex_title, usex_profile_headline, usex_employment_type, usex_company_name, usex_is_current, usex_start_date, usex_end_date, usex_industry, usex_description, usex_experience_type, usex_city_id)
VALUES
(1, 1, "Head Of Bootcamp","Software Engineer", "Fulltime", "Code.id", 1, '2019-07-12', '2020-07-12', "Consultant IT", "i bleieve...", "Company", 1),
(1, 1, "Motivator","Act of Volunteer", "Freelance", "Government", 0, '2019-07-12', '2020-07-12', "Government", "Helping people to Learn", "Volunteer", 1)

INSERT INTO users.users_experiences_skill (uesk_usex_id, uesk_uski_id)
VALUES
(1, 1),
(1, 2),
(1, 3)

INSERT INTO users.users_skill (uski_id, uski_entity_id, uski_skty_name)
VALUES
(1, 1, "java"),
(2, 1, "dotnet"),
(3, 2, "javascript")

