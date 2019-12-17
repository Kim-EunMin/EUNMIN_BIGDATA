#김은민
#2019-12-17 (HW)
#
#문제1) trees 데이터셋에 대해 다음의 문제를 해결하는 R 코드를 작성하시오.
# (1) 나무 둘레(Girth)와 나무의 키(Height)로 나무의 볼륨을 예측하는 다중선형 회귀모델을 만드시오.
head(trees)
plot(trees,pch=16,col="red")
model1 <- lm(Volume~Girth+Height,data=trees)
model1
coef(model1)

Volume=(-57.9876589)+(4.7081605 * trees$Girth ) + (0.3392512 * trees$Height)


#(2) 다중선형 회귀모델을 이용하여 trees 데이터셋의 나무 둘레(Girth)와 나무의 키(Height)로 
#     나무의 볼륨을 예측하시오.

#fitted(model1)
Volume          

# (3) (2)에서 예측한 볼륨과 실제 trees 데이터셋의 볼륨(Volume)이 얼마나 차이가나는지 보이시오. 
#       (예측값, 실제값, 예측값-실제값을 나타낸다.)
residuals(model1)

compare <- data.frame(Volume,trees$Volume,Volume-trees$Volume)
colnames(compare) <- c("예측값","실제값","예측값-실제값")
compare


#문제2) mtcars 데이터셋에서 다른 변수들을 이용하여 연비(mpg)를 예측하는 다중 회귀모델을 만드시오.
# (1) 전체 변수를 이용하여 연비(mpg)를 예측하는 회귀모델을 만들고 회귀식을 나타내시오.
head(mtcars)
model2 <- lm(mpg~.,data=mtcars)
model2
coef(model2)

MPG=(12.30337)- (0.11144  * mtcars$cyl ) + (0.01334  * mtcars$disp ) - (0.02148 * mtcars$hp ) +
              (0.78711  * mtcars$drat ) - (3.71530 * mtcars$wt) + (0.82104  * mtcars$qsec ) +
              (0.31776  * mtcars$vs )+ (2.52023  * mtcars$am ) + (0.65541  * mtcars$gear ) -
              (0.19942 * mtcars$carb)
             
# (2) 연비(mpg)를 예측하는 데 도움이 되는 변수들만 사용하여 예측하는 회귀모델을만들고 회귀식을 나타내시오.
library(MASS)
new_model2 <- stepAIC(model2)
new_model2

MPG2=(9.618)- (3.917 * mtcars$wt)+ (1.226  * mtcars$qsec )+(2.936  * mtcars$am )
MPG2

# (3) (1), (2)에서 만든 예측모델의 설명력(Adjusted R-squared)을 비교하시오.
summary(model2)
summary(new_model2)
#(1)에서 만든 설명력은 0.8066, (2)에서 만든 설명력은 0.8336 으로 (2)의 설명력이 더 높다.


#문제3) UCLA 대학원의 입학 데이터를 불러와서 mydata에 저장한 후 다음 물음에 답하시오.

mydata <- read.csv( "https://stats.idre.ucla.edu/stat/data/binary.csv" )
head(mydata)

#(1) gre, gpa, rank를 이용해 합격 여부(admit)를 예측하는 로지스틱 모델을 만드시오(0: 불합격, 1:합격).
model3 <- glm(admit~.,data=mydata)
model3
coef(model3)
summary(model3)

ADMIT =-(0.1824126752) + (0.0004424258*mydata$gre) + (0.1510402328*mydata$gpa) - (0.1095019242*mydata$rank)

#(2) mydata에서 합격 여부(admit)를 제외한 데이터를 예측 대상 데이터로 하여 (1)에서 만든 모델에 입력하여 
#    합격 여부를 예측하고 실제값과 예측값을 나타내시오.

#0.9174506 으로 나오는데 이게 어떤 품종인지 알 수 없다. 
# 그래서 이때 one-hot encoding 을 한다.(1,2,3 으로 나눠야 보기 편하다)
# one-hot encoding 이 필요한 이유는? y 값이 범주형이기 때문이다.
#pred <- round(pred,0) 


unknwon <- mydata[,c(2:4)]
pred <- predict(model3,unknwon)
compare <- data.frame(mydata$admit,pred)

pred <- round(pred,0)
compare2 <- data.frame(mydata$admit,pred)
colnames(compare2) <- c("실제값","예측값")
head(compare2,10)

#(3) 만들어진 모델의 예측 정확도를 나타내시오.
pred
real_admit <- mydata$admit
pred==real_admit


acc <- mean(pred==real_admit)
acc

