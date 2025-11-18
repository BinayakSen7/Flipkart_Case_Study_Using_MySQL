# Flipkart Case Study using MySQL

This project represents a MySQL-based case study inspired by Flipkart’s e-commerce ecosystem.  
It includes database schema creation, sample data insertion, and analytical SQL queries covering customers, sellers, products, orders, and offers.

---

## 📂 Database Structure

### 🧑‍🤝‍🧑 Customers  
- customer_id (PK)  
- name  
- city  
- email  

### 🏪 Sellers  
- seller_id (PK)  
- seller_name  
- rating  

### 📦 Products  
- product_id (PK)  
- product_name  
- category  
- price  
- seller_id (FK)

### 📜 Orders  
- order_id (PK)  
- customer_id (FK)  
- product_id (FK)  
- order_date  
- quantity  

### 🎁 Offers  
- offer_id (PK)  
- product_id (FK)  
- discount_percent  
- offer_name  

---

## 📥 Sample Data
Includes inserts for:
- 3 customers  
- 3 sellers  
- 4 products  
- 4 orders  
- 3 offers  

---

## 🔍 SQL Queries Included

### ✔ Sellers and their products  
```sql
select s.seller_name, p.product_name, p.category
from Sellers s
join Products p on s.seller_id = p.seller_id;

