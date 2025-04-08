CREATE VIEW rapport_totaux_vente_par_année AS 
SELECT YEAR(InvoiceDate) as year, SUM(Total) as total_invoice_2021 
FROM invoice
GROUP BY YEAR(InvoiceDate);

CREATE VIEW nombre_facture_par_pays AS
SELECT BillingCountry, COUNT(*) 
FROM invoice
GROUP BY BillingCountry
ORDER BY COUNT(*) DESC;

CREATE VIEW rapport_vente_total_par_pays AS
SELECT BillingCountry, SUM(Total) as total_buy
FROM invoice
GROUP BY BillingCountry
ORDER BY total_buy DESC;

CREATE VIEW vente_annuelle_par_agent_de_vente AS
SELECT YEAR(i.InvoiceDate), e.FirstName, e.LastName, SUM(i.Total) as total_vente
FROM invoice as i JOIN customer as c ON i.CustomerId = c.CustomerId
JOIN employee as e ON c.SupportRepId = e.EmployeeId
GROUP BY YEAR(i.InvoiceDate), e.FirstName, e.LastName
ORDER BY YEAR(i.InvoiceDate) ASC;

CREATE VIEW vente_totale_par_agent_de_vente AS
SELECT e.FirstName, e.LastName, SUM(i.Total) as total_vente
FROM invoice as i JOIN customer as c ON i.CustomerId = c.CustomerId
JOIN employee as e ON c.SupportRepId = e.EmployeeId
GROUP BY e.FirstName, e.LastName
ORDER BY total_vente DESC;

CREATE VIEW Genre_musique_les_plus_acheté_par_pays AS
SELECT i.BillingCountry, g.Name, SUM(il.Quantity) FROM invoice as i 
JOIN invoiceline as il ON i.InvoiceId = il.InvoiceId
JOIN track as t ON t.TrackId = il.TrackId
JOIN genre as g ON t.GenreId = g.GenreId
WHERE i.BillingCountry IN ("USA", "Canada", "Brazil", "France", "Germany") AND g.Name IN ("Rock", "Latin", "Metal", "Alternative & Punk", "Jazz", "Blues")
GROUP BY i.BillingCountry, g.Name
ORDER BY SUM(il.Quantity) DESC;

CREATE VIEW Genre_musique_les_plus_acheté AS
SELECT g.Name, SUM(il.Quantity) FROM invoice as i 
JOIN invoiceline as il ON i.InvoiceId = il.InvoiceId
JOIN track as t ON t.TrackId = il.TrackId
JOIN genre as g ON t.GenreId = g.GenreId
GROUP BY g.Name
ORDER BY SUM(il.Quantity) DESC
LIMIT 6;
