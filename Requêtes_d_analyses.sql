-- 1) Clients non américains : Fournissez une requête affichant les Clients (leurs noms complets, ID client et pays) qui ne sont pas aux États-Unis.

SELECT CustomerId, FirstName, LastName, country
FROM customer
WHERE country != "USA";

-- 2) Clients brésiliens : Fournissez une requête affichant uniquement les Clients provenant du Brésil.

SELECT CustomerId, FirstName, LastName, country
FROM customer
WHERE country = "Brazil";

-- 3) Factures des clients brésiliens : Fournissez une requête affichant les factures des clients qui sont du Brésil.

SELECT * FROM invoice
WHERE CustomerId IN 
(SELECT CustomerId
FROM customer WHERE country = "Brazil");

-- 4) Agents de vente : Fournissez une requête affichant uniquement les employés qui sont des Agents de Vente

SELECT * FROM employee
WHERE Title = "Sales Support Agent";

-- 5) Pays uniques dans les factures : Fournissez une requête affichant une liste unique des pays de facturation présents dans la table Invoice.

SELECT DISTINCT(BillingCountry) FROM invoice
ORDER BY BillingCountry;

-- 6) Factures par agent de vente : Fournissez une requête affichant les factures associées à chaque agent de vente
-- Le tableau résultant doit inclure le nom complet de l'agent de vente.

SELECT SupportRepId, e.FirstName, e.LastName, i.InvoiceId, i.CustomerId, i.InvoiceDate, i.BillingAddress, i.BillingCity, i.BillingCountry, i.BillingPostalCode, i.Total
FROM invoice as i, (customer as c JOIN employee as e ON c.SupportRepId = e.EmployeeId)
WHERE i.CustomerId = c.CustomerId;

-- 7) Détails des factures : Fournissez une requête affichant le total de chaque facture, le nom du client, le pays et le nom de l'agent de vente.

SELECT c.FirstName, c.LastName, i.BillingCountry, SupportRepId, e.FirstName, e.LastName, i.Total
FROM invoice as i, (customer as c JOIN employee as e ON c.SupportRepId = e.EmployeeId)
WHERE i.CustomerId = c.CustomerId;

-- 8_a) Ventes par année : Combien de factures y a-t-il eu en 2021 et 2023 ?

SELECT COUNT(*) as nb_invoice_2021 FROM invoice 
WHERE YEAR(InvoiceDate) = 2021;

SELECT COUNT(*) as nb_invoice_2023 
FROM invoice 
WHERE YEAR(InvoiceDate) = 2023;

-- 8_b) Quels sont les montants totaux des ventes pour chacune de ces années ?

SELECT SUM(Total) as total_invoice_2021 
FROM invoice
WHERE YEAR(InvoiceDate) = 2021
GROUP BY YEAR(InvoiceDate);

SELECT SUM(Total) as total_invoice_2021 
FROM invoice
WHERE YEAR(InvoiceDate) = 2023
GROUP BY YEAR(InvoiceDate);

-- 9) Articles pour une facture donnée : Fournissez une requête comptant le nombre d'articles (line items) pour l'ID de facture 37.

SELECT InvoiceId, COUNT(Quantity) 
FROM invoiceline
WHERE InvoiceId = 37;

-- 10) Articles par facture : Fournissez une requête comptant le nombre d'articles (line items) pour chaque facture.

SELECT InvoiceId, COUNT(Quantity) 
FROM invoiceline
GROUP BY InvoiceId;

-- 11) Nom des morceaux : Fournissez une requête incluant le nom du morceau pour chaque ligne de facture.

SELECT i.InvoiceLineId, i.InvoiceId, i.TrackId, i.UnitPrice, i.Quantity, t.name 
FROM invoiceline as i JOIN track as t ON i.TrackId = t.TrackId;

-- 12) Morceaux et artistes : Fournissez une requête incluant le nom du morceau acheté ET le nom de l'artiste pour chaque ligne de facture.

SELECT i.InvoiceLineId, i.InvoiceId, i.TrackId, i.UnitPrice, i.Quantity, t.name, t.Composer 
FROM invoiceline as i JOIN track as t ON i.TrackId = t.TrackId;

-- 13) Nombre de factures par pays : Fournissez une requête affichant le nombre de factures par pays.

SELECT BillingCountry, COUNT(*) 
FROM invoice
GROUP BY BillingCountry;

-- 14) Nombre de morceaux par playlist : Fournissez une requête affichant le nombre total de morceaux dans chaque playlist. 
-- Le nom de la playlist doit être inclus dans le tableau résultant.

SELECT p.Name as playlist_name, COUNT(*) as nb_track
FROM playlist as p JOIN playlisttrack as pt ON p.PlaylistId = pt.PlaylistId
GROUP BY p.Name;

-- 15) Liste des morceaux : Fournissez une requête affichant tous les morceaux (Tracks), mais sans afficher les IDs.
-- Le tableau résultant doit inclure le nom de l'album, le type de média et le genre.

SELECT t.Name as name_track, a.Title as album_title, m.Name as mediatype_name, g.Name as genre_name 
FROM track as t 
JOIN album as a ON t.AlbumId = a.AlbumId 
JOIN mediatype as m ON t.MediaTypeId = m.MediaTypeId
JOIN genre as g ON t.GenreId = g.GenreId;

-- 16) Factures et articles : Fournissez une requête affichant toutes les factures, avec le nombre d'articles par facture.

-- Similaire à la question 10

-- 17) Ventes par agent de vente : Fournissez une requête affichant les ventes totales réalisées par chaque agent de vente.

SELECT e.FirstName, e.LastName, SUM(i.Total) as total_vente
FROM invoice as i JOIN customer as c ON i.CustomerId = c.CustomerId
JOIN employee as e ON c.SupportRepId = e.EmployeeId
GROUP BY e.FirstName, e.LastName;

-- 18) Meilleur agent de 2021 : Quel agent de vente a réalisé le plus de ventes en 2021 ?

-- Cette méthode est correcte mais n'est pas vraiment conseillé si on veux récuperer que le nom du vendeur
SELECT e.FirstName, e.LastName, SUM(i.Total) as total_vente
FROM invoice as i JOIN customer as c ON i.CustomerId = c.CustomerId
JOIN employee as e ON c.SupportRepId = e.EmployeeId
WHERE YEAR(i.InvoiceDate) = 2021
GROUP BY e.FirstName, e.LastName
ORDER BY total_vente DESC
LIMIT 1;

-- Opter plutôt pour celle-ci
SELECT e.FirstName, e.LastName
FROM invoice as i JOIN customer as c ON i.CustomerId = c.CustomerId
JOIN employee as e ON c.SupportRepId = e.EmployeeId
WHERE YEAR(i.InvoiceDate) = 2021
GROUP BY e.FirstName, e.LastName
HAVING SUM(i.Total) = (SELECT Max(T.total) FROM 
											(SELECT SUM(i.Total) as total 
											 FROM invoice as i JOIN customer as c ON i.CustomerId = c.CustomerId
											 JOIN employee as e ON c.SupportRepId = e.EmployeeId
											 WHERE YEAR(i.InvoiceDate) = 2021
											 GROUP BY e.FirstName, e.LastName) 
										as T);
                                        
-- 19) Meilleur agent de 2010 : Quel agent de vente a réalisé le plus de ventes en 2022 ?

SELECT e.FirstName, e.LastName
FROM invoice as i JOIN customer as c ON i.CustomerId = c.CustomerId
JOIN employee as e ON c.SupportRepId = e.EmployeeId
WHERE YEAR(i.InvoiceDate) = 2022
GROUP BY e.FirstName, e.LastName
HAVING SUM(i.Total) = (SELECT Max(T.total) FROM 
											(SELECT SUM(i.Total) as total 
											 FROM invoice as i JOIN customer as c ON i.CustomerId = c.CustomerId
											 JOIN employee as e ON c.SupportRepId = e.EmployeeId
											 WHERE YEAR(i.InvoiceDate) = 2022
											 GROUP BY e.FirstName, e.LastName) 
										as T);
                                        
-- 20) Meilleur agent global : Quel agent de vente a réalisé le plus de ventes en tout ?

SELECT e.FirstName, e.LastName
FROM invoice as i JOIN customer as c ON i.CustomerId = c.CustomerId
JOIN employee as e ON c.SupportRepId = e.EmployeeId
GROUP BY e.FirstName, e.LastName
HAVING SUM(i.Total) = (SELECT Max(T.total) FROM 
											(SELECT SUM(i.Total) as total 
											 FROM invoice as i JOIN customer as c ON i.CustomerId = c.CustomerId
											 JOIN employee as e ON c.SupportRepId = e.EmployeeId
											 GROUP BY e.FirstName, e.LastName) 
										as T);
                                        
-- 21) Clients par agent de vente : Fournissez une requête affichant le nombre de clients attribués à chaque agent de vente.

SELECT e.EmployeeId, e.FirstName, e.FirstName, COUNT(c.CustomerId) as nb_customer
FROM customer as c JOIN employee as e ON c.SupportRepId = e.EmployeeId
GROUP BY c.SupportRepId;

-- 22) Ventes totales par pays : Fournissez une requête affichant les ventes totales par pays. Quel pays a dépensé le plus ?

SELECT BillingCountry, SUM(Total) as total_buy
FROM invoice
GROUP BY BillingCountry
ORDER BY total_buy DESC;

-- Le pays à avoir éffectué le plus d'achat est l'USA

-- 23) Morceau le plus acheté en 2021 : Fournissez une requête affichant le morceau le plus acheté en 2013.

SELECT t.Name, SUM(il.Quantity) FROM invoice as i 
JOIN invoiceline as il ON i.InvoiceId = il.InvoiceId
JOIN track as t ON t.TrackId = il.TrackId
WHERE YEAR(i.InvoiceDate) = 2021
GROUP BY t.Name
ORDER BY SUM(il.Quantity) DESC;

-- le morceau le plus acheté en 2021 est Dazel and confused

-- 24) Top 5 des morceaux les plus achetés : Fournissez une requête affichant les 5 morceaux les plus achetés en tout.

SELECT t.Name, SUM(il.Quantity) FROM invoice as i 
JOIN invoiceline as il ON i.InvoiceId = il.InvoiceId
JOIN track as t ON t.TrackId = il.TrackId
GROUP BY t.Name
ORDER BY SUM(il.Quantity) DESC
LIMIT 5;

-- 25) Top 3 des artistes les plus vendus : Fournissez une requête affichant les 3 artistes les plus vendus.

SELECT t.Composer, SUM(il.Quantity) FROM invoice as i 
JOIN invoiceline as il ON i.InvoiceId = il.InvoiceId
JOIN track as t ON t.TrackId = il.TrackId
GROUP BY t.Composer
ORDER BY SUM(il.Quantity) DESC
LIMIT 4;

-- 26) Type de média le plus acheté : Fournissez une requête affichant le type de média le plus acheté

SELECT m.Name, SUM(il.Quantity) FROM invoice as i 
JOIN invoiceline as il ON i.InvoiceId = il.InvoiceId
JOIN track as t ON t.TrackId = il.TrackId
JOIN mediatype as m ON t.MediaTypeId = m.MediaTypeId
GROUP BY m.Name
ORDER BY SUM(il.Quantity) DESC;

-- 27) Genre de musique le plus acheté : Fournissez une requête affichant le genre de musique le plus acheté

SELECT g.Name, SUM(il.Quantity) FROM invoice as i 
JOIN invoiceline as il ON i.InvoiceId = il.InvoiceId
JOIN track as t ON t.TrackId = il.TrackId
JOIN genre as g ON t.GenreId = g.GenreId
GROUP BY g.Name
ORDER BY SUM(il.Quantity) DESC
LIMIT 6;

-- 28) Genre de musique les plus acheté par pays : Fournissez une requête affichant le genre de musique le plus acheté par pays
-- J'ai sélectionné les pays qui ont éffectué le plus de vente et les genres les plus vendus

SELECT i.BillingCountry, g.Name, SUM(il.Quantity) FROM invoice as i 
JOIN invoiceline as il ON i.InvoiceId = il.InvoiceId
JOIN track as t ON t.TrackId = il.TrackId
JOIN genre as g ON t.GenreId = g.GenreId
WHERE i.BillingCountry IN ("USA", "Canda", "Brazil", "France", "Germany") AND g.Name IN ("Rock", "Latin", "Metal", "Alternative & Punk", "Jazz", "Blues")
GROUP BY i.BillingCountry, g.Name
ORDER BY SUM(il.Quantity) DESC;
