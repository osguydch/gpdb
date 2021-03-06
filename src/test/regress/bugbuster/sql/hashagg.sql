\c tpch_heap
set enable_groupagg=off;
set enable_hashagg=on;
select c_nationkey, count(*) from customer group by c_nationkey;
set enable_groupagg=off;
set enable_hashagg=on;
select c_nationkey, sum(c_acctbal) from customer group by c_nationkey;
set enable_groupagg=off;
set enable_hashagg=on;
select c_mktsegment, bool_and(c_nationkey>10) from customer group by c_mktsegment;
set enable_groupagg=off;
set enable_hashagg=on;
select l_returnflag, l_linestatus, variance(l_discount) from lineitem group by l_returnflag, l_linestatus;
set statement_mem= 10240;
set enable_groupagg=off;
set enable_hashagg=on;
select l_orderkey, l_suppkey, var_pop(l_discount) as var_pop from lineitem group by l_orderkey, l_suppkey order by l_orderkey, l_suppkey, var_pop limit 2000;
set enable_groupagg=off;
set enable_hashagg=on;
select l_suppkey, avg(l_discount) from lineitem group by l_suppkey;
set statement_mem= 7000;
set enable_groupagg=off;
set enable_hashagg=on;
select l_orderkey, covar_pop(l_partkey, l_suppkey) as covar_pop from lineitem group by l_orderkey order by l_orderkey, covar_pop limit 2000;
set enable_hashagg=on;
create table agg_zoo(x bigint, y int) distributed by (x);
insert into agg_zoo select random() * 12345678, 1 from generate_series(1,100000);
analyze agg_zoo;
set statement_mem="1600";
select sum(y) from agg_zoo;
select sum(y) from (select sum(y) as y from agg_zoo group by x) a;
Drop table agg_zoo;
