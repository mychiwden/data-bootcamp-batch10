## install.packages("mlbench")
x <- c(2,3)
y <- c(6,8)

d <- sqrt(sum((x-y)^2))
library(tidyverse)
library(mlbench)
library(caret)
##full loop k-fold cv
## 0. load data
data("BostonHousing")

## 1. split data
df <- BostonHousing
set.seed(42)
n <- nrow(df)
id <- sample(1:n, 0.9*n)
train_data <- df[id, ]
test_data <- df[-id, ]

## 2. training (with k-fold)
set.seed(42)

## k-fold corss validation
train_ctrl <- trainControl(method = "cv",
                           number = 5)
knn_model <- train(medv ~ crim + indus + rm + b,
                   data = train_data,
                   method = "knn",
                   metric = "RMSE",
                   trControl = train_ctrl)


## 3. score
pred_medv <- predict(knn_model,
                     newdata = test_data)


## 4. Evaluate

error <- pred_medv - test_data$medv
test_rmse <- sqrt(mean(error ** 2))
