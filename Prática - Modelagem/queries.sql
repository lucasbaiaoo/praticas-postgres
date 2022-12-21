CREATE TABLE "users" (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(50) NOT NULL,
	"email" TEXT NOT NULL,
	"password" TEXT NOT NULL,
	"main_address_id" INTEGER NOT NULL REFERENCES "adresses"("id"),
);

CREATE TABLE "products" (
	"id" SERIAL PRIMARY KEY,
	"name" TEXT NOT NULL,
	"price" INTEGER NOT NULL,
	"main_photo_id" INTEGER NOT NULL REFERENCES "photos"("id"),
	"category_id" INTEGER NOT NULL REFERENCES "categories"("id"),
	"size_id" INTEGER NOT NULL REFERENCES "size"("id")
);

CREATE TABLE "photos" (
	"id" SERIAL PRIMARY KEY,
	"image_url" TEXT NOT NULL,
	"product_id" INTEGER NOT NULL REFERENCES "products"("id")
);

CREATE TABLE "categories" (
	"id" SERIAL PRIMARY KEY,
	"name" TEXT NOT NULL
);

CREATE TABLE "sizes" (
	"id" SERIAL PRIMARY KEY,
	"name" TEXT NOT NULL
);


CREATE TABLE "orders" (
	"id" SERIAL PRIMARY KEY,
	"state" TEXT NOT NULL,
	"date" DATE NOT NULL DEFAULT NOW(),
	"address_id" INTEGER NOT NULL REFERENCES "adresses"("id"),
    "user_id" INTEGER NOT NULL REFERENCES "users"("id")
);

CREATE TABLE "orders_products" (
	"id" SERIAL PRIMARY KEY,
    "product_id" INTEGER NOT NULL REFERENCES "products"("id"),
    "amount" INTEGER NOT NULL,
	"order_id" INTEGER NOT NULL REFERENCES "orders"("id")
);

CREATE TABLE "adresses" (
	"id" SERIAL PRIMARY KEY,
    "state" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "street" TEXT NOT NULL,
    "number" TEXT NOT NULL,
    "complement" TEXT NOT NULL,
    "zipCode" TEXT NOT NULL,
	"user_id" INTEGER NOT NULL REFERENCES "users"("id")
);