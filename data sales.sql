INSERT INTO sales_order_detail (sode_id, sode_qty, sode_unit_price, sode_unit_discount,sode_line_total,sode_modified_date,sode_sohe_id,sode_prog_entity_id)
VALUES (1, 1, 100000, 50%, 50000, '2023-01-01', 1, 1);
       
INSERT INTO sales_order_header (sohe_id, sohe_order_date, sohe_due_date, sohe_ship_date,sohe_order_number,sohe_account_number,sohe_subtotal, sohe_tax, sohe_total_due, sohe_status)
VALUES (1, '2022-06-22', '2022-06-30',  '2022-06-28', 'ORD#20220727-0000001', 131899555, 0, 50000, Closed);

INSERT INTO cart_items (cait_id_id, cait_quantity, cait_user_entity_id, cait_prog_entity_id)
VALUES (1, 1, 3, 1),
       (2, 1, 3, 3);

INSERT INTO special_offer (spof_id, spof_description, spof_discount, spof_start_date,spof_end_date,spof_min_qty,spof_max_qty, spof_cate_id)
VALUES (1, 'Dapatkan discount 50%, untuk 5 orang', 50% ,  '27-Oct-22', '27-Jul-22', 1, 5, 1);

INSERT INTO special_offer_programs (soco_spof_id, soco_prog_entity_id )
VALUES (1, 1),
       (1, 3);

