psql

CREATE DATABASE ratpack;
\c ratpack

CREATE TABLE songs (id SERIAL PRIMARY KEY, name VARCHAR(255));

CREATE TABLE users (id SERIAL PRIMARY KEY, username VARCHAR(255), password_hash VARCHAR(255));
