CREATE SCHEMA superstore;
USE superstore;

/* Description of the dataset 
1. cust_dimen: Having all data of customers
	i) Customer_Name (TEXT): Name of the customers
	ii) Province (TEXT): Province of the customers
	iii) Region (TEXT): Region of the customers
	iv) Customer_Segment (TEXT): Segment from where the customer buy products
	v) Cust_id (TEXT): Unique Customer ID
    
2. market_fact: Details of every order sold
    i) Ord_id (TEXT): unique id of orders  
	ii) Prod_id (TEXT): unique id of products
	iii) Ship_id (TEXT): unique id of shipments
	iv) Cust_id (TEXT): unique id of the Customers 
	v) Sales (DOUBLE): Sales of the Items sold
	vi) Discount (DOUBLE): Discount on the Items sold
	vii) Order_Quantity (INT):  Quantity of the Items ordered
	viii) Profit (DOUBLE): Profit from the Items sold
	ix) Shipping_Cost (DOUBLE): Shipping Cost of the Items sold
	x) Product_Base_Margin (DOUBLE): Profit margin on the base of manufacturing cost Item sold
    
3. orders_dimen: Details of every order placed
	i) Order_ID (INT): Unque id of the Orders 
	ii) Order_Date (TEXT): Date of orders
	iii) Order_Priority (TEXT): Priority of the Orders
	iv) Ord_id (TEXT): Unique Order ID

4. prod_dimen: Details of product, category and sub category
	i)  Product_Category (TEXT): Category of the products
	ii) Product_Sub_Category (TEXT): Sub Category of the products
	iii) Prod_id (TEXT): Unique Product ID  
    
5. shipping_dimen: Details of shipping of orders
		
	i)  Order_ID (INT):  Unique Order ID
	ii)  Ship_Mode (TEXT): Modes of shipping
	iii)  Ship_Date (TEXT): Dates of shipping
	iv)  Ship_id (TEXT): Unique Shipment ID  */
    
/* Primary Keys and Foreign Keys for this dataset */

/*1. cust_dimen:
	i)Primary Key: cust_id
	ii) Foreign Key: Not Present   
    
   2. market_fact:
	i) Primary Key: Not Present 
	ii) Foreign Key: ord_id, prod_id, ship_id, cust_id 
    
   3. orders_dimen:
	A) Primary Key: ord_id
	B) Foreign Key: Not Present
    
   4. prod_dimen:
		A) Primary Key: prod_id, product_Sub_Category
        B) Foreign Key: Not Present
   
   5. shipping_dimen:
		A) Primary Key: ship_id
        B) Foreign Key: Not Present        */ 


/* 1. TABLE 1 Customer Dimension */
CREATE TABLE cust_dimen(
       customer_name VARCHAR(30),
       province VARCHAR(30),
       region VARCHAR(30),
       customer_segment VARCHAR(30),
       cust_id VARCHAR(20),
       PRIMARY KEY(cust_id)
       );


/* TABLE 2 Market Fact */       
CREATE TABLE market_fact(
       ord_id VARCHAR(30),
       prod_id VARCHAR(30),
       ship_id VARCHAR(30),
       cust_id VARCHAR(30),
       sales DOUBLE,
       discount DOUBLE,
       order_quantity int,
       profit DOUBLE,
       shipping_cost DOUBLE,
       product_base_margin DOUBLE
       );

      
       
       
    

/* TABLE 3 Order Dimension */
CREATE TABLE orders_dimen(
       order_id int,
       order_date date,
       order_priority VARCHAR(20),
       ord_id VARCHAR(30),
       PRIMARY KEY(order_id)
       );
      
DROP TABLE order_dimen;
/* TABLE 4 Product Dimension */
CREATE TABLE prod_dimen(
	   product_category VARCHAR(30),
       product_sub_category VARCHAR(30),
       prod_id VARCHAR(20),
       PRIMARY KEY(prod_id, product_sub_category)
       );
       


/* TABLE 5 Shipping Dimension */
CREATE TABLE shipping_dimen(
       order_id int,
       ship_mode VARCHAR(25),
       ship_date date,
       ship_id VARCHAR(25),
       PRIMARY KEY(ship_id)
       );
  
  
  /* 1. Write a query to display the Customer_Name and Customer Segment using alias name “Customer Name", "Customer Segment" from table Cust_dimen. */

SELECT * FROM cust_dimen;
 
SELECT customer_name AS 'Customer Name',
        customer_segment AS 'Customer Segment'
FROM cust_dimen; 

/* 2. Write a query to find all the details of the customer from the table cust_dimen order by desc. */
SELECT * FROM cust_dimen
ORDER BY customer_name DESC; 

/* 3. Write a query to get the Order ID, Order date from table orders_dimen where ‘Order Priority’ is high. */
SELECT * FROM orders_dimen;

SELECT order_id AS 'Order ID',
       order_date AS 'Order Date'
FROM orders_dimen
WHERE order_priority LIKE '%HIGH%';    

/* 4. Find the total and the average sales (display total_sales and avg_sales) */   

SELECT * FROM market_fact;

SELECT ROUND(SUM(sales),3) AS total_sales,
       ROUND(AVG(sales),3) AS avg_sales
FROM market_fact;       

/* 5. Write a query to get the maximum and minimum sales from maket_fact table. */
SELECT MAX(sales) AS 'maximum sales',
       MIN(sales) AS 'minimum sales'
FROM market_fact;    

/* 6. Display the number of customers in each region in decreasing order of no_of_customers. The result should contain columns Region, no_of_customers. */   
SELECT * FROM orders_dimen;
SELECT * FROM cust_dimen;

SELECT region, 
       count(customer_name) AS no_of_customers
FROM cust_dimen
GROUP BY region
ORDER BY count(customer_name) DESC;

/* 7. Find the region having maximum customers (display the region name and max(no_of_customers) */

SELECT region,
	   COUNT(customer_name) AS 'max(no_of_customers)'
FROM cust_dimen
GROUP BY region
ORDER BY COUNT(customer_name) DESC
LIMIT 1;     

/* 
8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’
and the number of tables purchased (display the customer name, no_of_tables
purchased) */

SELECT * FROM market_fact;
SELECT * FROM cust_dimen;
SELECT * FROM prod_dimen;


SELECT customer_name, count(*) AS number_of_tables
FROM
    market_fact AS m,
    cust_dimen AS c,
    prod_dimen AS p
WHERE 
	m.cust_id = c.cust_id
AND m.prod_id = p.prod_id
AND p.product_sub_category = 'TABLES'
AND c.region = 'ATLANTIC'
GROUP BY customer_name
ORDER BY number_of_tables DESC;

/* 9. Find all the customers from Ontario province who own Small Business. (display
the customer name, no of small business owners) */

SELECT customer_name
FROM cust_dimen
WHERE province LIKE 'ONTARIO'
 AND  customer_segment LIKE 'SMALL BUSINESS'
GROUP BY customer_name; 

/* 10. Find the number and id of products sold in decreasing order of products sold
(display product id, no_of_products sold) */
SELECT * FROM market_fact;

SELECT prod_id as 'product id',
       COUNT(*) as no_of_products_sold
FROM market_fact
GROUP BY prod_id
ORDER BY no_of_products_sold DESC; 

/* 11. Display product Id and product sub category whose product category belongs to
Furniture and Technology. The result should contain columns product id, product
sub category. */
SELECT prod_id AS 'product id',
       product_sub_category as 'product sub category'
FROM prod_dimen
WHERE 
     product_category IN ('FURNITURE','TECHNOLOGY');
     
/* 12. Display the product categories in descending order of profits (display the product
category wise profits i.e. product_category, profits)? */ 

SELECT * FROM market_fact; 
SELECT * FROM prod_dimen;   

SELECT product_category, ROUND(SUM(profit),3) AS profits
FROM 
    market_fact AS M
    INNER JOIN
    prod_dimen AS P
    ON M.prod_id = P.prod_id
GROUP BY product_category
ORDER BY profits DESC;    

/* 13. Display the product category, product sub-category and the profit within each subcategory in three columns. */
SELECT * FROM prod_dimen;
SELECT * FROM market_fact;

SELECT P.product_category AS 'product category',
       P.product_sub_category AS 'product sub-category',
       ROUND(SUM(M.profit),2) AS profits
FROM 
       market_fact AS M 
       LEFT JOIN
       prod_dimen AS P
       ON M.prod_id = P.prod_id
GROUP BY P.product_category, P.product_sub_category; 

/* 14. Display the order date, order quantity and the sales for the order.  */
SELECT * FROM orders_dimen;      
SELECT * FROM market_fact;

SELECT O.order_date 'order date', 
       M.order_quantity AS 'order quantity', 
	   M.sales AS sales
FROM 
       orders_dimen AS O
       LEFT JOIN
       market_fact AS M
       ON O.ord_id = M.ord_id;
       
/* 15. Display the names of the customers whose name contains the
i) Second letter as ‘R’
ii) Fourth letter as ‘D’  */
  
/* i)   Second letter as ‘R’ */
SELECT * FROM cust_dimen;

SELECT customer_name
FROM cust_dimen
WHERE customer_name LIKE '_R%';       
 
/* ii) Fourth letter as ‘D’  */
SELECT customer_name
FROM cust_dimen
WHERE customer_name LIKE '___D%'; 

/* 16. Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and their region where sales are between 1000 and 5000. */
SELECT * FROM cust_dimen;
SELECT * FROM market_fact;

SELECT M.cust_id AS 'customer id',
       SUM(M.sales) AS sales,
	   C.customer_name AS 'CUSTOMER NAME',
       C.region AS region
FROM market_fact AS M 
     LEFT JOIN
     cust_dimen AS C
     ON M.cust_id = C.cust_id
GROUP BY M.cust_id     
HAVING sales BETWEEN 1000 AND 5000;     

/* 17. Write a SQL query to find the 3rd highest sales.  */

SELECT * FROM market_fact
WHERE sales < (SELECT MAX(sales)
               FROM 
               market_fact
               WHERE sales < (SELECT 
               MAX(sales)
               FROM market_fact))
ORDER BY sales DESC
LIMIT 1;               

/* 18. Where is the least profitable product subcategory shipped the most? For the least
profitable product sub-category, display the region-wise no_of_shipments and the 
profit made in each region in decreasing order of profits (i.e. region, no_of_shipments, profit_in_each_region) */

SELECT * FROM market_fact;
SELECT * FROM cust_dimen;    
SELECT * FROM shipping_dimen;
SELECT * FROM prod_dimen;

SELECT 
    C.region,
    COUNT(DISTINCT s.ship_id) AS no_of_shipments,
    SUM(M.profit) AS profit_in_each_region
FROM
    market_fact AS M
        INNER JOIN
    cust_dimen AS C ON M.cust_id = C.cust_id
        INNER JOIN
    shipping_dimen AS S ON M.ship_id = S.ship_id
        INNER JOIN
    prod_dimen P ON M.prod_id = P.prod_id
WHERE
    P.product_sub_category IN (SELECT 
            P.product_sub_category
        FROM
            market_fact M
                INNER JOIN
            prod_dimen P ON M.prod_id = P.prod_id
        GROUP BY P.product_sub_category
        HAVING SUM(M.profit) <= ALL (SELECT 
                SUM(M.profit) AS profits
            FROM
                market_fact M
                    INNER JOIN
                prod_dimen P ON M.prod_id = P.prod_id
            GROUP BY P.product_sub_category))
GROUP BY C.region
ORDER BY profit_in_each_region DESC;
     


 

    