drop table if exists pairtreeTestData;
create table pairtreeTestData (value real, metric text, uom text);

DO $$
declare
    currentrecord INT = 1;
    adjustment INT;
begin
    WHILE currentrecord <= 1000000 loop
    adjustment = mod((floor(random()*39+1)::int),4);
    insert into pairtreeTestData (value, metric, uom) values (floor(random()*70000)/1000-20,
      case when mod((floor(random()*10)::int),2)= 0 then'Air Temperature' else 'Soil Temperature' end,
      case when adjustment = 0 then '¬∞C'
      when adjustment = 1 then '¬∞F'
      when adjustment = 2 then '¬∞Ra'
      when adjustment = 3 then '¬∞K'
      end);
      currentrecord := currentrecord + 1;
    end loop;
END $$;


update pairtreeTestData set uom = (
  case
  when mod((floor(random()*10)::int),4)=0 then '¬∞K'
  when mod((floor(random()*10)::int),4)=1 then '¬∞F'
  when mod((floor(random()*10)::int),4)=2 then '¬∞Ra'
  else '¬∞C'
  end);
