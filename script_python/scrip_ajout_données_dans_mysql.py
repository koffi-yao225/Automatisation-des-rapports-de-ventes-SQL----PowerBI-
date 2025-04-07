from sqlalchemy import create_engine, Table, MetaData
from sqlalchemy.orm import sessionmaker

# Connexion à la base MySQL (via PyMySQL)
engine = create_engine("mysql+pymysql://root:Bachelier2018@localhost/chinook")

# Récupération de la métadonnée existante
metadata = MetaData()
metadata.reflect(bind=engine)

# Récupération de la table existante
genre_table = metadata.tables['genre']

# Création d'une session
Session = sessionmaker(bind=engine)
session = Session()

# Données à insérer
donnees = [
    {"GenreId": 30, "Name": "Rap_Ivoire_X"}
]

# Exécution de l'insertion
with engine.connect() as conn:
    conn.execute(genre_table.insert(), donnees)
    conn.commit()

print(f"{len(donnees)} lignes insérées dans la table 'genre'.")

# Fermeture de la session
session.close()
