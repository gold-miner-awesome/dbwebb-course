-- 
-- Create table: customer
-- 
DROP TABLE IF EXISTS customer;
CREATE TABLE customer
(
    id INT(11) NOT NULL AUTO_INCREMENT,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    address VARCHAR(255),
    postal_code VARCHAR(50),
    city VARCHAR(50),
    country VARCHAR(50),
    phone_number VARCHAR(50),

    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Create table: product
-- 
DROP TABLE IF EXISTS product;
CREATE TABLE product
(
    product_id VARCHAR(10) NOT NULL,
    name VARCHAR(255),
    price DECIMAL(8, 2),
    image_link VARCHAR(255),
    description VARCHAR(255),

    PRIMARY KEY (product_id),
    UNIQUE KEY unique_product_id (product_id),
    KEY index_product (product_id,name,description),
    FULLTEXT KEY fulltext_product (product_id,name,description)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Create table: category
-- 
DROP TABLE IF EXISTS category;
CREATE TABLE category
(
    category VARCHAR(50) NOT NULL,
    PRIMARY KEY (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Create table: product2category
-- 
DROP TABLE IF EXISTS product2category;
CREATE TABLE product2category
(
    product_id VARCHAR(10) NOT NULL,
    category VARCHAR(50) NOT NULL,
    PRIMARY KEY (product_id, category),
    FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE,
    FOREIGN KEY (category) REFERENCES category (category) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Create table: inventory
-- 
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory
(
    shelf VARCHAR(50) NOT NULL,
    PRIMARY KEY (shelf)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Create table: product2inventory
-- 
DROP TABLE IF EXISTS product2inventory;
CREATE TABLE product2inventory
(
    product_id VARCHAR(10) NOT NULL,
    shelf VARCHAR(50) NOT NULL,
    amount INT(11) NOT NULL,
    PRIMARY KEY (product_id, shelf),
    UNIQUE KEY unique_p2i (product_id,shelf),
    KEY shelf (shelf),
    KEY index_amount (amount),
    FULLTEXT KEY fulltext_p2i (product_id,shelf),
    FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE,
    FOREIGN KEY (shelf) REFERENCES inventory (shelf) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Create table: orders
-- 
DROP TABLE IF EXISTS orders;
CREATE TABLE orders
(
    id INT(11) NOT NULL AUTO_INCREMENT,
    customer_id INT(11) NOT NULL,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted TIMESTAMP NULL,
    ordered TIMESTAMP NULL,
    shipped TIMESTAMP NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES customer (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Create table: order2product
-- 
DROP TABLE IF EXISTS order2product;
CREATE TABLE order2product
(
    order_id INT(11) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INT(11) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    UNIQUE KEY unique_o2p (order_id,product_id),
    KEY product_id (product_id),
    FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;