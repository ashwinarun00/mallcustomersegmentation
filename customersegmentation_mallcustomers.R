library(dplyr)
library(lubridate)
library(readr)
library(ggplot2)
library(purrr)
library(cluster) 
library(gridExtra)
library(NbClust)
library(factoextra)

Mall_Customers <- read.csv("Mall_Customers.csv")
head(Mall_Customers)

#Column names
names(Mall_Customers)
#Dimension of data
dim(Mall_Customers)

summary(Mall_Customers)

##DEMOGRAPHIC ANALYSIS
#Barplot to visualise gender distribution of customers
a=table(Mall_Customers$Gender)
barplot(a,main="Using BarPlot to display Gender Comparision",
        ylab="Count",
        xlab="Gender",
        col=rainbow(2),
        legend=rownames(a))

#Histogram to visualise age distribution
hist(Mall_Customers$Age,
     col="skyblue",
     main="Histogram to Show Count of Age Class",
     xlab="Age Class",
     ylab="Frequency",
     labels=TRUE)

boxplot(Mall_Customers$Age,
        col="orange",
        main="Boxplot for Descriptive Analysis of Age")

##INCOME ANALYSIS
#Analysis of Customer Income 
summary(Mall_Customers$Annual.Income..k..)

hist(Mall_Customers$Annual.Income..k..,
     col="skyblue",
     main="Histogram for Annual Income",
     xlab="Annual Income Class",
     ylab="Frequency",
     labels=TRUE)

#Density plot of annual income
plot(density(Mall_Customers$Annual.Income..k..),
     col="orange",
     main="Density Plot for Annual Income",
     xlab="Annual Income Class",
     ylab="Density")
polygon(density(Mall_Customers$Annual.Income..k..),
        col="skyblue")

##SPENDING SCORE ANALYSIS
boxplot(Mall_Customers$Spending.Score..1.100.,
        horizontal=TRUE,
        col="orange",
        main="BoxPlot for Descriptive Analysis of Spending Score")

#Histogram of spending score class distribution
hist(Mall_Customers$Spending.Score..1.100.,
     main="HistoGram for Spending Score",
     xlab="Spending Score Class",
     ylab="Frequency",
     col="skyblue",
     labels=TRUE)

#minimum spending score is 1, maximum is 99 and the average is 50.20

##PRODUCT ANALYSIS
retail<-Mall_Customers
retail$Date <- gsub('/', '-', retail$Date)

r2 <- retail %>% 
  mutate(DATE=mdy(Date))%>%
  select(everything())




retailA<- filter(r2, Branch=='A')
retailB<- filter(r2, Branch=='B')
retailC<- filter(r2, Branch=='C')

retailAsum <- group_by(retailA, DATE, Product.line) %>% select(everything())
retailAsum<- summarise(retailAsum, daytotal=sum(Total)) %>% select(everything())

retailBsum <- group_by(retailB, DATE, Product.line) %>% select(everything())
retailBsum<- summarise(retailBsum, daytotal=sum(Total)) %>% select(everything())

#Barplot to see branch-wise distribution
ggplot (data=retail)+
  geom_bar(mapping=aes(x=Branch,fill=Branch))
#Barplot to see product line-wise distribution
ggplot (data=retail)+
  geom_bar(mapping=aes(x=Branch, fill=Product.line), position="dodge")

#Density plot to visualise ratings across branch
ggplot(data=retail) +
  geom_density(mapping=aes(x=Rating, fill=Branch), alpha=.3)

#Barchart to visualise range of sales totals based on the category
ggplot (data=retail)+
  geom_bar(mapping=aes(x=Branch, fill=Product.line), position="dodge") +
  coord_flip()

#Key observations:relatively low number of health and beauty purchases for branch A, as well as a relatively small range of purchase totals for health and beauty, as well as food and beverages

##STORE-WISE ANALYSIS
#Data transformation
ggplot(data=retailAsum) +
  geom_smooth(mapping=aes(x=DATE, y=daytotal)) +
  facet_wrap(~Product.line, nrow=3)

#Analysis of Day Total by Month, Day of the Week
retailAsum <- retailAsum %>%
  mutate(
    Month=month(DATE)
  )

retailAsum <- retailAsum %>%
  mutate(
    DayofWeek=wday(DATE)
  )

retailAsum <- retailAsum %>%
  mutate(
    DayofYear=yday(DATE)
  )


ggplot(data=retailAsum)+
  geom_bar(mapping=aes(x=Month, y=daytotal, fill=Product.line),stat='identity')

ggplot(data=retailAsum)+
  geom_boxplot(mapping=aes(x=DayofWeek, y=daytotal, group=DayofWeek))

##CLUSTERING ALGORITHM
#K-MEANS

#Deciding the optimal number of clusters
#a) Elbow Method
set.seed(123)
# function to calculate total intra-cluster sum of square 
iss <- function(k) {
  kmeans(Mall_Customers[,3:5],k,iter.max=100,nstart=100,algorithm="Lloyd" )$tot.withinss
}
k.values <- 1:10
iss_values <- map_dbl(k.values, iss)
plot(k.values, iss_values,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total intra-clusters sum of squares")

#b) Average Silhoutte Method
fviz_nbclust(Mall_Customers[,3:5], kmeans, method = "silhouette")

#Selecting k=6 as the number of optimal number of clusters
k6<-kmeans(Mall_Customers[,3:5],6,iter.max=100,nstart=50,algorithm="Lloyd")
k6

##APPLYING PCA
pcclust=prcomp(Mall_Customers[,3:5],scale=FALSE) #principal component analysis
summary(pcclust)

set.seed(123)

#Visualising the clusters
ggplot(Mall_Customers, aes(x =Annual.Income..k.., y = Spending.Score..1.100.)) + 
  geom_point(stat = "identity", aes(color = as.factor(k6$cluster))) +
  scale_color_discrete(name=" ",
                       breaks=c("1", "2", "3", "4", "5","6"),
                       labels=c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5","Cluster 6")) +
  ggtitle("Segments of Mall Customers", subtitle = "Using K-means Clustering")

