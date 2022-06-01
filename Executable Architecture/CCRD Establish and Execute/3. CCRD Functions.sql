-- # CCRD Conversion Function using a private convert_x_y
CREATE OR REPLACE FUNCTION converter.ccrd_mod(in_user_id int, in_uom text, in_data_category text, in_value float)
RETURNS real
language plpgsql
as
$$
declare
    fconversion_set_id integer := conversion_set_id from converter.user_conversion_set a where a.user_id = in_user_id and active = TRUE;
    fcategory_id integer := id from converter.data_category where name = in_data_category;
    set_category_uom integer := uom_id from converter.category_to_conversion_set where conversion_set_id = fconversion_set_id and data_category_id = fcategory_id;
    converted_value real;
begin
    converted_value = converter.prot_convert_x_y(in_uom, set_category_uom, in_value);
    return converted_value;
end;
$$;

-- # Private Direct Conversion Function
CREATE OR REPLACE FUNCTION converter.prot_convert_x_y(in_uom text, out_uom_id int, in_value float)
RETURNS real
language plpgsql
as
$$
declare
    in_uom_id integer := id from converter.uom where uom_abbreviation = in_uom;
    in_uom_rate real := rate from converter.conversion_rate where uom_id = in_uom_id;
    out_uom_rate real := rate from converter.conversion_rate where uom_id = out_uom_id;
    in_uom_constant real := constant from converter.conversion_rate where uom_id = in_uom_id;
    out_uom_constant real := constant from converter.conversion_rate where uom_id = out_uom_id;
    precision integer := precision from converter.uom where id = out_uom_id;
    converted_value real;
begin
    converted_value = (out_uom_rate*(in_value-in_uom_constant))/in_uom_rate + out_uom_constant;
    converted_value = round(converted_value::numeric,precision);
    return converted_value;
end;
$$;

-- # CCRD Conversion Function using public convert_x_y
CREATE OR REPLACE FUNCTION converter.ccrd(in_user_id int, in_uom text, in_data_category text, in_value float)
RETURNS real
language plpgsql
as
$$
declare
    fconversion_set_id integer := conversion_set_id from converter.user_conversion_set a where a.user_id = in_user_id and active = TRUE;
    fcategory_id integer := id from converter.data_category where name = in_data_category;
    set_category_uom integer := uom_id from converter.category_to_conversion_set where conversion_set_id = fconversion_set_id and data_category_id = fcategory_id;
    converted_value real;
begin
    converted_value = converter.prot_convert_x_y(in_uom, set_category_uom, in_value);
    return converted_value;
end;
$$;

-- # Public Direct Conversion Function
CREATE OR REPLACE FUNCTION converter.convert_x_y(in_uom text, out_uom text, in_value float)
RETURNS real
language plpgsql
as
$$
declare
    in_uom_id integer := id from converter.uom where uom_abbreviation = in_uom;
    out_uom_id integer := id from converter.uom where uom_abbreviation = out_uom;
    in_uom_rate real := rate from converter.conversion_rate where uom_id = in_uom_id;
    out_uom_rate real := rate from converter.conversion_rate where uom_id = out_uom_id;
    in_uom_constant real := constant from converter.conversion_rate where uom_id = in_uom_id;
    out_uom_constant real := constant from converter.conversion_rate where uom_id = out_uom_id;
    precision integer := precision from converter.uom where id = out_uom_id;
    converted_value real;
begin
    converted_value = (out_uom_rate*(in_value-in_uom_constant))/in_uom_rate + out_uom_constant;
    converted_value = round(converted_value::numeric,precision);
    return converted_value;
end;
$$;
