ЗАДАНИЕ №1
Напишите SQL-запрос, который выводит всю информацию о фильмах 
со специальным атрибутом "Behind the Scenes".


explain analyze
select film_id, title, special_features
from film 
where special_features && array['Behind the Scenes']


ЗАДАНИЕ №2
Напишите еще 2 варианта поиска фильмов с атрибутом "Behind the Scenes",
используя другие функции или операторы языка SQL для поиска значения в массиве.


explain analyze
select title, array_agg(unnest)
from (
	select title, unnest(special_features), film_id
	from film) t
where unnest = 'Behind the Scenes'
group by film_id, title


explain analyze
select film_id, title, special_features
from film 
where special_features::text like '%Behind the Scenes%' 


ЗАДАНИЕ №3
Для каждого покупателя посчитайте сколько он брал в аренду фильмов 
со специальным атрибутом "Behind the Scenes.

Обязательное условие для выполнения задания: используйте запрос из задания 1, 
помещенный в CTE. CTE необходимо использовать для решения задания.


explain analyze
with cte as (
	select film_id, title, special_features
	from film 
	where special_features && array['Behind the Scenes']

)
select c.customer_id, count(cte.film_id) as film_count
from customer c
left join rental r on c.customer_id = r.customer_id
left join inventory i on r.inventory_id = i.inventory_id
left join cte on cte.film_id = i.film_id 
group by c.customer_id
order by c.customer_id 


ЗАДАНИЕ №4
Для каждого покупателя посчитайте сколько он брал в аренду фильмов
со специальным атрибутом "Behind the Scenes".

Обязательное условие для выполнения задания: используйте запрос из задания 1,
помещенный в подзапрос, который необходимо использовать для решения задания.


explain analyze
select r.customer_id, count(f.film_id) as film_count
from (select film_id, title, special_features
	from film 
	where special_features && array['Behind the Scenes']) f
left join inventory i on f.film_id = i.film_id
left join rental r on i.inventory_id = r.inventory_id
group by r.customer_id
order by r.customer_id 


ЗАДАНИЕ №5
Создайте материализованное представление с запросом из предыдущего задания
и напишите запрос для обновления материализованного представления


create materialized view task_5 as
	select r.customer_id, count(f.film_id) as film_count
	from (select film_id, title, special_features
		from film 
		where special_features && array['Behind the Scenes']) f
	left join inventory i on f.film_id = i.film_id
	left join rental r on i.inventory_id = r.inventory_id
	group by r.customer_id
	order by r.customer_id

refresh materialized view task_5
	
select * from task_5