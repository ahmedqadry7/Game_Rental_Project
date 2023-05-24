--a
select number_of_renters as "maximum number of renters" ,GAME_NAME
from GAMES
where number_of_renters = (select max(number_of_renters) as "maximum number of renters" from GAMES);

--b
select max(MONTH) AS "last month",g.GAME_ID,g.GAME_NAME,g.number_of_renters
from RENTS r join GAMES g
on r.GAME_ID = g.GAME_ID
where MONTH = (select max(MONTH)  from RENTS) and number_of_renters =0
group by g.GAME_ID,g.GAME_NAME,g.number_of_renters

--c
select c.CLIENT_ID, CLIENT_FIRST_NAME, max(MONTH) as "last month",CLIENT_RENTS
from CLIENTS c join RENTS r
on c.CLIENT_ID = r.CLIENT_ID
where CLIENT_RENTS = (select max(CLIENT_RENTS) from CLIENTS)
group by c.CLIENT_ID,CLIENT_FIRST_NAME,CLIENT_RENTS

--d
select v.VENDOR_ID,VENDOR_FIRST_NAME,VENDOR_RENTS, max(MONTH) as "last month"
from VENDORS v join GAMES g on v.VENDOR_ID = g.VENDOR_ID join RENTS r on g.GAME_ID = r.GAME_ID
where VENDOR_RENTS = (select max(VENDOR_RENTS)from VENDORS v join GAMES g 
on v.VENDOR_ID = g.VENDOR_ID join RENTS r on g.GAME_ID = r.GAME_ID
where MONTH = (select max(MONTH) from RENTS))
group by v.VENDOR_ID,VENDOR_FIRST_NAME,VENDOR_RENTS

--e
select v.VENDOR_ID,v.VENDOR_FIRST_NAME,VENDOR_RENTS,max(MONTH) as "last month"
from RENTS r join GAMES g on r.GAME_ID = g.GAME_ID join VENDORS v on v.VENDOR_ID = g.GAME_ID
where VENDOR_RENTS = 0
group by v.VENDOR_ID,v.VENDOR_FIRST_NAME,VENDOR_RENTS;
