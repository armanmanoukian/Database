-- Drop existing tables if needed (to avoid conflicts)
DROP TABLE IF EXISTS refund, return_request, payment_transaction, payment, order_item, order_table,
                     review, product, category, customer, seller, employee, user_table,
                     warehouse, carrier, company
CASCADE;

-- Table creations
CREATE TABLE company (
    company_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    company_name VARCHAR(150) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(30),
    street VARCHAR(150),
    building VARCHAR(100),
    city VARCHAR(100),
    zip_code VARCHAR(20)
);

CREATE TABLE user_table (
    user_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    company_id INT REFERENCES company(company_id) ON DELETE SET NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
	password   VARCHAR(255) NOT NULL,
    phone VARCHAR(30),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_address TEXT,
    role VARCHAR(20) NOT NULL
        CHECK (role IN ('customer', 'seller', 'employee'))
);

CREATE TABLE customer (
    user_id INT PRIMARY KEY
        REFERENCES user_table(user_id) ON DELETE CASCADE,
	membership_level VARCHAR(50) NOT NULL
        CHECK (membership_level IN ('Bronze', 'Silver', 'Gold')),
    shipping_address TEXT
);

CREATE TABLE seller (
    user_id INT PRIMARY KEY
        REFERENCES user_table(user_id) ON DELETE CASCADE,
    seller_company_name VARCHAR(100),
    total_sales NUMERIC(12,2) DEFAULT 0
);

CREATE TABLE employee (
    user_id INT PRIMARY KEY
        REFERENCES user_table(user_id) ON DELETE CASCADE,
    department VARCHAR(100),
    position_title VARCHAR(100),
    supervisor_id INT
        REFERENCES employee(user_id) ON DELETE SET NULL,
    hire_date DATE,
    work_shift VARCHAR(50),
    salary NUMERIC(10,2)
);

CREATE TABLE category (
    category_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_title VARCHAR(100) NOT NULL
);

CREATE TABLE product (
    product_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT REFERENCES seller(user_id) ON DELETE SET NULL, -- only sellers
    category_id INT REFERENCES category(category_id) ON DELETE SET NULL,
    product_name VARCHAR(150) NOT NULL,
    product_description TEXT,
    product_price NUMERIC(10,2) NOT NULL CHECK (product_price >= 0),
    product_status VARCHAR(50) DEFAULT 'inactive'
        CHECK (product_status IN ('active', 'inactive')), 
    product_brand VARCHAR(100)
);

CREATE TABLE warehouse (
    warehouse_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    company_id INT REFERENCES company(company_id) ON DELETE SET NULL,
    warehouse_name VARCHAR(100) NOT NULL,
    street VARCHAR(150),
    city VARCHAR(100),
    zip_code VARCHAR(20),
    stock_amount INT CHECK (stock_amount >= 0)
);

CREATE TABLE carrier (
    carrier_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    warehouse_id INT REFERENCES warehouse(warehouse_id) ON DELETE SET NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(30),
    email VARCHAR(100),
    truck_number VARCHAR(150),
    delivered_at TIMESTAMP,
    delivery_status VARCHAR(50)
        CHECK (delivery_status IN ('Awaiting Pickup', 'In Warehouse', 'On the Way', 'Delivered'))
);

CREATE TABLE order_table (
    order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL
        REFERENCES customer(user_id) ON DELETE RESTRICT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	carrier_id INT REFERENCES carrier (carrier_id),
	warehouse_id INT REFERENCES warehouse(warehouse_id)
);

CREATE TABLE order_item (
    order_id INT NOT NULL,
    order_item_id INT NOT NULL,
    product_id INT NOT NULL REFERENCES product(product_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    subtotal NUMERIC(12,2) NOT NULL
        GENERATED ALWAYS AS (quantity * unit_price) STORED,
    PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (order_id) REFERENCES order_table(order_id) ON DELETE CASCADE
);

CREATE TABLE return_request (
    return_request_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INT NOT NULL,
    order_item_id INT NOT NULL,
    requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    request_status VARCHAR(50) NOT NULL
        CHECK (request_status IN ('accepted', 'pending', 'rejected')),
    reason TEXT,
    FOREIGN KEY (order_id, order_item_id)
        REFERENCES order_item(order_id, order_item_id)
        ON DELETE CASCADE
);

CREATE TABLE refund (
    refund_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    return_request_id INT NOT NULL
        REFERENCES return_request(return_request_id) ON DELETE CASCADE,
    processed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount NUMERIC(10,2) CHECK (amount >= 0),
    reason TEXT
);

CREATE TABLE payment_transaction (
    transaction_id VARCHAR(50) PRIMARY KEY, -- external ID
    order_id INT NOT NULL
        REFERENCES order_table(order_id) ON DELETE CASCADE,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) NOT NULL
        CHECK (payment_method IN ('Credit Card', 'PayPal', 'Bank Transfer'))
);

CREATE TABLE payment (
    payment_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    transaction_id VARCHAR(50) NOT NULL
        REFERENCES payment_transaction(transaction_id) ON DELETE CASCADE,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_status VARCHAR(50) NOT NULL
        CHECK (payment_status IN ('paid', 'pending','unpaid')),
    amount NUMERIC(12,2) NOT NULL CHECK (amount >= 0)
);

CREATE TABLE review (
    review_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INT NOT NULL,
    order_item_id INT NOT NULL,
    user_id INT NOT NULL REFERENCES customer(user_id) ON DELETE CASCADE,
    review_rating NUMERIC(2,1) NOT NULL CHECK (review_rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    title TEXT,
    FOREIGN KEY (order_id, order_item_id)
        REFERENCES order_item(order_id, order_item_id)
        ON DELETE CASCADE,
    UNIQUE(order_id, order_item_id, user_id)
);
