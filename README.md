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
- Dropped the 'email' column. It wasn't used in any of the analysis questions and the values were formatted in a sequential pattern ('user1@example.com', 'user2@example.com') instead of real data.
- Dropped the two empty unnamed columns that appeared after the data was imported.
- Relabeled the '???' values in the 'gender' column to 'Unknown'. Renamed instead of dropping the rows because that action would take away valid data from the 'age' and 'city' columns, which are used in the analysis.
- Confirmed that 'customer_id', 'age', and 'city' all had proper data types and values.

### Product
- Filled missing values in the 'color' column with 'Unknown'. Did not drop the rows with missing values because they contain valid information in other categories that are part of the analysis.
- Relabeled the '???' values in the 'category' column to 'Unknown'. Renamed instead of dropping the rows because 'category' is used in the analysis and dropping these rows would take away valid data from the other columns also used in the analysis.
- Confirmed that the other columns all had proper data types and values.

### Store
- Changed the 'store_size_m2' for the 'Online' store to 0 sq meters. Online stores don't take up physical space like regular stores, so 0 sq meters is the logical size.
- Confirmed that the other columns all had proper data types and values.

### Sales
- Filled missing values in the 'customer_id' column with 'Guest'. Missing customer id indicates a user that is not signed into an account, so they make their purchase as a guest. Did not drop the rows with missing values because they contain valid information in other categories that are part of the analysis.
- Filled missing values in the 'discount' column with 0. Missing discount indicates no discount was applied in the purchase. Did not drop the rows with missing values because they contain valid information in the other categories that are part of the analysis.
- Changed the 'date' column data type to datetime instead of object, which allows us to extract the day, month, or year. Also allows us to sort dates chronologically, whereas with the string data type we could only sort alphabetically.
- Identified two placeholder reference values that don't appear in their dimension tables. 'P999999' had 200 rows in the sales table but does not appear in the product table. 'S999' also had 200 rows in the sales table but does not appear in the store table. While it seems the 200 rows for each of these placeholders would be related, there is only 1 row of overlap. These rows were kept as valid transactions, but will be excluded in any analysis that would perform an inner join on the product or store table.
- Changed the 'returned' column data type to bool instead of a numeric 0/1. This ensures filtering and distinction is more reliable.