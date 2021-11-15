import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

def create_database(db_name):
    con = psycopg2.connect(dbname='postgres',user='postgres', host='postgres', password='postgres')
    con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur = con.cursor()

    cur.execute(f"SELECT COUNT(*) = 0 FROM pg_catalog.pg_database WHERE datname = '{db_name}'")
    not_exists_row = cur.fetchone()
    not_exists = not_exists_row[0]
    if not_exists:
        cur.execute(f'CREATE DATABASE {db_name}')
        print(f'{db_name} database created')
    else:
        print(f'{db_name} database already exists')
    cur.close()
    con.close()
