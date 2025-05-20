library(caret)

model <- train(mpg ~ hp +wt,
               data = mtcars,
               method = "lm")


model_knn <- train(mpg ~ hp +wt,
               data = mtcars,
               method = "knn")
