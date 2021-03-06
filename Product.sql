CREATE EXTENSION pgcrypto; --Allows PostgreSQL to understand UUIDs. Only have to create the extension once for a database.

--DROP TABLE product;

CREATE TABLE product (
  id uuid NOT NULL DEFAULT gen_random_uuid(), --The record ID. Stored in the edu.uark.dataaccess.entities:BaseEntity#id property. See also the named constant defined in edu.uark.dataaccess.entities:BaseFieldNames that is used for Java <-> SQL mappings.
  lookupcode character varying(32) NOT NULL DEFAULT(''), --Stored in the edu.uark.models.entities:ProductEntity#lookupCode property. See also the named constant defined in edu.uark.models.entities.fieldnames:ProductFieldNames that is used for Java <-> SQL mappings.
  count int NOT NULL DEFAULT(0), --Stored in the edu.uark.models.entities:ProductEntity#count property. See also the named constant defined in edu.uark.models.entities.fieldnames:ProductFieldNames that is used for Java <-> SQL mappings.
  createdon timestamp without time zone NOT NULL DEFAULT now(), --Stored in the edu.uark.dataaccess.entities:BaseEntity#createdOn property. See also the named constant defined in edu.uark.dataaccess.entities:BaseFieldNames that is used for Java <-> SQL mappings.
  CONSTRAINT product_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

--Employee table

CREATE TABLE employeeinfo (
  recordid uuid NOT NULL DEFAULT gen_random_uuid(), --I believe this should generate a random uuid, but I am not sure
  fName character varying() NOT NULL DEFAULT(''), --Should accept string of any length
  lName character varying() NOT NULL DEFAULT(''), --Similar to fName
  empid uuid NOT NULL DEFAULT uuid_generate_v4(), --Currently generating random id for employee,
  active boolean NOT NULL DEFAULT(true),
  position integer NOT NULL DEFAULT(0), --pos 0 = cashier, pos 1 = shift manager, pos 2 = general manager
  manager boolean NOT NULL DEFAULT(false),
  password TEXT NOT NULL, 
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  PRIMARY KEY (recordID)
)

--Active User Table



--DROP INDEX ix_product_lookupcode;

CREATE INDEX ix_product_lookupcode --An index on the product table lookupcode column
  ON product
  USING btree
  (lower(lookupcode::text) COLLATE pg_catalog."default"); --Index on the lower case of the lookup code. Queries for product by lookupcode should search using the lower case of the lookup code.

INSERT INTO product (lookupcode, count) VALUES ( --id and createdon are generated by default.
       'lookupcode1'
     , 100)
RETURNING id, createdon;

INSERT INTO product (lookupcode, count) VALUES (
       'lookupcode2'
     , 125)
RETURNING id, createdon;

INSERT INTO product (lookupcode, count) VALUES (
       'lookupcode3'
     , 150)
RETURNING id, createdon;

--SELECT * FROM product;

--DELETE FROM product;

