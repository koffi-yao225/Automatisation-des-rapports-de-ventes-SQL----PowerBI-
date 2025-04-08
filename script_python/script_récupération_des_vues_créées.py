import pandas as pd
import sqlalchemy


engine = sqlalchemy.create_engine("mysql+pymysql://user:password@host/db") # connexion à la base données

df = pd.read_sql("select * from ..................", engine) # requête afin de récupérer la VUE souhaitée

df.to_csv("fichier.csv",index=False) # enregistrement dans un csv


