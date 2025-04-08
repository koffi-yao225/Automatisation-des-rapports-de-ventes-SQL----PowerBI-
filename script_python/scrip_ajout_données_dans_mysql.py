from sqlalchemy import create_engine, Table, MetaData
from sqlalchemy.orm import sessionmaker


engine = create_engine("mysql+pymysql://user:password@host/db") # connexion à la base de données


metadata = MetaData()           # récupération des données
metadata.reflect(bind=engine)


genre_table = metadata.tables['genre']


Session = sessionmaker(bind=engine) # création d'une session
session = Session()


donnees = [
    {"GenreId": 30, "Name": "Rap_Ivoire_1X"}
]

# insertion
with engine.connect() as conn:
    conn.execute(genre_table.insert(), donnees)
    conn.commit()

print(f"{len(donnees)} lignes insérées dans la table 'genre'.")

session.close() # fin de la session

