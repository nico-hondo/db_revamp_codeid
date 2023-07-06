-- Insert data into program_apply table
INSERT INTO bootcamp.program_apply (prap_user_entity_id, prap_prog_entity_id, prap_test_score, prap_gpa, prap_iq_test, prap_review, prap_modified_date, prap_status) 
VALUES 
(2, 3, 75, NULL, 88, 'Personality ok, antusias, komunikasi bagus', '2023-07-06', 'recommended'),
(2, 8, 88, NULL, 88, 'Nice', '2023-07-06', 'passed');

select * from bootcamp.program_apply

-- Insert data into program_apply_progress table
INSERT INTO bootcamp.program_apply_progress (parog_id, parog_user_entity_id, parog_prog_entity_id, parog_action_date, parog_modified_date, parog_comment, parog_progress_name, parog_emp_entity_id, parog_status) 
VALUES 
(1, 2, 3, '2023-07-06', '2023-07-06', NULL, 'done', NULL, NULL),
(2, 2, 3, '2023-07-06', '2023-07-06', NULL, 'done', NULL, NULL),
(3, 2, 3, '2023-07-06', '2023-07-06', NULL, 'done', NULL, NULL),
(4, 2, 3, '2023-07-06', '2023-07-06', NULL, 'done', NULL, NULL),
(5, 2, 3, '2023-07-06', '2023-07-06', 'join bootcamp available di minggu ke 2 dari jadwal', 'done', NULL, NULL),
(6, 2, 3, '2023-07-06', '2023-07-06', NULL, 'done', NULL, NULL),
(7, 2, 3, '2023-07-06', '2023-07-06', NULL, 'done', NULL, NULL);

select * from bootcamp.program_apply_progress 

-- Insert data into batch table
INSERT INTO bootcamp.batch (batch_id, batch_entity_id, batch_name, batch_description, batch_start_date, batch_end_date, batch_reason, batch_type, batch_modified_date, batch_status, batch_pic_id) 
VALUES 
(1, 2, 'Batch#15', NULL, '2022-08-12', '2022-10-12', NULL, 'offline', '2023-07-06', 'New', NULL);

select * from bootcamp.batch

-- Insert data into batch_trainee table
INSERT INTO bootcamp.batch_trainee (batr_id, batr_status, batr_certificated, batre_certificate_link, batr_access_token, batr_access_grant, batr_review, batr_total_score, batr_modified_date, batr_trainee_entity_id, batr_batch_id)
VALUES 
(1, 'running', '0', NULL, NULL, '0', 'selama bootcamp ok nice', 88, '2023-07-06', 3, 1),
(2, 'running', '0', NULL, NULL, '0', 'selama bootcamp ok nice', 86, '2023-07-06', 8, 1);

select * from bootcamp.batch_trainee

-- Insert data into batch_trainee_evaluation table
INSERT INTO bootcamp.batch_trainee_evaluation (btev_id, btev_type, btev_header, btev_section, btev_skill, btev_week, btev_skor, btev_note, btev_modified_date, btev_batch_id, btev_trainee_entity_id)
VALUES 
(1, 'Technical', 'Fundamental', NULL, 'Database', 1, 4, NULL, '2023-07-06', 1, 3),
(2, 'Technical', 'Fundamental', NULL, 'Database', 2, 4, NULL, '2023-07-06', 1, 3),
(3, 'Technical', 'Fundamental', NULL, 'OOP', 3, 3, NULL, '2023-07-06', 1, 3),
(4, 'Softskill', NULL, NULL, 'Dicipline', 4, 4, NULL, '2023-07-06', 1, 3);

select * from bootcamp.batch_trainee_evaluation 

-- Insert data into instructor_programs table
INSERT INTO bootcamp.instructor_programs (batch_id, inpro_entity_id, inpro_emp_entity_id, inpro_modified_date) 
VALUES 
(1, 2, NULL, '2023-07-06'),
(1, 2, NULL, '2023-07-06');

select * from bootcamp.instructor_programs
