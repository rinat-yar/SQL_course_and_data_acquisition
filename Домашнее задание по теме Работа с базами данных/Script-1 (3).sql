*Задание 1

select distinct city 
from city c 

*Задание 2 * Исправил !!!!!

select distinct city 
from city c  
where city like 'L%a' and city not like 'La%a'
order by city 


*Задание 3

select payment_id, payment_date, amount 
from payment p 
where payment_date between '2005/06/17 00:00:00' and '2005/06/19 24:00:00'  and amount >1
order by payment_date 

--Здравствуйте можно будет вопрос по 3 заданию пытался сделать как лекции но все время выдает ошибку. Пробовал два варианта
--where payment_date::data  between '2005/06/17' and '2005/06/19'  and amount >1  - Ошибка
--where payment_date between '2005/06/17' and '2005/06/19' ::data + interval '1 day' and amount >1 - Ошибка


*Задание 4 * Исправил !!!!!!!

select payment_id, payment_date, amount 
from payment p 
order by payment_date desc 
limit 10

*Задание 5

select  concat(first_name,' ', last_name) as "Фамилия имя", email as "Электронная почта", char_length(email) as "Длина Email", last_update as "Дата"
from customer c 
-- Как убрать время совершенно не понимаю и не знаю. несколько раз пересмотрел лекции и материалы. Искал что ли похожее в интернете. Такой же отрицательный результат
--data() не понимаю как это использовать!!!!!


*Задание 6 * Исправлено!!!!!!

select lower(first_name) as first_name , lower(last_name) last_name , active
from customer c 
where  first_name = ('WILLIE') or first_name = ('KELLY') and active <=1








