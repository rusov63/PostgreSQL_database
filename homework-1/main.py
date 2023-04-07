import psycopg2

conn = psycopg2.connect(
    host='localhost',
    database='north',
    user='postgres',
    password='F9-00-4A-77-5E-3C')

try:
    with conn:
        with conn.cursor() as cur:
            #cur.executemany('insert into employees values (%s, %s)',[(1, 'Ivanov S.V'), (2, 'Petrova V.V')])
            # cur.executemany('insert into customers values (%s, %s, %s, %s)', [(1, 'Sidorova S.P', '892588', 'smile.jpg'),
            #                                                               (2, 'Petrova V.V', '58888', 'smile.jpg'),
            #                                                               (3, 'Lerova C.C.', '84156', 'smile.jpg')])
            # cur.executemany('insert into orders values (%s, %s, %s, %s)',[(1, 1, 'колбаса вареная', 2),
            #                                                                  (2, 1, 'сыр Российский', 3),
            #                                                               (3, 1, 'шоколад', 1)])

            cur.execute('select * from customers')

            rows=cur.fetchall()
            for row in rows:
                print(row)
finally:
    conn.close()