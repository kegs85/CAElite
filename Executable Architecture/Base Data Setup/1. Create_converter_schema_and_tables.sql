DROP SCHEMA converter CASCADE;
CREATE SCHEMA converter;
CREATE TABLE IF NOT EXISTS converter.data_type(
id SERIAL,
NAME TEXT,
translation BOOLEAN,
created TIMESTAMPTZ,
updated TIMESTAMPTZ,
created_by INT,
updated_by INT,
active BOOLEAN,
PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS converter.uom(
id SERIAL,
data_type_id INT,
uom_name TEXT,
uom_abbreviation TEXT,
PRECISION INT,
upper_boundary REAL,
lower_boundary REAL,
upper_uom INT,
lower_uom INT,
owner_user_id INT,
created TIMESTAMPTZ,
updated TIMESTAMPTZ,
created_by INT,
updated_by INT,
active BOOLEAN,
PRIMARY KEY (id),
CONSTRAINT fk_uom_data_type_id
    FOREIGN KEY (data_type_id)
        REFERENCES converter.data_type(id)
        ON DELETE SET NULL);

CREATE TABLE IF NOT EXISTS converter.default_units(
id SERIAL,
data_type_id INT,
default_uom_id INT,
created TIMESTAMPTZ,
updated TIMESTAMPTZ,
created_by INT,
updated_by INT,
active BOOLEAN,
PRIMARY KEY (id),
CONSTRAINT fk_default_units_data_type_id
    FOREIGN KEY (data_type_id)
        REFERENCES converter.data_type(id)
        ON DELETE SET NULL,
CONSTRAINT fk_default_units_default_uom_id
    FOREIGN KEY (default_uom_id)
        REFERENCES converter.uom(id)
        ON DELETE SET NULL);

CREATE TABLE IF NOT EXISTS converter.data_category(
id SERIAL,
NAME TEXT,
type_id INT,
created TIMESTAMPTZ,
updated TIMESTAMPTZ,
created_by INT,
updated_by INT,
active BOOLEAN,
PRIMARY KEY (id),
CONSTRAINT fk_data_category_type_id
    FOREIGN KEY (type_id)
        REFERENCES converter.data_type(id)
        ON DELETE SET NULL);

CREATE TABLE IF NOT EXISTS converter.permission(
id SERIAL,
NAME TEXT,
PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS converter.access_rights(
id SERIAL,
owner_id INT,
user_id INT,
created TIMESTAMPTZ,
updated TIMESTAMPTZ,
created_by INT,
updated_by INT,
active BOOLEAN,
permission_id INT,
PRIMARY KEY (id),
CONSTRAINT fk_access_rights_permission_id
    FOREIGN KEY (permission_id)
        REFERENCES converter.permission(id)
        ON DELETE SET NULL);

CREATE TABLE IF NOT EXISTS converter.response(
id SERIAL,
description TEXT,
PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS converter.conversion_set(
id SERIAL,
NAME TEXT,
owner_user_id INT,
created TIMESTAMPTZ,
updated TIMESTAMPTZ,
created_by INT,
updated_by INT,
active BOOLEAN,
PRIMARY KEY (id));


CREATE TABLE IF NOT EXISTS converter.user_conversion_set(
id SERIAL,
user_id INT,
conversion_set_id INT,
created TIMESTAMPTZ,
updated TIMESTAMPTZ,
updated_by INT,
created_by INT,
active BOOLEAN,
PRIMARY KEY (id),
CONSTRAINT fk_user_conversion_set_conversion_set_id
    FOREIGN KEY (conversion_set_id)
        REFERENCES converter.conversion_set(id)
        ON DELETE SET NULL);

CREATE TABLE IF NOT EXISTS converter.category_to_conversion_set(
id SERIAL,
conversion_set_id INT,
data_category_id INT,
uom_id INT,
created TIMESTAMPTZ,
updated TIMESTAMPTZ,
created_by INT,
updated_by INT,
active BOOLEAN,
PRIMARY KEY (id),
CONSTRAINT fk_category_to_conversion_set_conversion_set_id
    FOREIGN KEY (conversion_set_id)
        REFERENCES converter.conversion_set(id)
        ON DELETE SET NULL,
CONSTRAINT fk_category_to_conversion_set_data_category_id
    FOREIGN KEY (data_category_id)
        REFERENCES converter.data_category(id)
        ON DELETE SET NULL,
CONSTRAINT fk_category_to_conversion_set_uom_id
    FOREIGN KEY (uom_id)
        REFERENCES converter.uom(id)
        ON DELETE SET NULL);

CREATE TABLE IF NOT EXISTS converter.translation_table(
id SERIAL,
source_uom_id INT,
source_val REAL,
destination_uom_id INT,
destionation_val REAL,
created TIMESTAMPTZ,
updated TIMESTAMPTZ,
created_by INT,
updated_by INT,
active BOOLEAN,
PRIMARY KEY (id),
CONSTRAINT fk_translation_table_source_uom_id
    FOREIGN KEY (source_uom_id)
        REFERENCES converter.uom(id)
        ON DELETE SET NULL,
CONSTRAINT fk_translation_table_destination_uom_id
    FOREIGN KEY (destination_uom_id)
        REFERENCES converter.uom(id)
        ON DELETE SET NULL);

CREATE TABLE IF NOT EXISTS converter.conversion_rate(
id SERIAL,
uom_id INT,
rate REAL,
constant REAL,
created TIMESTAMPTZ,
updated TIMESTAMPTZ,
created_by INT,
updated_by INT,
active BOOLEAN,
PRIMARY KEY (id),
CONSTRAINT fk_conversion_rate_uom_id
    FOREIGN KEY (uom_id)
        REFERENCES converter.uom(id)
        ON DELETE SET NULL);
