CREATE DATABASE "prática_modelagem2";

CREATE TABLE "customers" (
    "id" NOT NULL SERIAL PRIMARY KEY,
    "fullName" NOT NULL TEXT,
    "cpf" NOT NULL VARCHAR (11) UNIQUE, 
    "email" NOT NULL TEXT UNIQUE,
    "password" NOT NULL TEXT
);

CREATE TABLE "bankAccount" (
    "id" NOT NULL SERIAL PRIMARY KEY,
    "customerId" NOT NULL INTEGER UNIQUE REFERENCES "customers"("id"),
    "accountNumber" NOT NULL TEXT UNIQUE, 
    "agency" NOT NULL TEXT,
    "openDate" NOT NULL DATE DEFAULT NOW(),
    "closeDate" DATE
);

CREATE TYPE "transactionType" AS ENUM ("deposit", "withdraw");

CREATE TABLE "transactions" (
    "id" NOT NULL SERIAL PRIMARY KEY,
    "bankAccountId" NOT NULL INTEGER UNIQUE REFERENCES "bankAccount"("id"),
    "amount" NOT NULL BIGINT, 
    "type" NOT NULL "transactionType",
    "time" NOT NULL TIMESTAMP DEFAULT NOW(),
    "description" NOT NULL TEXT,
    "cancelled" NOT NULL BOOLEAN DEFAULT FALSE
);

CREATE TABLE "creditCards" (
    "id" NOT NULL SERIAL PRIMARY KEY,
    "bankAccountId" NOT NULL INTEGER REFERENCES "bankAccount"("id"),
    "name" NOT NULL TEXT, 
    "number" NOT NULL TEXT UNIQUE,
    "securityCode" NOT NULL TEXT,
    "expirationMonth" NOT NULL INTEGER,
    "expirationYear" NOT NULL INTEGER,
    "password" NOT NULL TEXT,
    "limit" NOT NULL BIGINT
);

CREATE TABLE "customerAdresses" (
    "id" NOT NULL SERIAL PRIMARY KEY,
    "customerId" NOT NULL INTEGER UNIQUE REFERENCES "customers"("id"),
    "street" NOT NULL TEXT,
    "number" NOT NULL TEXT,
    "complement" NOT NULL TEXT,
    "postalCode" NOT NULL TEXT,
    "cityId" NOT NULL INTEGER 
);

CREATE TABLE "cities" (
	"id" NOT NULL SERIAL PRIMARY KEY,
	"name" NOT NULL TEXT,
	"stateId" NOT NULL INTEGER 
);

CREATE TABLE "states" (
	"id" NOT NULL SERIAL PRIMARY KEY,
	"name" NOT NULL TEXT
);

CREATE TYPE "phoneType" AS ENUM ("landline", "mobile");

CREATE TABLE "customerPhones" (
	"id" NOT NULL SERIAL PRIMARY KEY,
	"customerId" NOT NULL INTEGER UNIQUE REFERENCES "customers"("id"),
    "number" NOT NULL TEXT,
    "type" NOT NULL "phoneType"
);

ALTER TABLE "customerAdresses" ADD CONSTRAINT "customerAdresses_fk0" FOREIGN KEY ("cityId") REFERENCES "cities"(id);

ALTER TABLE "cities" ADD CONSTRAINT "cities_fk0" FOREIGN KEY ("stateId") REFERENCES "statess"(id);