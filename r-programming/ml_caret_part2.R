library(tidyverse)
library(mlbench)
library(caret)

## split data

split_data <- function(data){
  set.seed(42)
  n <- nrow(data)
  id <- sample(1:n , size=0.7*n)
  train_df <- data[id, ]
  test_df <- data[-id, ]
  return( list(train=train_df,
               test=test_df))
}

prep_df <- split_data(mtcars)


knn <- train(mpg ~ ., data = prep_df$train,
             method = "knn",
             metric = "RMSE")

## k-fold cross validation

## ควบคุม processการ train model เปลี่ยน Bootstrapped ->k-fold
ctrl <- trainControl(method = "boot",
                     number = 10)

ctrl_l <- trainControl(method = "LOOCV")

ctrl_cv <- trainControl(method = "cv",
                        number = 5,
                        verboseIter = TRUE) #k

## กำหนดค่า k เอง
grid_k <- data.frame(k=c(3,5))
##repeated k-fold cv
ctrl_rep <- trainControl(method = "repeatedcv",
                        number = 5,
                        repeats = 5,
                        verboseIter = TRUE) #k
## verboseIter print ผลลัพธ์ดูใน knn model
knn_mae <- train(mpg ~ ., data = prep_df$train,
             method = "knn",
             metric = "MAE",
             trControl = ctrl_cv,
             ##tuneGrid = grid_k
             ##ask program to random k
             tuneLength = 4)
## tuneGrid เลือกค่า k
## tuneLength ask program to random k

