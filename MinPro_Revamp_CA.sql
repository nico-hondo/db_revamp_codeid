-- Module Payment

CREATE SCHEMA IF NOT EXISTS users;

CREATE TABLE IF NOT EXISTS users.business_entity (
	entity_id SERIAL PRIMARY KEY
);
SELECT * FROM users.business_entity;

CREATE TABLE IF NOT EXISTS users.users (
	user_entity_id SERIAL PRIMARY KEY,
	FOREIGN KEY (user_entity_id) REFERENCES users.business_entity (entity_id)
);
SELECT * FROM users.users;

CREATE SCHEMA IF NOT EXISTS payment;

CREATE TABLE payment.bank (
    bank_entity_id INT PRIMARY KEY,
    bank_code VARCHAR(10) UNIQUE,
    bank_name VARCHAR(55) UNIQUE,
    bank_modified_date TIMESTAMP,
    FOREIGN KEY (bank_entity_id) REFERENCES users.business_entity (entity_id)
);
SELECT * FROM payment.bank;

CREATE TABLE payment.fintech (
    fint_entity_id INT PRIMARY KEY,
    fint_code VARCHAR(10) UNIQUE,
    fint_name VARCHAR(55) UNIQUE,
    fint_modified_date TIMESTAMP,
    FOREIGN KEY (fint_entity_id) REFERENCES users.business_entity (entity_id)
);
SELECT * FROM payment.fintech;

CREATE TABLE payment.users_account (
	usac_bank_entity_id INT,
	usac_user_entity_id INT,
	usac_account_number VARCHAR(25) UNIQUE,
	usac_saldo NUMERIC,
	usac_type VARCHAR(15) CHECK (usac_type IN ('debit', 'credit-card', 'payment')),
	usac_start_date TIMESTAMP,
	usac_end_date TIMESTAMP,
	usac_modified_date TIMESTAMP,
	usac_status VARCHAR(15) CHECK (usac_status IN ('active', 'inactive', 'blocked')),
	PRIMARY KEY (usac_bank_entity_id, usac_user_entity_id),
	FOREIGN KEY (usac_bank_entity_id) REFERENCES payment.bank (bank_entity_id) ON DELETE CASCADE,
	FOREIGN KEY (usac_bank_entity_id) REFERENCES payment.fintech (fint_entity_id) ON DELETE CASCADE,
	FOREIGN KEY (usac_user_entity_id) REFERENCES users.users (user_entity_id)
);
SELECT * FROM payment.users_account;

CREATE OR REPLACE FUNCTION set_usac_account_number()
	RETURNS TRIGGER AS $$
BEGIN
	IF (TG_OP = 'INSERT') THEN
		SELECT CASE
			WHEN NEW.usac_bank_entity_id IS NOT NULL THEN bank.bank_code || '-' || bank.bank_name
			WHEN NEW.usac_bank_entity_id IS NULL THEN fintech.fint_code || '-' || fintech.fint_name
			ELSE NULL
		END INTO NEW.usac_account_number
		FROM payment.bank
		LEFT JOIN payment.fintech ON FALSE
		WHERE bank.entity_id = NEW.usac_bank_entity_id;
	END IF;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_set_usac_account_number
	BEFORE INSERT ON payment.users_account
	FOR EACH ROW
	EXECUTE FUNCTION set_usac_account_number();
			
CREATE TABLE payment.transaction_payment (
	trpa_id SERIAL PRIMARY KEY,
	trpa_code_number VARCHAR(55) UNIQUE,
	trpa_order_number VARCHAR(25),
	trpa_debit NUMERIC,
	trpa_credit NUMERIC,
	trpa_type VARCHAR(15) CHECK (trpa_type IN ('top-up', 'transfer', 'order', 'refund')),
	trpa_note VARCHAR(255),
	trpa_modified_date TIMESTAMP,
	trpa_source_id VARCHAR(25) NOT NULL,
	trpa_target_id VARCHAR(25) NOT NULL,
	trpa_user_entity_id INT,
	FOREIGN KEY (trpa_user_entity_id) REFERENCES users.users (user_entity_id)
);
SELECT * FROM payment.transaction_payment;

CREATE SEQUENCE trpa_code_number_seq;

CREATE OR REPLACE FUNCTION set_trpa_code_number()
	RETURNS TRIGGER AS $$
BEGIN
	IF (TG_OP = 'INSERT') THEN
		NEW.trpa_code_number := 'TR-' || to_char(current_date, 'YYYYMMDD') || LPAD(NEXTVAL('trpa_code_number_seq')::TEXT, 5, 'O');
		
		SELECT usac_account_number INTO NEW.trpa_source_id
		FROM users_account
		WHERE usac_user_entity_id = NEW.trpa_user_entity_id;
		
		SELECT usac_account_number INTO NEW.trpa_target_id
		FROM users_account
		WHERE usac_user_entity_id = NEW.trpa_user_entity_id;
		
		SELECT user_entity_id INTO NEW.trpa_user_entity_id
		FROM users
		WHERE user_entity_id = NEW.trpa_user_entity_id;
	END IF;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_set_trpa_code_and_ids
	BEFORE INSERT ON payment.transaction_payment
	FOR EACH ROW
	EXECUTE FUNCTION set_trpa_code_number();