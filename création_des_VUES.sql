CREATE VIEW rapport_totaux_vente_par_année AS 
SELECT YEAR(InvoiceDate) as year, SUM(Total) as total_invoice_2021 
FROM invoice
GROUP BY YEAR(InvoiceDate);

CREATE VIEW nombre_facture_par_pays AS
SELECT BillingCountry, COUNT(*) 
FROM invoice
GROUP BY BillingCountry
ORDER BY COUNT(*) DESC;

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

CREATE VIEW rapport_vente_total_par_pays AS
SELECT BillingCountry, SUM(Total) as total_buy
FROM invoice
GROUP BY BillingCountry
ORDER BY total_buy DESC;