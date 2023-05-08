ЗАДАНИЕ №1
--База данных: если подключение к облачной базе, то создаёте новую схему с префиксом в --виде фамилии, название должно быть на латинице в нижнем регистре и таблицы создаете --в этой новой схеме, если подключение к локальному серверу, то создаёте новую схему и --в ней создаёте таблицы.

--Спроектируйте базу данных, содержащую три справочника:
--· язык (английский, французский и т. п.);
--· народность (славяне, англосаксы и т. п.);
--· страны (Россия, Германия и т. п.).
--Две таблицы со связями: язык-народность и народность-страна, отношения многие ко многим. Пример таблицы со связями — film_actor.
--Требования к таблицам-справочникам:
--· наличие ограничений первичных ключей.
--· идентификатору сущности должен присваиваться автоинкрементом;
--· наименования сущностей не должны содержать null-значения, не должны допускаться --дубликаты в названиях сущностей.
--Требования к таблицам со связями:
--· наличие ограничений первичных и внешних ключей.

--В качестве ответа на задание пришлите запросы создания таблиц и запросы по --добавлению в каждую таблицу по 5 строк с данными.




--СОЗДАНИЕ ТАБЛИЦЫ ЯЗЫКИ

 create table languages
 languages_id serial primary key, 
 languages_name varchar(50) not null unique


--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ ЯЗЫКИ

insert into languages(languages_name)
values ('Английский'), ('Французкий'), ('Русский'), ('Немецкий'), ('Испанский')

--СОЗДАНИЕ ТАБЛИЦЫ НАРОДНОСТИ

 create table nationalities
 nationalities_id serial primary key, 
 nationalities_name varchar(50) not null unique

--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ НАРОДНОСТИ

 insert into nationalities(nationalities_name)
 values ('Французы'), ('Англосаксы'), ('Немцы'), ('Испанцы'), ('Русские')



--СОЗДАНИЕ ТАБЛИЦЫ СТРАНЫ

  create table countries
 countries_id serial primary key, 
 country_name varchar(50) not null unique

--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ СТРАНЫ

insert into countries(countries_name)
 values ('Россия'), ('Испания'), ('Франция'), ('Германия'), ('Великобритания')

--СОЗДАНИЕ ПЕРВОЙ ТАБЛИЦЫ СО СВЯЗЯМИ

 create table languages_nationalities 
 languages_id int references languages(languages_id),
 nationalities_id int references nationalities(nationalities_id)
 primary key(languages_id, nationalities_id)
 
--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ СО СВЯЗЯМИ

insert into languages_nationalities(languages_id, nationalities_id)
 values ('1'), ('2'), ('3'), ('4'), ('5')
 ('2'), ('1'), ('5'), ('3'), ('4')

--СОЗДАНИЕ ВТОРОЙ ТАБЛИЦЫ СО СВЯЗЯМИ

 create table nationalities_countries 
 nationalities_id int references nationalities(nationalities_id),
 countries_id int references countries(countries_id)
 primary key(nationalities_id, countries_id)


--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ СО СВЯЗЯМИ

 create table nationalities_countries(nationalities_id, countries_id)
 values ('2'), ('1'), ('5'), ('3'), ('4')
 ('3'), ('5'), ('4'), ('2'), ('1')