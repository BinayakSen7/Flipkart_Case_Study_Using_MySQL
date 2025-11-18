create database Flipkart_Case_Study;
use Flipkart_Case_Study;

create table Customers(
customer_id int primary key,
name varchar(100),
city varchar(50),
email varchar(100));

create table Sellers(
seller_id int primary key,
seller_name varchar(100),
rating decimal(3,1));

create table Products(
product_id int primary key,
product_name varchar(100),
category varchar(50),
price decimal(10,2),
seller_id int,
foreign key(seller_id) references Sellers(seller_id));

create table Orders(
order_id int primary key,
customer_id int,
product_id int,
order_date date,
quantity int,
foreign key(customer_id) references Customers(customer_id),
foreign key(product_id) references Products(product_id));

create table Offers(
offer_id int primary key,
product_id int,
discount_percent decimal(5,2),
offer_name varchar(100),
foreign key(product_id) references Products(product_id));

insert into Customers(customer_id,name,city,email) values
(1, 'Amit Sharma', 'Delhi', 'amit@gmail.com'), 
(2, 'Neha Verma', 'Mumbai', 'neha@gmail.com'), 
(3, 'Rahul Mehta', 'Bangalore', 'rahul@gmail.com'); 


insert into Sellers(seller_id,seller_name,rating) values
(201, 'ElectroWorld', 4.5), 
(202, 'FashionHub', 4.2), 
(203, 'StyleMart', 4.0); 


insert into Products(product_id,product_name,category,price,seller_id) values
(101, 'iPhone 15', 'Electronics', 80000.00, 201), 
(102, 'Nike Shoes', 'Fashion', 5000.00, 202), 
(103, 'Samsung TV', 'Electronics', 60000.00, 201), 
(104, 'Kurta Set', 'Clothing', 2000.00, 203); 

insert into Orders(order_id,customer_id,product_id,order_date,quantity) values
(301, 1, 101, '2025-09-15', 1), 
(302, 2, 102, '2025-09-16', 2), 
(303, 3, 103, '2025-09-16', 1), 
(304, 1, 104, '2025-09-17', 3); 

insert into offers(offer_id,product_id,discount_percent,offer_name) values
(401, 101, 10, 'Diwali Mega Offer'), 
(402, 102, 20, 'Festive Fashion Sale'), 
(403, 104, 15, 'Ethnic Wear Discount'); 

-- List all sellers and their products 
select s.seller_name ,p.product_name,p.category from Sellers s
join Products p on s.seller_id = p.seller_id;

-- Show all products with Diwali offers and final price 
select p.product_name,p.price,o.discount_percent,
(p.price - (p.price * o.discount_percent/100)) as final_price
from Products p join Offers o on p.product_id = o.product_id;

--  Find top-selling category in Diwali week
select p.category,sum(o.quantity) as total_quantity from Orders o
join Products p on o.product_id = p.product_id
where o.order_date between '2025-09-15' and '2025-09-20'
group by p.category order by total_quantity desc limit 1;

--  Find seller with highest revenue
select s.seller_name,sum(p.price * o.quantity) as revenue from Sellers s 
join Products p on s.seller_id = p.seller_id join Orders o on p.product_id = o.product_id
group by s.seller_name order by revenue desc limit 1;

--  Which customer spent the most money?
select c.name,sum(p.price * o.quantity) as total_spent from Customers c
join Orders o on c.customer_id = o.customer_id join Products p on o.product_id = p.product_id 
group by c.name order by total_spent desc limit 1;

--  List all customers and the products they purchased. 
select c.name,p.product_name from Customers c join Orders o on c.customer_id = o.customer_id join Products p on o.product_id = p.product_id;

--  Find the average rating of sellers
select avg(rating)as Avg_rating from sellers;
select seller_name,avg(rating) as Avg_rating from sellers group by seller_name;

--  Which seller sold the maximum number of products?
select s.seller_name,sum(o.quantity) as total_sold from Orders o join products p on o.product_id =p.product_id 
join Sellers s on p.seller_id = s.seller_id group by s.seller_name order by total_sold desc limit 1;

-- Show all products with no Diwali offers. 
select p.product_name ,o.offer_name from products p join offers o on p.product_id = o.product_id where offer_name ='Diwali Mega Offer';

-- Which product generated maximum revenue after discount? 
select p.product_name,sum((p.price -(p.price * o.discount_percent/100)) * ord.quantity) as total_revenue from products p
join offers o on p.product_id = o.product_id join Orders ord on p.product_id = ord.product_id group by p.product_name order by total_revenue desc limit 1;

--  Show the top 2 customers based on spending. 
select c.name,sum(p.price * o.quantity) as total_spent from Orders o
join Customers c on o.customer_id = c.customer_id
join Products p on o.product_id =p.product_id group by c.name order by total_spent desc limit 2;

--  Find the total revenue generated per category.
select p.category,sum(p.price * o.quantity) as total_revenue

 from Products p join Orders o on p.product_id = o.product_id group by p.category; 

-- List all sellers who offered discounts greater than 10%.
select distinct s.seller_name from Sellers s join Products p on s.seller_id = p.seller_id join Offers o on p.product_id = o.product_id
where o.discount_percent > 10;
-- Display the product-wise sales quantity along with seller name. 
select p.product_name,s.seller_name,sum(o.quantity) as total_quantity_sold from Orders o
join Products p on o.product_id = p.product_id join Sellers s on p.seller_id =s.seller_id
group by p.product_name,s.seller_name;
-- Find city-wise total orders placed. 
select c.city, count(o.order_id) as total_orders from Orders o join Customers c on o.customer_id = c.customer_id group by city;






