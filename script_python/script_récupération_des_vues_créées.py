import pandas as pd
import sqlalchemy


engine = sqlalchemy.create_engine("mysql+pymysql://root:Bachelier2018@localhost/chinook")

df = pd.read_sql("select * from ...............", engine) # ecrire une requête afin de récupérer la VUE créée

df.to_csv("rapport_total_vente.csv",index=False) # enregistrer dns un csv