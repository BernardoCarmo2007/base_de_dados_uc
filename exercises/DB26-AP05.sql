use BikeStores;

-- 01

create table production.review_queue (product_id int NOT NULL, review_note nvarchar(200) NULL, 
score decimal NULL, review_date date not NULL);

-- 02 
ALTER table production.review_queue  add reviewer_code nvarchar(16) NULL;

-- 03

GO
create view production.vw_category_price_summary AS SELECT  category_id,
    COUNT(product_id) AS product_count,
    MIN(list_price) AS minimum_price,
    AVG(list_price) AS average_price
FROM 
    production.products
GROUP BY 
    category_id;
GO

-- 05- 
GO
Create NONCLUSTERED index indexi1 on production.review_queue (review_date ASC, product_id ASC);
GO