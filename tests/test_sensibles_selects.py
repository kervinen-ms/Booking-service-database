import os
import pytest
import pandas as pd
from . import execute_sql_to_df
from . import read_sql


@pytest.fixture()
def select_script():
    path = os.getenv("SCRIPT_PATH")
    return read_sql(path)


@pytest.fixture()
def select_df(select_script, sqlalchemy_conn):
    dfs = []
    for script in select_script.split(';')[:-1]:
        dfs.append(execute_sql_to_df(conn=sqlalchemy_conn, sql=script))
    return dfs


def test_1(select_df):
    df = select_df[0]
    assert df['cnt'].iloc[0] == 4
    assert df['title'].is_monotonic


def test_2(select_df):
    df = select_df[1]
    assert df['cnt'].iloc[0] == 4


def test_3(select_df):
    df = select_df[2]
    assert df['sum'].iloc[0] == 1


def test_4(select_df):
    df = select_df[3]
    assert df.query("theater == 'Большой Экран'")['theater'].iloc[0] <= 3
    assert df.query("theater == 'Зеркало Кино'")['theater'].iloc[0] <= 3
    assert df.query("theater == 'Кинодром на Невском'")['theater'].iloc[0] <= 3
    assert df.query("theater == 'Современный'")['theater'].iloc[0] <= 3
    assert df.query("theater == 'Аврора'")['theater'].iloc[0] <= 3
    assert df.query("theater == 'Золотой Век'")['theater'].iloc[0] <= 3
    assert df.query("theater == 'Орбита'")['theater'].iloc[0] <= 3
    assert df.query("theater == 'Вечерний'")['theater'].iloc[0] <= 3
    assert df.query("theater == 'Хорошее Настроение'")['theater'].iloc[0] <= 3
    assert df.query("theater == 'Кинотеатр Звездный'")['theater'].iloc[0] <= 3


def test_5(select_df):
    df = select_df[4]
    assert select_df['title'].iloc[0] == 18


def test_6(select_df):
    df = select_df[5]
    assert df.query("differ < 0").iloc[0] == 0
