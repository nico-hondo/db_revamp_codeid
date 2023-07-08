INSERT INTO users.business_entity (entity_id) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9);
SELECT * FROM users.business_entity;

INSERT INTO users.users (user_entity_id) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9);
SELECT * FROM users.users;

INSERT INTO payment.bank (bank_entity_id, bank_code, bank_name) VALUES
(6, 'BCA', 'Bank Central Asia'),
(7, 'BNI', 'Bank Negara Indonesia'),
(8, 'MAN', 'Bank Mandiri'),
(9, 'JAGO', 'Bank Jago');
SELECT * FROM payment.bank;

INSERT INTO payment.fintech (fint_entity_id, fint_code, fint_name) VALUES
(7, 'GOTO', 'Payment GoTo'),
(8, 'OVO', 'OVO'),
(9, 'SP', 'Shopee Paylater');
SELECT * FROM payment.fintech;

INSERT INTO payment.users_account (usac_bank_entity_id, usac_user_entity_id, usac_account_number, usac_saldo, usac_type, usac_status) VALUES
(8, 3, 131899555, 100000, 'debit', 'active'),
(9, 3, 087654321, 50000, 'payment', 'inactive');
SELECT * FROM payment.users_account;

INSERT INTO payment.transaction_payment (trpa_id, trpa_code_number, trpa_order_number, trpa_debit, trpa_credit, trpa_type, trpa_note, trpa_modified_date, trpa_source_id, trpa_target_id, trpa_user_entity_id) VALUES
(1, 20220727#000001, null, 0,	50000, 'top-up', 'topup bank ke goto', null, 131899555, 087654321, 3),	
(2,	20220727#000002, null, 50000,	0, 'top-up', 'receive topup', null, 087654321, 131899555, 3),
(3,	20220727#000003, null, null, 10000, 'order', 'bayar shoppe order', null, 131899555, 99999, 3);
SELECT * FROM payment.transaction_payment;
