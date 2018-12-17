DECLARE
CURSOR ALL_REC
is
select * from user_objects;
TYPE OBJS IS TABLE OF USER_OBJECTS%ROWTYPE;
T_OBJS OBJS;
BEGIN
OPEN ALL_REC;
loop
FETCH ALL_REC BULK COLLECT INTO T_OBJS LIMIT 10;
FOR I IN 1..T_OBJS.COUNT
LOOP
begin
if T_OBJS(I).OBJECT_TYPE = 'SEQUENCE' then
execute immediate 'grant select on ' || T_OBJS(I).OBJECT_NAME || ' to NACCO_FLEET_QA';
else
execute immediate 'grant all on ' || T_OBJS(I).OBJECT_NAME || ' to NACCO_FLEET_QA';
end if;
EXCEPTION WHEN OTHERS THEN
null;
end;
END LOOP;
EXIT WHEN
T_OBJS.COUNT=0;
END LOOP;
close all_rec;
end;
/