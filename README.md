# retail-analysis

## Business Problem 
Which stores, products, and customer segments are driving vs. dragging down performance, and what changes to inventory, pricing, or store strategy could improve overall profitability?

### Business Questions
1. **Store performace**: Which store has the highest average transaction value (ATV), and how does this compare to its total profit?
2. **Returns**: Which product category has the highest return rate (returns / units sold), and does this correlate to the discount level, season mismatch, or size?
3. **Age Demographics**: Which product category has the highest share of each age groups overall purchases?
4. **Seasonality**: Which products sell the most units outside of their designated season, and by how much?
5. **Profitability**: Which products have the highest total profit, and which have the highest profit margin — do they overlap?


## Understanding the Data

### Customer (25,000 rows)
| Column | Data Type | Description |
| --- | --- | --- |
| customer_id | object | Unique identifier for each customer |
| age | numeric | Customer's age in years |
| gender | object | Customer's stated gender (Male, Female, Other, or ???) |
| city | object | Where the customer currently resides |
| email | object | Customer's email address |

**Observations**
- 496 rows (~2%) with missing email
- 2 unnamed columns when dataset was imported
- 298 rows (~1.2%) had a '???' placeholder value in the gender column instead of one of the expected categories (Male, Female, Other)

### Product (50,000 rows)
| Column | Data Type | Description |
| --- | --- | --- |
| product_id | object | Unique identifier for each product
| category | object | Product category (type of clothing item) |
| color | object | Product color |
| size | object | Product size |
| season | object | Product's designated season |
| supplier | object | Name of supplier that provides product |
| cost_price | numeric | Cost to the business to acquire/produce the product |
| list_price | numeric | Price the product is being sold to customers at |

**Observations**
- 990 rows (~2%) with missing color
- 499 rows (~1%) had a '???' placeholder value in the category column instead of an expected type of clothing

### Store (5 rows)
| Column | Data Type | Description |
| --- | --- | --- |
| store_id | object | Unique identifier for each store |
| store_name | object | Name of the store |
| region | object | Geographic location of the store |
| store_size_m2 | numeric | Store's floor area in square meters |

**Observations**
- Online store has a non-zero value for store size (area)

### Sales (50,000 rows)
| Column | Data Type | Description |
| --- | --- | --- |
| transaction_id | object | Unique identifier for each transaction | 
| date | object | Date the transaction occured | 
| product_id | object | References product table | 
| store_id | object | references store table | 
| customer_id | object | references customer table | 
| quantity | numeric | Number of units purchased in the transaction | 
| discount | numeric | Discount applied to the transaction (as a decimal) | 
| returned | numeric | Whether the transaction was later returned |

**Observations**
- 1,844 rows (~3.7%) with missing customer id
- 2,583 rows (~5.2%) with missing discount percentage
- 200 rows (0.4%) reference a product id ('P999999') not found in the product table
- 200 rows (0.4%) reference a store id ('S999') not found in the store table
- 1 transaction with overlap between these two nonexistent ids

## Data Cleaning

### Customer

### Product

### Store

### Sales
