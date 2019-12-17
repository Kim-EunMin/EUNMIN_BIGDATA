#2019/12/17
# 15일차 


# 다중선형 회귀분석 (multiple linear regression analysis )
#
# 다중선행 회귀모델 : 여러개의 독립변수를 다루는 회귀모델
#
#회귀식
#y=B0 + B1X1 + B2X2 +B3X3+...+BnXn
#
# 독립변수가 n 개인 다중선형 회귀에서 주어진 자료를 이용해
# BO, B1,B2,B3,.....,Bn의 값을 알아내는 회귀모델
library(tidyverse)
library(car)

str(Prestige)       
head(Prestige) #독립변수 : education, women, prestige / 종속변수 : income (income을 예측할 것)

newdata <- Prestige[,c(1:4)]
head(newdata)
plot(newdata,pch=16,col='blue', main="Matrix Scatterplot")  #일단 4변수간의 연관성 분석해봄(상관분석)

model <- lm(income~education+prestige+women, data=newdata)  #그 다음 모델 만들어봄
model

coef(model)

income= (-253.8497) + (177.1990* newdata$education) + 
                      (141.4354* newdata$prestige) -
                      (50.8957 * newdata$women)

fitted(model)
residuals(model)
deviance(model)  #잔차
deviance(model)/ length(newdata$education) #평균제곱오차


summary(model)         
#별이 붙은 prestige 와 women 은 income 에 영향을 많이 미친다. education 은 income 에 영향을 많이 미치진 않는다.
#adjusted R-suqred  : 설명력 (0에서 1사이의 값이 나오는데 1에 가까워질 수록 현실 설명력이 높다 라고 본다 = > 63%의 현실설명력을 갖는다. )
#p 값이 2.2e-16으로 각 독립변수가 종속변수에 영향을 미친다 라고 이해하면 된다.(education 은 필요없다)



#이번엔 모든 변수 넣어보자
newdata2 <- Prestige[,c(1:5)]
model2 <- lm(income~., data=newdata2)
summary(model2)

library(MASS)
model3 <- stepAIC (model2) #stepAIC 함수자체가 영향력 없는 변수 제거해봄(education 과 census 가 제거됨)
summary(model3) #즉 모델 3은 women 과 prestige 를 가지고 만든 것(영향력 높은 것들만 가지고 만듬)
                  #model2의 설명력 < model3 의 설명력 (영향력있는 변수들을 추출해서 만든 모델이 설명력이 더 높다)

# 다중회귀모델의 설명력을 높이기 위해서는 stepAIC 를써서 영향력없는 변수를 빼자


#지금까지 linear Regression(선형회귀) 을 보았다. 이것은 연속형 Data 에 대한 예측에 쓰인다. 


#Logistic Regression ( 범주형 data 에 대한 예측 ) : 결과값을 범주형태로 변환해야한다. 
# one-hot encoding 이라는 변환방식이 있다.(0,1 이런 거로 바꾸라)


#Logistic Regression ( 로지스틱 회귀분석)
#   회귀모델에서 종속변수의 값의 형태가 범주형인 경우 예측 모델
#   주어진 Data 로부터 어떤 범주를 예측하는 분야를 회귀와 구분하여 분류(classfication) 이라고 한다.
#   로지스틱 회귀도 기본적으로 회귀 기법이기 때문에 종속변수는 숫자로 표현되어야 한다.
#   예) Yes 와 No 는 0과 1로 setosa, versicolor, virginica 를 1,2,3, 과 같이 숫자로 바꾼 후에 로지스틱 회귀 적용

#예측할 대상이 범주형임. 

iris.new <- iris
iris.new$Species <- as.integer(iris.new$Species)   #숫자로 바꾼다!
head(iris.new)

iris_model <- glm(Species~.,data=iris.new)  #로지스틱 회귀분석에 쓰는 함수 (lm 이 아니다)
iris_model    #종속변수(y)가 품종이다. x는 나머지 전부 (나중에 예측한 y 값은 범주형data이다)
coef(iris_model)
summary(iris_model)

#모델 만들었으니 이제 예측을 해보자.
unknwon <- data.frame(rbind(c(5.1,3.5,1.4,0.2)))
names(unknwon) <- names(iris)[1:4]
unknwon

pred <- predict(iris_model,unknwon)
pred
#0.9174506 으로 나오는데 이게 어떤 품종인지 알 수 없다. 
# 그래서 이때 one-hot encoding 을 한다.(1,2,3 으로 나눠야 보기 편하다)
# one-hot encoding 이 필요한 이유는? y 값이 범주형이기 때문이다.
pred <- round(pred,0)  #반올림  (나중에 머신러닝 가면 one-hot encoding 하는 함수들이 있다) 분류를 할때 one hot encoding 을 씀
#즉 c(5.1,3.5,1.4,0.2)의 값을 값는 저것은 1번 품종이다.
levels(iris$Species)[pred]   #setosa 라고 예측을 해줬음

#로지스틱 회귀분석은 맞추는게 몇프로의 성공률이 있는지 확인해야한다.

test <- iris[,1:4]

pred <- predict(iris_model,test)
pred <- round(pred,0)

answer <- as.integer(iris$Species)
pred==answer
acc <- mean(pred==answer)
acc  #예측 성공률


# 491~512 p
