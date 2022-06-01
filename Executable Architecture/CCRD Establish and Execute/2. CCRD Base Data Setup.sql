insert into converter.data_type (name, translation, created, created_by, updated, updated_by, active)
  values ('Temperature', FALSE, now(), -1, now(), -1, TRUE);

insert into converter.uom (data_type_id, uom_name, uom_abbreviation, precision,
    owner_user_id, created, created_by, updated, updated_by, active)
        values
          ((SELECT ID FROM CONVERTER.data_type where name = 'Temperature'), 'Celsius', '¬∞C', 3, -1, now(), -1, now(), -1, TRUE),
          ((SELECT ID FROM CONVERTER.data_type where name = 'Temperature'), 'Fahrenheit', '¬∞F', 3, -1, now(), -1, now(), -1, TRUE),
          ((SELECT ID FROM CONVERTER.data_type where name = 'Temperature'), 'Kelvin', '¬∞K', 3, -1, now(), -1, now(), -1, TRUE),
          ((SELECT ID FROM CONVERTER.data_type where name = 'Temperature'), 'Rankine', '¬∞Ra', 3, -1, now(), -1, now(), -1, TRUE);

insert into converter.default_units (data_type_id, default_uom_id, created, created_by, updated, updated_by, active)
    values ((SELECT ID FROM CONVERTER.data_type where name = 'Temperature'),
      (SELECT ID FROM CONVERTER.uom where uom_name = 'Kelvin'), now(), -1, now(), -1, TRUE);

insert into converter.data_category (name, type_id, created, created_by, updated, updated_by, active)
    values ('Soil Temperature', (SELECT ID FROM CONVERTER.data_type where name = 'Temperature'), now(), -1, now(), -1, TRUE),
      ('Air Temperature', (SELECT ID FROM CONVERTER.data_type where name = 'Temperature'), now(), -1, now(), -1, TRUE);

insert into converter.conversion_set (name, owner_user_id, created, created_by, updated, updated_by, active)
    values ('Metric', -1, now(), -1, now(), -1, TRUE),
    ('Imperial', -1, now(), -1, now(), -1, TRUE),
    ('Custom', -1, now(), -1, now(), -1, TRUE);

insert into converter.user_conversion_set (user_id, conversion_set_id, created, created_by, updated, updated_by, active)
    values (1, (select id from converter.conversion_set where name = 'Metric'), now(), -1, now(), -1, TRUE),
      (2, (select id from converter.conversion_set where name = 'Metric'), now(), -1, now(), -1, TRUE),
      (3, (select id from converter.conversion_set where name = 'Metric'), now(), -1, now(), -1, TRUE),
      (4, (select id from converter.conversion_set where name = 'Metric'), now(), -1, now(), -1, TRUE),
      (5, (select id from converter.conversion_set where name = 'Metric'), now(), -1, now(), -1, TRUE),
      (6, (select id from converter.conversion_set where name = 'Metric'), now(), -1, now(), -1, TRUE),
      (7, (select id from converter.conversion_set where name = 'Metric'), now(), -1, now(), -1, TRUE),
      (8, (select id from converter.conversion_set where name = 'Metric'), now(), -1, now(), -1, TRUE),
      (9, (select id from converter.conversion_set where name = 'Imperial'), now(), -1, now(), -1, TRUE),
      (11, (select id from converter.conversion_set where name = 'Imperial'), now(), -1, now(), -1, TRUE),
      (12, (select id from converter.conversion_set where name = 'Imperial'), now(), -1, now(), -1, TRUE),
      (13, (select id from converter.conversion_set where name = 'Imperial'), now(), -1, now(), -1, TRUE),
      (14, (select id from converter.conversion_set where name = 'Imperial'), now(), -1, now(), -1, TRUE),
      (15, (select id from converter.conversion_set where name = 'Custom'), now(), -1, now(), -1, TRUE);

insert into converter.category_to_conversion_set (conversion_set_id, data_category_id, uom_id, created, created_by, updated, updated_by, active)
    values ((select id from converter.conversion_set where name = 'Metric'),
              (select id from converter.data_category where name = 'Soil Temperature'), (select id from converter.uom where uom_name = 'Celsius'),
                now(), -1, now(), -1, TRUE),
           ((select id from converter.conversion_set where name = 'Metric'),
              (select id from converter.data_category where name = 'Air Temperature'), (select id from converter.uom where uom_name = 'Celsius'),
                now(), -1, now(), -1, TRUE),
            ((select id from converter.conversion_set where name = 'Imperial'),
                      (select id from converter.data_category where name = 'Soil Temperature'), (select id from converter.uom where uom_name = 'Fahrenheit'),
                        now(), -1, now(), -1, TRUE),
             ((select id from converter.conversion_set where name = 'Imperial'),
                (select id from converter.data_category where name = 'Air Temperature'), (select id from converter.uom where uom_name = 'Fahrenheit'),
                  now(), -1, now(), -1, TRUE),
                  ((select id from converter.conversion_set where name = 'Custom'),
                            (select id from converter.data_category where name = 'Soil Temperature'), (select id from converter.uom where uom_name = 'Rankine'),
                              now(), -1, now(), -1, TRUE),
                   ((select id from converter.conversion_set where name = 'Custom'),
                      (select id from converter.data_category where name = 'Air Temperature'), (select id from converter.uom where uom_name = 'Kelvin'),
                        now(), -1, now(), -1, TRUE);

insert into converter.conversion_rate (uom_id, rate, constant)
    values ((select id from converter.uom where uom_name = 'Celsius'), 1, -273.15),
             ((select id from converter.uom where uom_name = 'Fahrenheit'), 1.8, -459.67),
                ((select id from converter.uom where uom_name = 'Rankine'), 1.8, 0),
                ((select id from converter.uom where uom_name = 'Kelvin'), 1, 0);
