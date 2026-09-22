CREATE TABLE customer (
    customer_id VARCHAR(10) PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50)
);

CREATE TABLE product (
    product_id VARCHAR(10) PRIMARY KEY,
    category VARCHAR(50),
    color VARCHAR(20),
    size VARCHAR (10),
    season VARCHAR(20),
    supplier VARCHAR(20),
    cost_price DECIMAL(10,2),
    list_price DECIMAL(10,2)
);

CREATE TABLE store (
    store_id VARCHAR(10) PRIMARY KEY,
    store_name VARCHAR(50),
    region VARCHAR(50),
    store_size_m2 INT
);

CREATE TABLE sales (
    transaction_id VARCHAR(10) PRIMARY KEY,
    date DATE,
    product_id VARCHAR(10),
    store_id VARCHAR(10),
    customer_id VARCHAR(10),
    quantity INT,
    discount DECIMAL(5,2),
    returned BOOLEAN,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (store_id) REFERENCES store(store_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);