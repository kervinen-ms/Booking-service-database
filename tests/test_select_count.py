import os
import pytest
from . import execute_sql_to_df
from . import read_sql


@pytest.fixture()
def select_script():
    path = os.getenv("SCRIPT_PATH")
    return read_sql(path)


@pytest.fixture()
def select_df(select_script, sqlalchemy_conn):
    return execute_sql_to_df(
        conn=sqlalchemy_conn,
        sql=select_script
    )


def test(select_df):
    assert select_df.query("table_name == 'theaters'")['cnt'].iloc[0] == 10
    assert select_df.query("table_name == 'auditoriums'")['cnt'].iloc[0] == 12
    assert select_df.query("table_name == 'movies'")['cnt'].iloc[0] == 18
    assert select_df.query("table_name == 'showtimes'")['cnt'].iloc[0] == 10
    assert select_df.query("table_name == 'seats'")['cnt'].iloc[0] == 76
    assert select_df.query("table_name == 'users'")['cnt'].iloc[0] == 10
    assert select_df.query("table_name == 'tariffs'")['cnt'].iloc[0] == 12
    assert select_df.query("table_name == 'reservations'")['cnt'].iloc[0] == 10
