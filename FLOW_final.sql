-- REGISTRATION 

-- 1)Person registers as CUSTOMER
INSERT INTO user_table
    (company_id, first_name, last_name, email, phone, user_address, role)
VALUES
    (1, 'New', 'Customer', 'new.customer@example.com',
     '555-123-4567', '10 Main St, Yerevan', 'customer')
RETURNING user_id;

INSERT INTO customer (user_id, membership_level, shipping_address)
VALUES (21, 'Bronze', '10 Main St, Yerevan');

-- 2) Person registers as a SELLER
INSERT INTO user_table
    (company_id, first_name, last_name, email, phone, user_address, role)
VALUES
    (1, 'New', 'Seller', 'new.seller@example.com',
     '555-234-5678', '25 Market St, Yerevan', 'seller')
RETURNING user_id;

INSERT INTO seller (user_id, seller_company_name, total_sales)
VALUES (22, 'New Seller LLC', 0);

-- 3) EMPLOYEE is registered by IT department
INSERT INTO user_table
    (company_id, first_name, last_name, email, phone, user_address, role)
VALUES
    (1, 'New', 'Employee', 'new.employee@example.com',
     '555-345-6789', '99 Office St, Yerevan', 'employee')
RETURNING user_id;

INSERT INTO employee
    (user_id, department, position_title, supervisor_id, hire_date, work_shift, salary)
VALUES
    (23, 'Support', 'Customer Support Agent', 3, CURRENT_DATE, 'Day', 45000);


-- ADD PRODUCTS in marketplace

-- 1) Seller ADD products
INSERT INTO product
    (user_id, category_id, product_name, product_description,
     product_price, product_status, product_brand)
VALUES
    (22, 1,
     'Gaming Headset',
     'Over-ear headset with microphone and RGB lights',
     79.99,
     'HyperSound')
RETURNING product_id;

--2) Employee validates the product 

UPDATE product
SET product_status = 'active'
WHERE product_id = 22;
-- BROWSING PRODUCTS

-- 1) All products that customer will see when during browsing website
SELECT
    p.product_id,
    p.product_name,
    p.product_price,
    p.product_brand,
    c.category_title,
    s.seller_company_name
FROM product p
JOIN category c ON c.category_id = p.category_id
JOIN seller s   ON s.user_id = p.user_id
WHERE p.product_status = 'active'
ORDER BY c.category_title, p.product_name;

-- 2)Browse products inside one category

SELECT
    p.product_id,
    p.product_name,
    p.product_price,
    p.product_brand,
    s.seller_company_name
FROM product p
JOIN category c ON c.category_id = p.category_id
JOIN seller   s ON s.user_id = p.user_id
WHERE p.product_status = 'active'
  AND c.category_title = 'Electronics'
ORDER BY p.product_name;

-- 3) Searching by name and price 
SELECT product_id, product_name, product_price
FROM product
WHERE product_status = 'active'
  AND product_name ILIKE '%phone%'
  AND product_price BETWEEN 100 AND 800
ORDER BY product_price;

-- 4) Search inside category (by keyword + price range)
SELECT
    p.product_id,
    p.product_name,
    p.product_price,
    p.product_brand,
    c.category_title
FROM product p
JOIN category c ON c.category_id = p.category_id
WHERE p.product_status = 'active'
  AND c.category_title = 'Electronics'
  AND p.product_name ILIKE '%mouse%'
  AND p.product_price BETWEEN 20 AND 80
ORDER BY p.product_price;

-- CUSTOMER PLACE ORDER

--1) creating order with various items
INSERT INTO order_table (customer_id)
VALUES (1)
RETURNING order_id;

INSERT INTO order_item
    (order_item_id, order_id, product_id, quantity, unit_price)
VALUES
    (1, 8, 1, 1, 699.99),  -- Smartphone
    (2, 8, 5, 1, 129.99);  -- Wireless Earbuds
	
-- 2) Show order details + total amount to pay 
SELECT
    o.order_id,
    u.first_name || ' ' || u.last_name AS customer_name,
    oi.order_item_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.subtotal,
    SUM(oi.subtotal) OVER (PARTITION BY o.order_id) AS order_total
FROM order_table o
JOIN customer c   ON c.user_id = o.customer_id
JOIN user_table u ON u.user_id = c.user_id
JOIN order_item oi ON oi.order_id = o.order_id
JOIN product p   ON p.product_id = oi.product_id
WHERE o.order_id = 8
ORDER BY oi.order_item_id;

-- PAYMENT FLOW

-- 1)create transaction and make a payment record after successfully 
INSERT INTO payment_transaction (transaction_id, order_id, payment_method)
VALUES ('TXN008', 8, 'Credit Card');

INSERT INTO payment
    (transaction_id, payment_status, amount)
VALUES
    ('TXN008', 'paid', 829.98);

-- 2)Check payment status for an order

SELECT
    o.order_id,
    pt.transaction_id,
    pt.payment_method,
    pmt.payment_status,
    pmt.amount,
    pmt.payment_date
FROM order_table o
JOIN payment_transaction pt ON pt.order_id = o.order_id
JOIN payment pmt            ON pmt.transaction_id = pt.transaction_id
WHERE o.order_id = 8;

-- REVIEW FLOW

-- 1) Customer leaves a review
INSERT INTO review
    (order_id, order_item_id, user_id, review_rating, comment, title)
VALUES
    (8, 1, 1, 4.5,
     'Phone is fast and display is bright.',
     'Great smartphone!');
	 
-- 2) Browsing all reviews for a product
SELECT
    r.review_id,
    r.review_rating,
    r.comment,
    r.created_at,
    u.first_name || ' ' || u.last_name AS customer_name
FROM review r
JOIN customer c   ON c.user_id = r.user_id
JOIN user_table u ON u.user_id = c.user_id
JOIN order_item oi ON oi.order_id = r.order_id
                  AND oi.order_item_id = r.order_item_id
WHERE oi.product_id = 1
ORDER BY r.created_at DESC;

-- REFUND FLOW

-- 1)Customer creates a return request
INSERT INTO return_request (order_id, order_item_id, request_status, reason)
VALUES (8, 1, 'pending', 'Screen has dead pixels')
RETURNING return_request_id;

-- 2) List all pending returns with product and customer:
SELECT
    rr.return_request_id,
    rr.requested_at,
    rr.reason,
    rr.request_status,
    p.product_name,
    u.first_name || ' ' || u.last_name AS customer_name
FROM return_request rr
JOIN order_item oi ON oi.order_id = rr.order_id
                  AND oi.order_item_id = rr.order_item_id
JOIN product p    ON p.product_id = oi.product_id
JOIN order_table o ON o.order_id = rr.order_id
JOIN customer c    ON c.user_id = o.customer_id
JOIN user_table u  ON u.user_id = c.user_id
WHERE rr.request_status = 'pending'
ORDER BY rr.requested_at;

-- 3) Employee accept refund
UPDATE return_request
SET request_status = 'accepted'
WHERE return_request_id = 4;

INSERT INTO refund (return_request_id, amount, reason)
VALUES (4, 699.99, 'Full refund for defective product');

-- 4) Employee rejected refund
UPDATE return_request
SET request_status = 'rejected'
WHERE return_request_id = 4;

--WAREHOUSE FLOW

-- 1) Employee assign WH to the order (e.g. nearest warehouse)
UPDATE order_table
SET warehouse_id = 1
WHERE order_id = 8;

-- 2) Choose carrier responsible for this order
INSERT INTO carrier
    (warehouse_id, first_name, last_name, phone, email,
     truck_number, delivered_at, delivery_status)
VALUES
    (1, 'Karen', 'Sargsyan', '555-6000',
     'karen@delivery.com', 'AM-777',
     NULL, 'Awaiting Pickup')
RETURNING carrier_id;

--3) Update carrier_id in order
UPDATE order_table
SET carrier_id = 5
WHERE order_id = 8;

--4) reduce stock in warehouse 
UPDATE warehouse w
SET stock_amount = w.stock_amount - sub.total_qty
FROM (
    SELECT SUM(quantity) AS total_qty
    FROM order_item
    WHERE order_id = 8
) sub
WHERE w.warehouse_id = 1;

--DELIVERY FLOW

-- 1) Order packed, waiting pickup
UPDATE carrier
SET delivery_status = 'In Warehouse'
WHERE carrier_id = 5;

-- 2) Courier left warehouse
UPDATE carrier
SET delivery_status = 'On the Way'
WHERE carrier_id = 5;

-- 3) Order delivered to customer
UPDATE carrier
SET delivery_status = 'Delivered',
    delivered_at    = CURRENT_TIMESTAMP
WHERE carrier_id = 5;

-- 4) Delivery status + warehouse info for recent orders
SELECT
    o.order_id,
    o.order_date,
    w.warehouse_name,
    c.first_name || ' ' || c.last_name AS carrier_name,
    c.truck_number,
    c.delivery_status,
    c.delivered_at
FROM order_table o
LEFT JOIN warehouse w ON w.warehouse_id = o.warehouse_id
LEFT JOIN carrier   c ON c.carrier_id   = o.carrier_id
ORDER BY o.order_date DESC
LIMIT 20;