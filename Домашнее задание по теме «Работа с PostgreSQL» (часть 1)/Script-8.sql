МОДУЛЬ 5. РАБОТА С POSTGRESQL =======================================

--ЗАДАНИЕ №1
--Сделайте запрос к таблице payment и с помощью оконных функций добавьте вычисляемые колонки согласно условиям:
--	Пронумеруйте все платежи от 1 до N по дате
--	Пронумеруйте платежи для каждого покупателя, сортировка платежей должна быть по дате
--	Посчитайте нарастающим итогом сумму всех платежей для каждого покупателя, сортировка должна быть сперва по дате платежа, а затем по сумме платежа от наименьшей к большей
--	Пронумеруйте платежи для каждого покупателя по стоимости платежа от наибольших к меньшим так, чтобы платежи с одинаковым значением имели одинаковое значение номера.
-- Можно составить на каждый пункт отдельный SQL-запрос, а можно объединить все колонки в одном запросе.


SELECT customer_id, payment_id, payment_date, row_number() over (order by payment_date) as "Номер платежа по дате",
	row_number() over (partition by customer_id order by payment_date) as "Номер платежа покупателя по дате",
	sum(p.amount) over (partition by p.customer_id order by p.payment_date),
	dense_rank() over (partition by p.customer_id order by amount desc)
FROM payment p
order by customer_id, dense_rank


--ЗАДАНИЕ №2
-- С помощью оконной функции выведите для каждого покупателя стоимость платежа 
-- и стоимость платежа из предыдущей строки со значением по умолчанию 0.0 с сортировкой по дате.


 select customer_id, payment_id, payment_date, amount,
 	lag(p.amount,1,0.) over (partition by customer_id order by p.payment_date)
 from payment p
 order by customer_id



--ЗАДАНИЕ №3
-- С помощью оконной функции определите, на сколько каждый 
-- следующий платеж покупателя больше или меньше текущего.
 
 
select customer_id, payment_id, payment_date, amount,
	amount - lead(p.amount,1,0.) over (partition by customer_id  order by p.payment_date, customer_id) as difference
from payment p


--ЗАДАНИЕ №4
-- С помощью оконной функции для каждого покупателя выведите данные о его последней оплате аренды.


select customer_id, payment_id, payment_date, last_value
from(
	select customer_id, payment_id, payment_date,
		last_value(amount) over (partition by customer_id order by payment_date desc),
		row_number() over (partition by customer_id order by payment_date desc) 
	from payment) p 
where row_number = 1