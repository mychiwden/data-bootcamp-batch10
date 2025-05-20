library(tidyverse)
library(mlbench)
library(caret)

## classification problem
data("PimaIndiansDiabetes")

PimaIndiansDiabetes |>
  select(age, diabetes) |>
  group_by(diabetes) |>
  summarise(avg_age = mean(age, na.rm=TRUE),
            median_age = median(age))

df <- PimaIndiansDiabetes

## check/ inspect data
sum(complete.cases(df))
mean(complete.cases(df)) ==1

##glimpse
glimpse(df)

## logistic regression method = 'glm'
set.seed(42)
ctrl <- trainControl(method = "cv",
                     number = 5)
logit_model <- train(diabetes ~ age + glucose + pressure,
                     data = df,
                     method = "glm",
                     metric = "Accuracy",
                     trControl = ctrl)

tree_model <- train(diabetes ~ .,
                     data = df,
                     method = "rpart",# decision tree
                     metric = "Accuracy",
                     trControl = ctrl)

library(rpart.plot)
rpart.plot(tree_model$finalModel)

forest_model <- train(diabetes ~ .,
                    data = df,
                    method = "rf",# random forests
                    metric = "Accuracy",
                    trControl = ctrl)

glmnet_model <- train(diabetes ~ .,
                    data = df,
                    method = "glmnet",# ridge/ lasso regression
                    metric = "Accuracy",
                    trControl = ctrl,
                    tuneGrid = expand.grid(
                      alpha = c(0,1),
                      lambda = c(0.01, 0.10)
                    ))

##final model
logit_model$finalModel

##variable importance
varImp(logit_model)

## confusion matrix

p1 <- predict(logit_model, newdata=df,)
p2 <- predict(logit_model, newdata=df, type="prob")

p2 <- ifelse(p2$pos >= 0.7, "pos", "neg")

t1 <-table(p1 , df$diabetes, dnn = c("Predict" , "Actual"))
t2 <- table(p2 , df$diabetes, dnn = c("Predict" , "Actual"))
## caret confusion matrix
confusionMatrix(p, df$diabetes,
                positive = "pos",
                mode = "prec_recall")

#### regression => high bias
## data change => model doesn't change that much

##save model
saveRDS(logit_model, "logistic_reg.RDS")


