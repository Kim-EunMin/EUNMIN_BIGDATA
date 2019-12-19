#
# day16_answer.R
#
# 군집화 / 분류 실습
#
#문1)
#R에서 제공하는 state.x77 데이터셋에 대해 k-평균 군집화를 실시하고 결과를 그래프로 출력하시오.
#
#• 군집의 수는 5로 한다.
#• state.x77은 각 변수(열)의 값들의 단위의 차이가 많이 나기 때문에 0~1 표준화를 실시한 후 군집화를 실행한다.


#과제 설명 : 군집 : x값만 주어진다. 임의의 점에 대한 데이터들의 거리계산이 핵심이다. 
#             나와 가장 가까운 중심점으로 데이터를 모아서 군집을 형성
#             변수간의 단위차이가 심하면 표준화를 꼭 해줘야 한다. 


# 0~1 표준화 함수                                

std <- function( x ) {
  result <- ( x - min( x ) ) / ( max( x ) - min( x ) )
  return( result )
}

# 데이터 표준화
ds.new <- std( state.x77 )         

head( ds.new )
# 과제 설명 : 군집을 5개로, 즉 5개 그룹으로 나눠라. 
# (임의의 점 5개 찍고, 각가 데이터들과 점들의 거리계산을 해서 가까운 쪽으로 모인다. 
# 데이터가 모은 중심으로 임의의 점을 이동시키는 것을 계속 반복, 
# 그러다보면 중심점이 움직이지 않는 시점이 나온다. 군집화 완료)


# 군집화
fit <- kmeans( x = ds.new, centers = 5 )
fit

# 차원 축소 후 군집 시각화
library( cluster )

clusplot( ds.new, fit$cluster, color = TRUE, shade = TRUE, labels = 2, lines = 0 )

# 과제 설명 : 딱딱 떨어져있는 구조보다는 좀 모여있는 구조이다.
#군집화 되면 그걸 기반으로 분류도 된다. 

#문2)
#mlbench 패키지에서 제공하는 Sonar 데이터셋에 대해 k-평균 군집화를 실시하고 결과를 그래프로 출력하시오.
#
# • 군집의 수는 2로 한다.
# • Sonar 데이터셋에서 마지막에 있는 Class 열은 제외하고 군집화를 실행한다.

library( mlbench )
data( "Sonar" ) 			# 데이터셋 불러오기

dim( Sonar )
str( Sonar )
head( Sonar )
View( Sonar )

ds.new <- Sonar[ ,-61 ]   # Class 열 제거
head( ds.new )

# 군집화
fit <- kmeans( x = ds.new, centers = 2 )
fit

# 차원 축소 후 군집 시각화
clusplot( ds.new, fit$cluster, color = TRUE, shade = TRUE, labels = 2, lines = 0 )

#문3) 
#mlbench 패키지에서 제공하는 Sonar 데이터셋에 대해 k-최근접 이웃 알고리즘을 이용하여 모델을 만들고 예측 정확도를 측정하시오.
#
# . Sonar 데이터셋에서 마지막에 있는 Class 열이 그룹 정보이다.
# . Sonar 데이터셋에서 홀수 번째 데이터(관측값)를 훈련용 데이터로 하고, 짝수번째 데이터(관측값)를 테스트용 데이터로 한다.
# . k-최근접 이웃에서 k를 3, 5, 7로 다르게 하여 예측 정확도를 비교한다.
                                     
#과제설명 : 위에서 k평균 군집화알고리즘을 통한 군집화로 그룹정보가 주어지면 데이터들이 새로들어왔을때 이게 어디그룹에 속하냐를 결정하는 경우가 있다.
#          이때 k 최근접 이웃 알고리즘(분류알고리즘)을 쓴다. 
# 분류 알고리즘을 쓸 때는 훈련Data와 Test Data 를 준비해야한다.
# 훈련 데이터에는 feature,label 다 있다.  훈련데이터를 학습시켜서 모델을 만든다. 이 모델이 분류를 잘하는지 확인해봐야한다. 
# 테스트데이터는 이 모델이 잘 만들어졌는지 확인하는 역할을 한다.
# 테스트 데이터에는 feature( x 값) 만 있다.

# k 평균 균집화 알고리즘은 비지도(훈련데이터에 정답없음)/k최근접이웃알고리즘(지도학습으로 훈련데이터에 정답있다) 
# y=label=정답이라고 한다.




# 결측값 제거
ds.new <- Sonar[ complete.cases( Sonar ), ]

# 훈련, 학습 데이터 생성
idx <- seq( 1, nrow( ds.new ), 2 )    #과제설명 : 임의로 학습데이터를 빼둔 것이다. (overfitting 조심해야한다, 즉 너무 훈련데이터에만 맞는 모델을 만들면 안된다. overfitting 현상 : 훈련데이터 넣으면 정확도 높은데, 다른 데이터 넣으면 정확도 확 떨어짐) -> 훈련데이터셋을 여러개 만들어서 각각 훈련련시키면서 overfitting 줄인다. 
x.train <- ds.new[ idx, -61 ]
y.train <- ds.new$Class[ idx ]
x.test <- ds.new[ -idx, -61 ]
y.test <- ds.new$Class[ -idx ]

# 분류 모델
library( class )

pred3 <- knn( x.train, x.test, y.train, k = 3 )  #knn(학습용, 테스트용,그룹정보, 데이터묶어줄 갯수)  3개면 3개로 묶어라
acc3 <- mean( pred3 == y.test )
acc3

pred5 <- knn( x.train, x.test, y.train, k = 5 )
acc5 <- mean( pred5 == y.test )
acc5

pred7 <- knn( x.train, x.test, y.train, k = 7 )
acc7 <- mean( pred7 == y.test )
acc7

# 예측 정확도
#k=3 일 때 : 0.8269231
#k=5 일 때 : 0.75
#k=7 일 때 : 0.7115385

#문4) 
#mlbench 패키지에서 제공하는 Sonar 데이터셋에 대해 k-최근접 이웃 알고리즘을 이용하여 모델을 만들고 예측 정확도를 측정하시오.
#
# . Sonar 데이터셋에서 마지막에 있는 Class 열이 그룹 정보이다.
# . k-최근접 이웃에서 k는 3으로 한다.
# . 5-fold 교차 검증 방법으로 예측 정확도를 측정한다.      

#k - fold 는 군집도 분류도 아니다. overfitting 줄이는 검증방법이다.
#과제설명 : overfitting 줄이기위해서 검증해봄

data( "Sonar" )                             # 데이터셋 불러오기

# 결측값 제거
ds.new <- Sonar[ complete.cases( Sonar ), ]

library( class )
library( cvTools )        

folds <- cvFolds( nrow( ds.new ), K = 5)    # 5 폴드 생성
acc <- c()                                  # 폴드별 예측정확도 저장용 벡터

for ( i in 1:5 ) {
  # 훈련, 학습 데이터 생성
  idx <- folds$which == i
  x.train <- ds.new[ -idx, -61 ]
  y.train <- ds.new$Class[ -idx ]
  x.test <- ds.new[ idx, -61 ]
  y.test <- ds.new$Class[ idx ]
  
  # 분류 모델
  pred <- knn( x.train, x.test, y.train, k = 3 )
  acc[i] <- mean( pred == y.test )
}

acc
mean( acc )


# Data Model(ML 머신러닝) 
# 지도학습/ 비지도학습 / 강화학습 로 3가지 유형이 있다.
#ㄴ관련 알고리즘 : Linear Regression / Logistic Regression / K-means/ KNN/ Decisition tree/ 
               # Random Forest / SVM 등이 있다. 

#Neural Network 가 있는데 이거랑 관련된 것이 CNN(영상,이미지 처리), RNN(자연어처리ex챗봇) ,DNN (영상에 많이씀), CAN ( 이미지 합성)


