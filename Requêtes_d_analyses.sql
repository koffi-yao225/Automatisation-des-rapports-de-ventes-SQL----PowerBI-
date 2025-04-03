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




