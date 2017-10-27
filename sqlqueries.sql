-- 1. non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
select CustomerId, FirstName, LastName, Country
from Customer
where Country != 'USA'

-- 2. brazil_customers.sql: Provide a query only showing the Customers from Brazil.
select CustomerId, FirstName, LastName, Country
from Customer
where Country = 'Brazil'

-- 3. brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
select c.FirstName, c.LastName, i.InvoiceId, i.InvoiceDate, i.BillingCountry
from  Customer c, Invoice i
where c.Country = 'Brazil' and c.CustomerId = i.CustomerId

-- 4. sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.
select *
from Employee e
where e.Title = 'Sales Support Agent'

-- 5. unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.
select i.BillingCountry
from Invoice i
group by i.BillingCountry

-- 6. sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
select i.InvoiceId, e.FirstName, e.LastName
from Employee e, Invoice i, Customer c
where c.SupportRepId = e.EmployeeId and i.CustomerId = c.CustomerId
order by e.EmployeeId, i.InvoiceDate desc

-- 7. invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
select i.Total, c.FirstName 'Customer First Name', c.LastName 'Customer Last Name', i.BillingCountry, e.FirstName 'Agent First Name', e.LastName 'Agent Last Name'
from Invoice i, Customer c, Employee e
where i.CustomerId = c.CustomerId and c.SupportRepId = e.EmployeeId
order by i.InvoiceId

-- 8. total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?
select strftime('%Y', i.InvoiceDate) 'Year', count(*)
from Invoice i
where strftime('%Y', i.InvoiceDate) = '2009' or strftime('%Y', i.InvoiceDate) = '2011'
group by strftime('%Y', i.InvoiceDate)

-- 9. total_sales_{year}.sql: What are the respective total sales for each of those years?
select strftime('%Y', i.InvoiceDate) 'Year', count(*) 'Number', sum(i.Total) 'Amount'
from Invoice i
where strftime('%Y', i.InvoiceDate) = '2009' or strftime('%Y', i.InvoiceDate) = '2011'
group by strftime('%Y', i.InvoiceDate)

-- 10. invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
select il.InvoiceId, count(*) 'Number Line Items'
from InvoiceLine il
where il.InvoiceId = '37'

-- 11. line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY
select il.InvoiceId, count(*) 'Number Line Items'
from InvoiceLine il
group by il.InvoiceId

-- 12. line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.
select il.*, t.Name
from InvoiceLine il, Track t
where t.TrackId = il.TrackId

-- 13. line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.
select il.*, t.Name 'Track Name', a.Name 'Artist Name'
from InvoiceLine il, Track t, Artist a, Album al
where t.TrackId = il.TrackId and al.ArtistId = a.ArtistId and t.AlbumId = al.AlbumId

-- 14. country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY
select i.BillingCountry 'Country', count(*) 'Number Invoices'
from Invoice i
group by i.BillingCountry

-- 15. playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.
select p.Name 'Playlist', count(*) 'Number Tracks'
from Playlist p, Track t, PlaylistTrack pl
where p.PlaylistId = pl.PlaylistId and t.TrackId = pl.TrackId
group by p.PlaylistId 

-- 16. tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.
select t.Name 'Track Name', al.Title 'Album Title', mt.Name 'MediaType', g.Name 'Genre'
from Track t, Album al, MediaType mt, Genre g
where t.AlbumId = al.AlbumId and t.MediaTypeId = mt.MediaTypeId and t.GenreId = g.GenreId

-- 17. invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.
from Invoice i, InvoiceLine il
where i.Invoiceid = il.InvoiceId
group by i.InvoiceId

-- 18. sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.
select e.FirstName, e.LastName, count(*) 'Total Sales'
from Employee e, Customer c, Invoice I
where e.EmployeeId = c.SupportRepId and c.CustomerId = i.CustomerId
group by e.EmployeeId

-- 19. top_2009_agent.sql: Which sales agent made the most in sales in 2009?
select e.FirstName, e.LastName, count(*) 'Total Sales' 
from Employee e, Customer c, Invoice I 
where e.EmployeeId = c.SupportRepId and c.CustomerId = i.CustomerId and strftime('%Y', i.InvoiceDate) = '2009'
group by e.EmployeeId 
order by count(*) desc limit 1

-- 20. top_agent.sql: Which sales agent made the most in sales over all?
select e.FirstName, e.LastName, sum(i.Total) 'Total Sales' 
from Employee e, Customer c, Invoice I 
where e.EmployeeId = c.SupportRepId and c.CustomerId = i.CustomerId and strftime('%Y', i.InvoiceDate) = '2009'
group by e.EmployeeId 
order by sum(i.Total) desc limit 1

-- 21. sales_agent_customer_count.sql: Provide a query that shows the count of customers assigned to each sales agent.
select e.FirstName, e.LastName, count(*) 'Customers'
from Employee e, Customer c
where e.EmployeeId = c.SupportRepId
group by e.EmployeeId

-- 22. sales_per_country.sql: Provide a query that shows the total sales per country.
select i.BillingCountry 'Country', sum(i.Total) 'Total Sales'
from Invoice i
group by i.BillingCountry

-- 23. top_country.sql: Which country's customers spent the most?
from Invoice i
group by i.BillingCountry
order by sum(i.Total) desc limit 1

-- 24. top_2013_track.sql: Provide a query that shows the most purchased track of 2013.

-------------------------------------------------------
-- This one is dumb. Any track was only purchased once
-------------------------------------------------------
select t.Name 'Track', count(*) 'Purchases'
from Track t, Invoice I, InvoiceLine il
where t.TrackId = il.TrackId and i.InvoiceId = il.InvoiceId and strftime('%Y', i.InvoiceDate) = '2013'
group by t.TrackId
order by count(*) desc limit 1

-- 25. top_5_tracks.sql: Provide a query that shows the top 5 most purchased tracks over all.

---------------------------------------------------------
-- Same with this one. Nothing purchased more than twice
---------------------------------------------------------
select t.Name 'Track', count(*) 'Purchases'
from Track t, Invoice I, InvoiceLine il
where t.TrackId = il.TrackId and i.InvoiceId = il.InvoiceId 
group by t.TrackId
order by count(*) desc limit 5

-- 26. top_3_artists.sql: Provide a query that shows the top 3 best selling artists.
select a.Name 'Artist', count(*) 'Tracks Sold'
from InvoiceLine il, Artist a, Track t, Album al
where a.ArtistId = al.ArtistId and t.AlbumId = al.AlbumId and t.TrackId = il.TrackId
group by a.ArtistId
order by count(*) desc limit 3

-- 27. top_media_type.sql: Provide a query that shows the most purchased Media Type.
select mt.Name, count(*) 'Purchased'
from InvoiceLine il, MediaType mt, Track t
where il.TrackId = t.TrackId and t.MediaTypeId = mt.MediaTypeId
group by mt.MediaTypeId
order by count(*) desc limit 1





