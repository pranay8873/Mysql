-- =========================================
-- DATABASE SETUP
-- =========================================
DROP DATABASE IF EXISTS e_commerce_db;
CREATE DATABASE e_commerce_db;
USE e_commerce_db;

-- =========================================
-- CUSTOMERS
-- =========================================
CREATE TABLE customers (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    password VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO customers (first_name, last_name, email, phone, password) VALUES
('Madhu','Samala','madhu@test.com','9000000001','pass123'),
('Sai','Kumar','sai@test.com','9000000002','pass123'),
('Ravi','Teja','ravi@test.com','9000000003','pass123'),
('Anita','Reddy','anita@test.com','9000000004','pass123'),
('Priya','Sharma','priya@test.com','9000000005','pass123'),
('Rahul','Verma','rahul@test.com','9000000006','pass123'),
('Sneha','Patel','sneha@test.com','9000000007','pass123'),
('Kiran','Rao','kiran@test.com','9000000008','pass123'),
('Pooja','Singh','pooja@test.com','9000000009','pass123'),
('Arjun','Das','arjun@test.com','9000000010','pass123');

-- =========================================
-- CATEGORIES
-- =========================================
CREATE TABLE categories (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

INSERT INTO categories (name) VALUES
('Electronics'),
('Mobiles'),
('Fashion'),
('Books'),
('Home'),
('Sports'),
('Toys'),
('Beauty'),
('Grocery'),
('Automotive');

-- =========================================
-- PRODUCTS
-- =========================================
CREATE TABLE products (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150),
    description TEXT,
    price DECIMAL(10,2),
    stock INT,
    category_id BIGINT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

INSERT INTO products (name, description, price, stock, category_id) VALUES
('Laptop','Gaming Laptop',75000,10,1),
('Smartphone','Android Phone',30000,20,2),
('T-Shirt','Cotton T-Shirt',1000,50,3),
('Java Book','Programming Book',500,100,4),
('Sofa','Comfortable Sofa',20000,5,5),
('Football','Sports Item',800,30,6),
('Toy Car','Kids Toy',600,40,7),
('Face Cream','Beauty Product',300,60,8),
('Rice Bag','Grocery Item',1200,25,9),
('Car Cover','Automotive Accessory',1500,15,10);

-- =========================================
-- ADDRESSES
-- =========================================
CREATE TABLE addresses (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    customer_id BIGINT,
    address_line1 VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    pincode VARCHAR(10),
    is_default BOOLEAN,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO addresses (customer_id, address_line1, city, state, country, pincode, is_default) VALUES
(1,'Street 1','Hyderabad','Telangana','India','500001',TRUE),
(2,'Street 2','Hyderabad','Telangana','India','500002',TRUE),
(3,'Street 3','Bangalore','Karnataka','India','560001',TRUE),
(4,'Street 4','Chennai','Tamil Nadu','India','600001',TRUE),
(5,'Street 5','Mumbai','Maharashtra','India','400001',TRUE),
(6,'Street 6','Delhi','Delhi','India','110001',TRUE),
(7,'Street 7','Pune','Maharashtra','India','411001',TRUE),
(8,'Street 8','Kolkata','West Bengal','India','700001',TRUE),
(9,'Street 9','Ahmedabad','Gujarat','India','380001',TRUE),
(10,'Street 10','Jaipur','Rajasthan','India','302001',TRUE);

-- =========================================
-- CARTS
-- =========================================
CREATE TABLE carts (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    customer_id BIGINT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO carts (customer_id) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

-- =========================================
-- CART ITEMS
-- =========================================
CREATE TABLE cart_items (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    cart_id BIGINT,
    product_id BIGINT,
    quantity INT,
    FOREIGN KEY (cart_id) REFERENCES carts(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO cart_items (cart_id, product_id, quantity) VALUES
(1,1,1),
(2,2,2),
(3,3,1),
(4,4,3),
(5,5,1),
(6,6,2),
(7,7,1),
(8,8,2),
(9,9,1),
(10,10,1);

-- =========================================
-- ORDERS
-- =========================================
CREATE TABLE orders (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    customer_id BIGINT,
    total_amount DECIMAL(10,2),
    order_status VARCHAR(50),
    payment_status VARCHAR(50),
    shipping_address_id BIGINT,
    ordered_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (shipping_address_id) REFERENCES addresses(id)
);

INSERT INTO orders (customer_id, total_amount, order_status, payment_status, shipping_address_id) VALUES
(1,75000,'DELIVERED','SUCCESS',1),
(2,30000,'SHIPPED','SUCCESS',2),
(3,1000,'PENDING','PENDING',3),
(4,500,'DELIVERED','SUCCESS',4),
(5,20000,'SHIPPED','SUCCESS',5),
(6,800,'DELIVERED','SUCCESS',6),
(7,600,'PENDING','PENDING',7),
(8,300,'DELIVERED','SUCCESS',8),
(9,1200,'SHIPPED','SUCCESS',9),
(10,1500,'DELIVERED','SUCCESS',10);

-- =========================================
-- ORDER ITEMS
-- =========================================
CREATE TABLE order_items (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT,
    product_id BIGINT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1,1,1,75000),
(2,2,1,30000),
(3,3,1,1000),
(4,4,1,500),
(5,5,1,20000),
(6,6,1,800),
(7,7,1,600),
(8,8,1,300),
(9,9,1,1200),
(10,10,1,1500);

-- =========================================
-- PAYMENTS
-- =========================================
CREATE TABLE payments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT UNIQUE,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    transaction_id VARCHAR(100),
    paid_amount DECIMAL(10,2),
    paid_at DATETIME,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

INSERT INTO payments (order_id, payment_method, payment_status, transaction_id, paid_amount, paid_at) VALUES
(1,'UPI','SUCCESS','TXN001',75000,NOW()),
(2,'CARD','SUCCESS','TXN002',30000,NOW()),
(3,'UPI','PENDING','TXN003',1000,NULL),
(4,'CARD','SUCCESS','TXN004',500,NOW()),
(5,'UPI','SUCCESS','TXN005',20000,NOW()),
(6,'CARD','SUCCESS','TXN006',800,NOW()),
(7,'UPI','PENDING','TXN007',600,NULL),
(8,'CARD','SUCCESS','TXN008',300,NOW()),
(9,'UPI','SUCCESS','TXN009',1200,NOW()),
(10,'CARD','SUCCESS','TXN010',1500,NOW());

-- =========================================
-- SHIPMENTS
-- =========================================
CREATE TABLE shipments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT UNIQUE,
    courier_name VARCHAR(100),
    tracking_number VARCHAR(100),
    shipment_status VARCHAR(50),
    shipped_at DATETIME,
    delivered_at DATETIME,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

INSERT INTO shipments (order_id, courier_name, tracking_number, shipment_status, shipped_at, delivered_at) VALUES
(1,'Delhivery','TRK001','DELIVERED',NOW(),NOW()),
(2,'BlueDart','TRK002','SHIPPED',NOW(),NULL),
(3,'DTDC','TRK003','PROCESSING',NULL,NULL),
(4,'Delhivery','TRK004','DELIVERED',NOW(),NOW()),
(5,'BlueDart','TRK005','SHIPPED',NOW(),NULL),
(6,'DTDC','TRK006','DELIVERED',NOW(),NOW()),
(7,'Delhivery','TRK007','PROCESSING',NULL,NULL),
(8,'BlueDart','TRK008','DELIVERED',NOW(),NOW()),
(9,'DTDC','TRK009','SHIPPED',NOW(),NULL),
(10,'Delhivery','TRK010','DELIVERED',NOW(),NOW());