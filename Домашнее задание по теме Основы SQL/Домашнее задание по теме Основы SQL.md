Задание 1 Выведите для каждого покупателя его адрес, город и страну проживания.

select concat(first_name, ' ', last_name) as "Customer name", a.address, c.city, c2.country 
from customer c1
join address a on c1.address_id = a.address_id 
join city c on c.city_id = a.city_id
join country c2 on c2.country_id = c.country_id 

Задание 2 С помощью SQL-запроса посчитайте для каждого магазина количество его покупателей.

select s.store_id as "ID Магазина",count(customer_id) as "Колличество покупателей"
from customer c 
join store s on s.store_id = c.store_id 
group by s.store_id  

Доработайте запрос и выведите только те магазины, у которых количество покупателей больше 300. Для решения используйте фильтрацию по сгруппированным строкам с функцией агрегации.

select s.store_id as "ID Магазина",count(customer_id) as "Колличество покупателей"
from customer c 
join store s on s.store_id = c.store_id 
group by s.store_id
having count(customer_id) > 300

Доработайте запрос, добавив в него информацию о городе магазина, фамилии и имени продавца, который работает в нём.

select s.store_id as "ID Магазина", count(customer_id) as "Колличество покупателей", c2.city as "Город", concat_ws(' ', s2.last_name, s2.first_name) as "Имя сотрудника"
from customer c 
join store s on s.store_id = c.store_id 
join staff s2 on s2.staff_id = s.manager_staff_id 
join address a on a.address_id = s.address_id 
join city c2 on c2.city_id = a.city_id 
group by s.store_id, c2.city, s2.last_name, concat_ws(' ', s2.last_name, s2.first_name)
having count(customer_id) > 300

Задание 3 Выведите топ-5 покупателей, которые взяли в аренду за всё время наибольшее количество фильмов.

select concat(first_name, ' ', last_name) as "Фамилия и Имя", count(film_id) as "Кол-во фильмов" 
from customer c1 
join rental r1 on r1.customer_id = c1.customer_id 
join inventory i on i.inventory_id = r1.inventory_id 
group by c1.customer_id 
order by 2 
desc limit 5

Задание 4. Посчитайте для каждого покупателя 4 аналитических показателя:

 - количество взятых в аренду фильмов;
 - общую стоимость платежей за аренду всех фильмов (значение округлите до целого числа);
 - минимальное значение платежа за аренду фильма;
 - максимальное значение платежа за аренду фильма.

 select concat(first_name, ' ', last_name) as "Фамилия и Имя", count(distinct film_id )as "Кол-во фильмов",
round(sum(p.amount), 0) as "Общая ст-ть платежа", 
min(p.amount) as "Минимальная ст-ть платежа", 
max(p.amount) as "Максимальная ст-ть платежа"
from customer c1 
join rental r1 on r1.customer_id = c1.customer_id 
join inventory i on i.inventory_id = r1.inventory_id 
join payment p on p.rental_id = r1.rental_id 
group by c1.customer_id


Задание 5 Используя данные из таблицы городов, составьте все возможные пары городов так, чтобы в результате не было пар с одинаковыми названиями городов. 
Задание необходимо выполнить, используя Декартово произведение.

select c1.city, c2.city 
from city c1, city c2  
where c1.city != c2.city

Задание 6 Используя данные из таблицы rental о дате выдачи фильма в аренду (поле rental_date) и дате возврата (поле return_date), 
вычислите для каждого покупателя среднее количество дней, 
за которые он возвращает фильмы. В результате должны быть дробные значения, а не интервал.

select c.customer_id as "ID Покупателя", round(avg(return_date::date - rental_date:: date ), 2) as "Среднее кол-во дней на возврат"
from rental r 
join customer c on c.customer_id = r.customer_id 
group by c.customer_id
order by 1
