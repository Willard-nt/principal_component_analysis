-- Aetheron Database Schema
-- PostgreSQL on Google Cloud SQL

CREATE SCHEMA IF NOT EXISTS public;

-- Customer Table
CREATE TABLE public.customer (
    customer_id CHARACTER VARYING(36) PRIMARY KEY,
    name CHARACTER VARYING(30) NOT NULL,
    email CHARACTER VARYING(30) NOT NULL UNIQUE,
    phone CHARACTER VARYING(20),
    address CHARACTER VARYING(50)
);

-- Shopping Cart Table
CREATE TABLE public.shopping_cart (
    cart_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id CHARACTER VARYING(36) NOT NULL,
    CONSTRAINT fk_cart_customer FOREIGN KEY (customer_id) 
        REFERENCES public.customer(customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Product Table
CREATE TABLE public.product (
    product_id CHARACTER VARYING(36) PRIMARY KEY,
    cart_id UUID,
    vendor CHARACTER VARYING(40),
    product_category CHARACTER VARYING(30),
    product_name CHARACTER VARYING(25) NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity >= 0),
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    CONSTRAINT fk_product_cart FOREIGN KEY (cart_id) 
        REFERENCES public.shopping_cart(cart_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Transactions Table
CREATE TABLE public.transactions (
    transaction_id CHARACTER VARYING(36) PRIMARY KEY,
    customer_id CHARACTER VARYING(36) NOT NULL,
    cart_id UUID NOT NULL,
    transaction_date CHARACTER VARYING(30) NOT NULL,
    shipping_method CHARACTER VARYING(15),
    total_amount NUMERIC(10,2) NOT NULL CHECK (total_amount >= 0),
    CONSTRAINT fk_transaction_customer FOREIGN KEY (customer_id) 
        REFERENCES public.customer(customer_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_transaction_cart FOREIGN KEY (cart_id) 
        REFERENCES public.shopping_cart(cart_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);