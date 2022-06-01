-- #test cases
select converter.ccrd(1,'¬∞C','Air Temperature',0)
Union All
select converter.ccrd(1,'¬∞C','Soil Temperature',0)
Union All
select converter.ccrd(9,'¬∞C','Air Temperature',0)
Union All
select converter.ccrd(9,'¬∞C','Soil Temperature',0)
Union All
select converter.ccrd(15,'¬∞C','Air Temperature',0)
Union All
select converter.ccrd(15,'¬∞C','Soil Temperature',0);


select *,converter.ccrd_final(1, ptd.uom, ptd.metric,ptd.value) as user_id_1,converter.ccrd_mod(9, ptd.uom, ptd.metric,ptd.value) as user_id_9,converter.ccrd_mod(15, ptd.uom, ptd.metric,ptd.value) as user_id_15 from pairtreetestdata ptd limit 100;
