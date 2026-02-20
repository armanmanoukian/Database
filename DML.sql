INSERT INTO company (company_name, email, phone, street, building, city, zip_code)
VALUES
('Team7GlobalProblem', 'info@arman-global.com', '555-9090',
 '25 Innovation St', 'Bldg A', 'Yerevan', '0001');

INSERT INTO category (category_title)
VALUES
('Electronics'),
('Clothing'),
('Home Appliances'),
('Books'),
('Sports & Outdoors'),
('Beauty & Personal Care'),
('Toys & Games'),
('Automotive'),
('Health & Wellness'),
('Furniture'),
('Office Supplies'),
('Jewelry & Accessories'),
('Pet Supplies'),
('Garden & Outdoor');

INSERT INTO user_table
    (company_id, first_name, last_name, email, password, phone, user_address, role)
VALUES
(1, 'Ethan',   'Walker',   'ethan.walker@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-111-2222', '12 Maple Ave, Boston',          'customer'),

(1, 'Fiona',   'Carter',   'fiona.carter@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-222-3333', '78 Cedar Rd, Seattle',          'seller'),

(1, 'George',  'Harris',   'george.harris@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-333-4444', '34 Willow St, Denver',          'employee'),

(1, 'Hannah',  'Miller',   'hannah.miller@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-444-5555', '56 Birch Blvd, Phoenix',        'customer'),

(1, 'Ian',     'Turner',   'ian.turner@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-555-6666', '98 Aspen Ln, Dallas',           'seller'),

(1, 'Julia',   'Clark',    'julia.clark@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-666-7777', '21 Walnut Dr, San Diego',       'employee'),

(1, 'Kevin',   'Moore',    'kevin.moore@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-777-8888', '11 Chestnut St, Houston',       'customer'),

(1, 'Laura',   'Adams',    'laura.adams@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-888-9999', '85 Poplar Ave, Atlanta',        'seller'),

(1, 'Mike',    'Bennett',  'mike.bennett@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-999-0000', '142 Redwood St, Portland',      'employee'),

(1, 'Nina',    'Ross',     'nina.ross@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-000-1111', '63 Spruce Way, Las Vegas',      'customer'),

(1, 'Oscar',   'Hill',     'oscar.hill@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-101-2020', '77 Cypress Rd, San Jose',       'seller'),

(1, 'Paula',   'Green',    'paula.green@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-202-3030', '91 Palm St, Orlando',           'employee'),

(1, 'Quentin', 'Ward',     'quentin.ward@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-303-4040', '25 Magnolia Ln, Charlotte',     'customer'),

(1, 'Rachel',  'King',     'rachel.king@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-404-5050', '52 Olive St, Austin',           'seller'),

(1, 'Samuel',  'Lopez',    'samuel.lopez@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-505-6060', '39 Bay Ave, San Francisco',     'employee'),

(1, 'Tina',    'Rivera',   'tina.rivera@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-606-7070', '68 Sycamore St, Detroit',       'customer'),

(1, 'Umar',    'Diaz',     'umar.diaz@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-707-8080', '73 Redwood Dr, Columbus',       'seller'),

(1, 'Vera',    'Mitchell', 'vera.mitchell@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-808-9090', '105 Hawthorn St, Minneapolis',  'employee'),

(1, 'Will',    'Anderson', 'will.anderson@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-909-0101', '59 Linden Ave, Pittsburgh',     'customer'),

(1, 'Xena',    'Price',    'xena.price@example.com',
 '2a240382d880c23e1ab512698165769d29033ff7ef315fda55b3ab2e4f0aa1d0',
 '555-010-1212', '83 Fir St, New Orleans',        'seller');

INSERT INTO customer (user_id, membership_level, shipping_address)
VALUES
(1,  'Gold',   '12 Maple Ave, Boston'),
(4,  'Silver', '56 Birch Blvd, Phoenix'),
(7,  'Bronze', '11 Chestnut St, Houston'),
(10, 'Gold',   '63 Spruce Way, Las Vegas'),
(13, 'Silver', '25 Magnolia Ln, Charlotte'),
(16, 'Gold',   '68 Sycamore St, Detroit'),
(19, 'Silver', '59 Linden Ave, Pittsburgh');

INSERT INTO seller (user_id, seller_company_name, total_sales)
VALUES
(2,  'Carter Goods',    180000.00),
(5,  'Turner Market',   220000.00),
(8,  'Adams Boutique',  305000.00),
(11, 'Hill Traders',    157000.00),
(14, 'Price Electronics',276000.00),
(17, 'Diaz Supplies',   199500.00),
(20, 'ForestLine LLC',  133000.00);

INSERT INTO employee (user_id, department, position_title, supervisor_id, hire_date, work_shift, salary)
VALUES
(3,  'Manager',      'General Manager',         NULL, '2020-01-01', 'Morning', 80000),
(6,  'IT',           'Junior Developer',        3,    '2021-04-20', 'Day',     52000),
(9,  'Logistics',    'Logistics Assistant',     3,    '2022-09-18', 'Evening', 47000),
(12, 'Quality Assur','QA Officer',             3,    '2021-12-01', 'Night',   54000),
(15, 'Procurement',  'Procurement Specialist', 3,    '2019-05-14', 'Morning', 62000),
(18, 'Marketing',    'Marketing Coordinator',  3,    '2020-10-30', 'Day',     51000);

INSERT INTO product
    (user_id, category_id, product_name, product_description,
     product_price, product_status, product_brand)
VALUES
(2,  1,  'Smartphone',        'Android smartphone with 6GB RAM',                   699.99, 'active',   'Samsung'),
(5,  1,  'Laptop',            '15-inch laptop with Intel i7',                      999.99, 'active',   'Dell'),
(8,  2,  'T-Shirt',           '100% cotton white t-shirt',                         19.99,  'active',   'Hanes'),
(11, 4,  'Novel',             'Bestselling mystery novel',                         14.99,  'inactive', 'Penguin'),
(14, 1,  'Wireless Earbuds',  'Bluetooth earbuds with noise cancellation',         129.99, 'active',   'Sony'),
(17, 1,  '4K TV',             '55-inch Ultra HD Smart TV',                         749.99, 'active',   'LG'),
(20, 2,  'Jeans',             'Slim-fit denim jeans',                              49.99,  'active',   'Levi’s'),
(14, 3,  'Microwave Oven',    '800W microwave oven with grill',                    119.99, 'active',   'Panasonic'),
(8,  5,  'Yoga Mat',          'Non-slip yoga mat 10mm thick',                      29.99,  'active',   'Gaiam'),
(20, 6,  'Face Cream',        'Moisturizing cream for dry skin',                   24.99,  'active',   'Neutrogena'),
(2,  7,  'LEGO Set',          '450-piece building block set',                      39.99,  'active',   'LEGO'),
(11, 8,  'Car Vacuum Cleaner','Portable mini vacuum for cars',                     59.99,  'active',   'Black+Decker'),
(8, 10, 'Office Chair',       'Ergonomic office chair with lumbar support',        199.99, 'inactive', 'Herman Miller'),
(20,12, 'Gold Necklace',      '18k gold-plated pendant necklace',                  89.99,  'active',   'Zara Jewelry');

INSERT INTO warehouse
    (company_id, warehouse_name, street, city, zip_code, stock_amount)
VALUES
(1,'Central Hub','120 Logistics Ave','Yerevan','0012',50),
(1,'North Facility','45 Industrial Park Rd','Gyumri','3101',30),
(1,'South Warehouse','89 Cargo Blvd','Vanadzor','2005',25),
(1,'East Center','33 Warehouse St','Abovyan','2201',40),
(1,'West Depot','77 Supply Ln','Hrazdan','2303',20);

INSERT INTO carrier
    (warehouse_id, first_name, last_name, phone, email, truck_number, delivered_at, delivery_status)
VALUES
(1,'Alex','Morgan','555-2001','alex@ags.com','TX-120','2025-11-08','Awaiting Pickup'),
(2,'Laura','Fields','555-2002','laura@ags.com','TX-121','2025-11-09','In Warehouse'),
(3,'James','Parker','555-2003','james@ags.com','TX-122','2025-11-10','On the Way'),
(4,'Olivia','Reed','555-2004','olivia@ags.com','TX-123','2025-11-11','Delivered'),
(5,'Robert','Stone','555-2005','robert@ags.com','TX-124','2025-11-12','Delivered');

INSERT INTO order_table (customer_id, order_date)
VALUES
(1,  '2025-10-02'),
(4,  '2025-10-03'),
(7,  '2025-10-04'),
(10, '2025-10-05'),
(13, '2025-10-06'),
(16, '2025-10-07'),
(19, '2025-10-08');

INSERT INTO order_item
    (order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 1,  1,  1, 699.99),  -- Smartphone
(2, 2,  4,  2, 14.99),   -- Novel
(3, 3,  7,  1, 49.99),   -- Jeans
(4, 4, 10,  3, 24.99),   -- Face Cream
(5, 5, 11,  1, 39.99),   -- LEGO Set
(6, 6, 13,  2, 199.99),  -- Office Chair
(7, 7, 14,  1, 89.99);   -- Gold Necklace

INSERT INTO return_request
    (order_id, order_item_id, request_status, reason)
VALUES
(1, 1, 'accepted', 'Item damaged during shipping'),
(2, 2, 'pending',  'Missing accessories'),
(3, 3, 'rejected', 'Non-returnable product');

INSERT INTO refund (return_request_id, amount, reason)
VALUES
(1, 699.99, 'Refund for damaged item'),
(2, 14.99,  'Refund for missing accessories'),
(3, 0.00,   'No refund — non-returnable');

INSERT INTO payment_transaction (transaction_id, order_id, payment_method)
VALUES
('TXN001', 1, 'Credit Card'),
('TXN002', 2, 'PayPal'),
('TXN003', 3, 'Bank Transfer'),
('TXN004', 4, 'Credit Card');

INSERT INTO payment (transaction_id, payment_date, payment_status, amount)
VALUES
('TXN001', CURRENT_TIMESTAMP, 'paid',    699.99),
('TXN002', CURRENT_TIMESTAMP, 'pending',  29.98),
('TXN003', CURRENT_TIMESTAMP, 'paid',     49.99),
('TXN004', CURRENT_TIMESTAMP, 'paid',     74.97);

INSERT INTO review
    (order_id, order_item_id, user_id, review_rating, comment, title)
VALUES
(1, 1,  1,  4.5, 'Great smartphone, very responsive.', 'Amazing phone'),
(2, 2,  4,  3.5, 'Novel was interesting.',              'Good read'),
(3, 3,  7,  4.0, 'Jeans fit well.',                     'Nice jeans'),
(4, 4, 10,  4.0, 'Face cream works well.',              'Good product');
