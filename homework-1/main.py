import csv
import os
import psycopg2
from psycopg2 import Error

try:
    with psycopg2.connect(
        host='localhost',
        database='north',
        user='postgres',
        password=os.getenv('PassSQL')
) as conn:
        print('База данных North успешно открыта')
        print("Информация о сервере PostgreSQL")
        print(conn.get_dsn_parameters(), "\n")

        with conn.cursor() as cur:
            file = open('north_data/employees_data.csv', 'r', encoding='utf-8')
            contents = csv.DictReader(file)
            for id, row in enumerate(contents, 1):
                cur.execute('insert into employees values (%s, %s, %s, %s, %s, %s)',
                            (id, row['first_name'], row['last_name'], row['title'], row['birth_date'], row['notes']))
        cur.close()
        print("Значения успешно добавлены в таблицу Employees в PostgreSQL")

        with conn.cursor() as cur:
            file = open('north_data/customers_data.csv', 'r', encoding='utf-8')
            contents = csv.DictReader(file)
            for row in contents:
                cur.execute('insert into customers values (%s, %s, %s)',
                                (row['customer_id'], row['company_name'], row['contact_name']))
        cur.close()
        print("Значения успешно добавлены в таблицу Customers в PostgreSQL")

        with conn.cursor() as cur:
            file = open('north_data/orders_data.csv', 'r', encoding='utf-8')
            contents = csv.DictReader(file)
            for row in contents:
                cur.execute('insert into orders values (%s, %s, %s, %s, %s)',
                                (row['order_id'], row['customer_id'], row['employee_id'], row['order_date'], row['ship_city']))
        cur.close()
        print("Значения успешно добавлены в таблицу Orders в PostgreSQL")

except (Exception, Error) as error:
    print("Ошибка при работе с PostgreSQL", error)
finally:
    if conn:
            conn.close()
            print("Соединение с PostgreSQL закрыто")