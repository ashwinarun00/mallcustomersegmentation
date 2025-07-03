#### The following is a summary of observations and inferences obtained from the customer segmentation

## 📊 Exploratory Data Analysis (EDA)

- Dataset contains demographic and transactional information of mall customers.
- **Gender Distribution**: Fairly balanced, with a slightly higher count of female customers.
- **Age Distribution**:
  - Most customers are between **30 to 40 years old**.
  - Very few customers are above 55 or below 20.
- **Annual Income**:
  - Majority of customers earn between **$40k to $70k**.
  - Income distribution appears fairly symmetric.
- **Spending Score**:
  - Bimodal distribution indicating **two distinct customer behaviors**: low spenders and high spenders.
- **Correlation Insights**:
  - Weak correlation between **Age and Spending Score**.
  - No clear linear relationship between **Annual Income and Spending Score** — supports need for clustering.

---

## 📊 Cluster Profile

- **Optimal number of clusters** determined via the **Elbow Method**: **K = 5**.
- **PCA** used to reduce dimensions and visualize clusters in 2D space.

### Cluster Characteristics:

1. **Cluster 1**:  
   - **High income**, **low spending score**.  
   - Likely cautious or savings-focused customers.

2. **Cluster 2**:  
   - **Low income**, **high spending score**.  
   - Possibly younger, impulsive buyers.

3. **Cluster 3**:  
   - **Balanced income and spending score**.  
   - Represents average mall-goers.

4. **Cluster 4**:  
   - **High income**, **high spending score**.  
   - Ideal target for premium marketing.

5. **Cluster 5**:  
   - **Low income**, **low spending score**.  
   - Least engaged group, possibly non-target customers.

---

