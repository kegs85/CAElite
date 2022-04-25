# Create testdata table
CREATE TABLE testdata (id serial, uom text, val real);

# Create test dataset - creates 10 million records
DO $$
declare
    currentrecord INT = 1;
begin
    WHILE currentrecord <= 10000000 loop
        insert into testdata (uom, val) values ('mm', random() * 1000);
          currentrecord := currentrecord + 1;
       end loop;
END $$;

# Sample conversion Function (pre performance testing)
CREATE OR REPLACE FUNCTION Converter_x_ff(in_value float,in_uom text)
 RETURNS float
 LANGUAGE sql VOLATILE
AS $function$
    Select
    CASE WHEN in_uom='km' then (in_value * 10000000.0 / 25.4 / 36.0 / 100.0)
    WHEN in_uom='mm' then (in_value / 25.4 / 36.0 / 100.0)
    END
$function$;

#Change some UOMs to KM
update testdata set uom = 'km' where (mod(floor(val)::int,2)=1);

# TCD conversion function
CREATE OR REPLACE FUNCTION pt_tcd.x_m(in_value float,in_uom text)
RETURNS float
LANGUAGE sql
AS $function$
Select
in_value * (select multiplier from pt_tcd.conversions where uom = in_uom) +(select constant from pt_tcd.conversions where uom = in_uom)
$function$;

# TCD conversion unit test
CREATE OR REPLACE FUNCTION pt_tcd.Converter_unit_test(in_value float,in_uom text,out_value float)
RETURNS bool
LANGUAGE sql
AS $function$
Select
  Converter_x_m(in_value,in_uom) = out_value
$function$;

# Common Postgres Interactions
\c #database name, e.g. \c pairtree changes to pairtree database
\dn #shows list of schemas
\df #shows list of functions in current schema
\dt #shows lisf of tables with relations
\dt+ #shows list of tables with relations with persistance
\dp #shows privileges across tables

# Tables in TCD and public schemas
select table_catalog, table_schema, table_name from information_schema.tables where table_schema in ('public','pt_tcd');

# Functions in TCD and public schemas
select routine_catalog, routine_schema, routine_name from information_schema.routines where routine_schema in ('public','pt_tcd');
