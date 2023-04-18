-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
select first_name as Имя, last_name as Фамилия, customers.city as Город, shippers.company_name as Грузоотправитель
from orders
inner join customers using (customer_id)
inner join employees using (employee_id)
inner join shippers on ship_via=shipper_id
where shippers.company_name in ('United Package') and customers.city in ('London')

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
select product_name, units_in_stock, category_name, discontinued, contact_name, phone
from products
inner join categories using (category_id)
inner join suppliers using (supplier_id)
where discontinued != 1 and units_in_stock < 25 and category_name in ('Dairy Products', 'Condiments')
order by units_in_stock


-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select company_name
from customers
where not exists (Select company_name from orders
			  where customers.customer_id=orders.customer_id)

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
select distinct products.product_name, quantity
from products, order_details
where exists (select products.product_name, quantity from products
			 where order_details.product_id=products.product_id and
 			 quantity = 10)

-- Без внутреннего запроса, чезез JOIN
select products.product_name, quantity
from order_details
join products using (product_id)
where quantity = 10