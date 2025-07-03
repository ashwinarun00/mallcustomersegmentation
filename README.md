# Mall Customer Segmentation

## 📌 Project Objective

This project aims to segment mall customers of a shopping center in Myanamr into distinct groups based on their demographic and spending behavior.

---

## Methodology

**Unsupervised machine learning techniques**, primarily clustering algorithms, are used to analyze and group customers. The process includes data preprocessing, exploratory data analysis (EDA), feature scaling, dimensionality reduction (PCA), and KMeans clustering to identify similar performing groups within the data.

---

## Models Used

- **K-Means Clustering**: Partitioned customers into distinct clusters based on spending behavior and demographic features.
- **PCA (Principal Component Analysis)**: Reduced the dimensionality of features for better visualization and clustering performance.

---

## Data Description

The dataset `Mall_Customers.csv` contains information about 200 customers of a Myanmar shopping center. It captures the demographic and spending patterns using some of the following features:-

- **CustomerID**: Unique identifier for each customer.
- **Gender**: Gender of the customer (Male/Female).
- **Age**: Age of the customer in years.
- **Annual Income (k$)**: Annual income of the customer in thousands of dollars.
- **Spending Score (1-100)**: Score assigned by the mall based on customer behavior and spending nature.
- **Number of items bought**: Total number of items purchased in the transaction.
- **Invoice ID**: Unique identifier for the transaction invoice.
- **Branch**: Branch of the store where the transaction took place (e.g., A, B, C).
- **City**: City where the branch is located.
- **Customer type**: Classification of customer as Member or Normal.
- **Product line**: Category of products purchased (e.g., Fashion, Food, Health).
- **Unit price**: Price per unit of the product.
- **Quantity**: Number of units purchased.
- **Tax 5%**: 5% tax applied to the total cost.
- **Total**: Total amount paid, including tax.
- **Date**: Date of the transaction.
- **Time**: Time of the transaction.
- **Payment**: Payment method used (e.g., Cash, Credit Card, Ewallet).
- **cogs**: Cost of goods sold (before tax).
- **gross margin percentage**: Percentage of gross margin on the transaction.
- **gross income**: Gross income from the transaction (equal to tax).
- **Rating**: Customer rating of their experience (1 to 10).

---

## File Structure

- `Mall_Customers.csv`  
  The raw dataset used for analysis.

- `customersegmentation_mallcustomers.R`  
  A R script showcasing:
  - Data cleaning and preprocessing
  - Visualizations (distribution plots, scatter plots)
  - Elbow method for optimal K selection
  - Final KMeans clustering results and PCA-based visualizations

---

## Results & Insights

- Optimal number of clusters determined using the Elbow method.
- Distinct clusters include:
  - High income, low spenders
  - Low income, high spenders
  - Balanced segments
- PCA allowed intuitive visualization of customer segments in 2D space.



