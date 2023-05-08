--1. Выведите название самолетов, которые имеют менее 50 посадочных мест?  --10 +

select a.model, count(s.seat_no) as "Кол-во мест"
from aircrafts a
join seats s on s.aircraft_code = a.aircraft_code
group by 1
having count(s.seat_no) < 50

--2. Выведите процентное изменение ежемесячной суммы бронирования билетов, округленной до сотых. --25 +  процентное изменение = (V новое - V старое) / V старое × 100%  lag - Старое значение 
-- 734.93
--   -53,8

      select date_trunc('month', book_date)::date, sum(total_amount), 
      round((sum(total_amount) - lag(sum(total_amount)) over (order by date_trunc('month', book_date)::date )) / 
      lag(sum(total_amount)) over (order by date_trunc('month', book_date)::date ) * 100, 2)
	  from bookings
	  group by 1

--3. Выведите названия самолетов не имеющих бизнес - класс. Решение должно быть через функцию array_agg.  -- 15 +


select *
from (
	select aircraft_code, array_agg(fare_conditions) as "Самолеты не имеющие бизнес класс"
	from (
		select aircraft_code, fare_conditions
		from seats
		order by aircraft_code, fare_conditions)t	
	group by aircraft_code)t
	where 'Business' != all("Самолеты не имеющие бизнес класс")  	
	

     
--4. Найдите процентное соотношение перелетов по маршрутам от общего количества перелетов.   --20 
     Выведите в результат названия аэропортов и процентное отношение.
     Решение должно быть через оконную функцию.

select concat(a1.airport_name, ' - ', a2.airport_name) as "Название аэропортов",
	round((count(f.flight_id) / (sum(count(f.flight_id)) over ())  * 100),2) as "% от общего кол-ва перелётов"
from flights f 
join airports a1 on f.departure_airport = a1.airport_code
join airports a2 on f.arrival_airport = a2.airport_code
group by 1



--5. Выведите количество пассажиров по каждому коду сотового оператора, если учесть, что код оператора - это три символа после +7  --15 +    
     
     select right(substring(contact_data ->> 'phone', 2, 4), 3) ::text  as "Код оператора", count(ticket_no) as "Количество пассажиров"
	 from tickets t 
     group by "Код оператора"
     

--6. Классифицируйте финансовые обороты (сумма стоимости билетов) по маршрутам:    -- 20 
     До 50 млн - low
     От 50 млн включительно до 150 млн - middle
     От 150 млн включительно - high
     Выведите в результат количество маршрутов в каждом полученном классе.

  
select c, count(*)
from(
	select  distinct f.departure_airport, f.arrival_airport,count(f.flight_id), sum(tf.amount), 
	case
				when SUM(tf.amount) < 50000000 then 'low'
				when SUM(tf.amount) < 150000000 then 'middle'
				else 'high'
			end c
	from flights f 
	join ticket_flights tf on tf.flight_id = f.flight_id
	group by 1, 2) t
group by c	

--7. Вычислите медиану стоимости билетов, медиану размера бронирования и отношение медианы бронирования к медиане стоимости билетов, округленной до сотых.    --25
 

with c1 as (
        select 
		PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY amount)::numeric  AS "Медиана стоимости билетов"
		from ticket_flights tf),
c2 as(
        select
		PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_amount)::numeric  AS "Медиана размера бронирования"
		from bookings b)
select *, round(c2."Медиана размера бронирования"/c1."Медиана стоимости билетов", 2) as booking_to_ticket
from c1, c2

-- Формула 
SELECT 
 PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY y) AS median
FROM
 dataset


  
     
     
     
     
     
     
     