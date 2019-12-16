#2019/12/16
#14일차 ICT 학점연계 프로젝트 인턴십
#(341~365)page
#data model : 예측, 분류, 군집화
#
#modeling : model 을 만들어내는 과정
#data modeling : 현실세계를 표현하는 수식(=data model)을 도출하는 과정





#model 과정
##1. model 선택 : 수식 결정  ( ex. y=wx+b 와 같은 수식을 결정한다, 이 수식을 regression expression ( 회귀식) 이라고 한다)
##2. 실제 Data(y와 x)를 이용하여 w,b 값을 결정 (w와 b 상수형태로 정한다.w =weight( 기울기), b=bias(경향))    => 훈련과정이라 한다.
##3. 실제 Data 를 통한 예측 
##4. model 평가 (이 모델이 우리가 분석한 것을 잘 설명하는 가 를 평가한다)



##Modeling : 현실 세계에서 일어나는 현상을 수학식으로 표현하는 행위

##데이터 과학에서
#독립변수 x를 설명변수(explanatory variable), 특징(feature)
#종속변수 y를 반응변수(response variable), 레이블(label)
#x가 입력되면 y를 맞추어야하는 문제, y를 ground truth 로 간주

#데이터 과학에서 modeling 이란 수집한 data 를 이용하여 최적의 모델을 찾아내는 과정


##최적의 모델을 찾는 과정
# 모델 : y=Wx+b  -> W,b 를 계수(매개변수)

#1. 모델 선택 -> 선형방정식 선택
#2. 주어진 data(훈련 data) 를 적용하여 매개변수 결정  -> lm() 함수 쓴다.
#3. 예측은 훈련 data 에 없는 새로운 data 로 모델이 레이블을 추정하는 과정 -> predict() 를 쓴다.
#4. 완성된 모델에 대한 품질 평가 -> summary () 함수를 통해 결과를 이해한다. 

#회귀분석 (Regression Analysis)
# 관찰된 연속형 변수들에 대해 두 변수 사이의 모형을 구한 뒤 적합도를 측정해 내는 분석방법
# 시간에 따라 변화하는 데이터나 어떤 영향, 가설적 실험, 인과 관계의 모델링등의 통계적 예측에 이용될 수 있다.

## 단순선형회귀분석(simple linear regreesion analysis)
# 독립변수와 종속변수와의 관계가 선형으로 표현
# 하나의 독립변수를 다루는 분석방법
# 단순선형 회귀모델의 회귀식 : y=Wx+b ( W와 b는 상수)
#               W, b 는 어떻게 찾을 수 있을까?
#               x, y 로 구성된 data를 이용하여 W, b 를 찾아내는 모델


#주행거리와 제동거리 사이의 회귀모델
str(cars)
head(cars)

#산점도를 통한 선형관계 확인
plot(dist~speed,data=cars)
plot(cars)

#회귀모델 구하기,
#종속(반응)변수~독립(설명)변수 순서로 지정
model <- lm(dist~speed,cars)   #cars 는 훈련하는 데이터셋이된다. (이걸 통해서 w,b 를 찾아내고 그 결과를 model 에 집어넣는다)
model

#coefficients : 계수, 매개변수 / b 값 -17.579/  w 값 = 3.932   -> y=3.932x-17.579
#speed x 값이 들어올 때, dist y 값을 구하고 싶다.(예측)

abline(model)  #회귀선이 그어진다. =speed 값이 들어왔을 때 제동거리를 예측하는 최적의 선이다. 

#데이터셋에서 변수들끼리 관계분석하다보니 예측을 할 수 있을 것같다. 그럴때  x값이 누구고, y 값이 누구인지 먼저 결정한다.  
coef(model)      #매개변수(계수) - w, b 값 출력력
cars
fitted(model)   #훈련 data에 있는 샘플에 대한 예측값  
residuals(model)  #잔차: 회귀식으로 추정된 값과의 차이, 실제값과 lm으로 구한 값의 차이값
#잔차 제곱합을 평균제곱오차(MSE-mean squared eeror) 로 변환
deviance(model)/length(cars$speed)

b <- coef(model)[1]
W <- coef(model)[2]

speed <- 21.5
dist <- W*speed+ b
dist     #제주 관광객 입도 예측도 할 수 있다. 


df <- data.frame(speed=c(21.5,25.0,25.5,26.0,26.5,27.0,27.5,28.0))
predict(model,df)  #lm 을 통해 구한 회귀선을 통해 계산하는 예측 수행 함수이다. predict(단순선형회귀모델, x값의 집합)

#사실 이걸 안해도됨
#plot(df$speed,predict(model,df),col="red",cex=2,pch=20)  #이걸 대체하는 함수가 predict 이다
#abline(model)
                 #predict(만들어둔 모델명, 맞는지확인할 새로운 x 값들 집합) - > 예측맞는지 확인

speed <- cars[,1]
pred <- W*speed+b
pred

compare <- data.frame(pred,cars[,2],pred-cars[,2])
compare

colnames(compare) <-c("예상","실제","오차")

head(fitted(model),3) #예측
head(residuals(model),3)  #추정된값과의 차이
head(compare,3)


#평균은 클수록, 분산은 작을수록, 데이터 크기가 클수록 믿음이 커진다. -> t-통계량(t-statistics)/t-값(t-value)
# t-값이 크면 대립가설에 대한 믿음이 강해진다.
# t-값이 작으면 대립가설에 대한 믿음이 약해진다.
# 데이터를 통해 '대립가설이 통계학적으로 유의미하다'라는 것을 증명하고 확인하는 작업을 t- 검정(t- test) 라 한다.
#
#'귀무가설이 참이라고 가정했을때, 표본으로 부터 얻어지는 통계치가 나타날(관측될) 확률'을 계산하는데 이때 계산된 확률값을  p값이라 한다.
#p 값이 매우 낮으면, 이러한 표본통계값은 우연히 나타나기 어려운 케이스이기 때문에 , 우리는 귀무가설을 채택하지 않고,(기각하고), 대안적인 가설인 가설, 
#즉 대립가설을 채택한다. (통상적으로 0.05보다 높냐 낮냐로 결정한다)

#ex) 여름에는 입도하는 관광객이 많다=귀무가설/ 
summary(model)
#Call:
#  lm(formula = dist ~ speed, data = cars)

#Residuals:
#  Min      1Q  Median      3Q     Max 
#-29.069  -9.525  -2.272   9.215  43.201 

#Coefficients:
#  Estimate Std.          Error   t value  Pr(>|t|)             
#(Intercept) -17.5791     6.7584  -2.601   0.0123 *  
#  speed         3.9324   0.4155   9.464  1.49e-12 ***
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Residual standard error: 15.38 on 48 degrees of freedom
#Multiple R-squared:  0.6511,	Adjusted R-squared:  0.6438 
#F-statistic: 89.57 on 1 and 48 DF,  p-value: 1.49e-12

str(cars)
head(cars)
car_model <- lm(dist~speed,data=cars)
coef(car_model)
plot(car_model)   #계산하는 과정이 나온다. 계속 컨트롤 엔터 쳐주기
abline(car_model,col="red")
summary(car_model)     # p 값이 1.49e-12 <0.05  -> 통계적으로 유의미하다. speed가 dist 에 영향을 미친다.

str(women)                
head(women)        #y 는 weight, x=height 로 키가 크면 몸무게가 많이 나간다 라고 본다.
women_model <- lm( weight~height,data=women) # lm 을 통해 w 와 b 값을 구한다.
coef(women_model)
plot(women_model)        #사진보면 그 오른쪽으로 올라가는 선이 최종선인것으로 생각하자.
abline(women_model,col="red")        
summary(women_model)     #여기도 p 값이 0.05 보다 작다. 통계적으로 유의미하다. 키가 크면 몸무게도 많이 나간다. (귀무가설 : 영향 안준다)

#predict 함수로 모델의 예측값을 검정할때 쓴다.
#plot 함수에 predict 나오면 얼마나 오차가 있는지 보기쉽다. 



#지금까지는 예측하기 위한 모델을 보았다. (설명변수가 1개 일때) / 이걸 우리는 단순선형회귀분석이라고 하고 단순선형회귀모델을 만들면된다. 





