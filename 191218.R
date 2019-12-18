#2019/12/18
# 16일차 

# Data model (machine learning)- 1. 지도학습 model : 학습 Data 에 답이 포함 (독립변수, 종속변수) -> 지도학습 모델은 예측, 분류에 쓰인다.
#                              -  2. 비지도학습 model : 학습 Data 에 답이 미포함 (독립변수) -> 군집화에 쓰인다. 
#  지도학습 모델 : Linear Regression, Logistic Regression , KNN, Random Forest, Decision Tree,SVM
#  비지도학습모델 : K-means



#군집화(clustering)/ 분류(classification)

# 1. 군집화 : 주어진 대상 데이터들을 유사성이 높은 것끼리 묶어주는 기술, (군집, 범주, 그룹), 주어진 Data에 Group 정보가 없다. (어느그룹인지 정보가 없다)          
# 군집화 알고리즘의 대표적인 것 : K-means(K-평균 군집화 알고리즘, 몇개의 그룹으로 나눌지 정하고 임의의 점들을 찍는다. 각 데이터와 임의의 점들 사이 거리 계산을 해서 묶인다. )                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        

# 2. 분류 : 그룹 정보가 결정되어있을때, 어디인가를 보는게 분류. ex) KNN 등 

mydata <- iris[,1:4]

fit <- kmeans(x=mydata, center=3)        #center=3 은 그룹 즉 군집의 개수로, 3개의 군집으로 나눈다는 뜻(임의의 점 3개를 찍어서 거리가 짧은 쪽으로 모인다.
#                                                                                                       -> 임의의 점을 모인것들의 중심으로 위치 바꿈 이걸 끊임없이 반복)
fit

##출력결과

#K-means clustering with 3 clusters of sizes 50, 38, 62     ->>> 3개 군집에 속한 각각 데이터 개수를 의미한다. 

#Cluster means:                                             ->>> 3개 군집의 중심점 좌표 ( 나중에 그래프 그리는데 이용될 수 있음)
#  Sepal.Length Sepal.Width Petal.Length Petal.Width
#1     5.006000    3.428000     1.462000    0.246000           #군집1
#2     6.850000    3.073684     5.742105    2.071053           #군집2
#3     5.901613    2.748387     4.393548    1.433871           #군집3

#Clustering vector:                                         --> 각 데이터에 대한 군집번호
#  [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 3 3 2 3 3 3 3 3 3 3 3 3
#[63] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 2 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 2 3 2 2 2 2 3 2 2 2 2 2 2 3 3 2 2 2 2 3 2 3 2 3
#[125] 2 2 3 3 2 2 2 2 2 3 2 2 2 2 3 2 2 2 3 2 2 2 3 2 2 3

#Within cluster sum of squares by cluster:
#  [1] 15.15100 23.87947 39.82097
#(between_SS / total_SS =  88.4 %)

#Available components:

#  [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss" "betweenss"    "size"         "iter"        
#[9] "ifault"      
fit$cluster    #각 데이터의 군집좌표
fit$centers 

library(cluster)           #차원축소 후 군집 시각화 패키지
clusplot(mydata,           #군집대상
         fit$cluster,      #군집번호
         color=TRUE,       #원의 색
         shade=TRUE,       #원의 빗급표시유무
         labels=2,         #관측값 출력 형태, (0 ,2)?
         lines=0)          #lines=0 이면 선 사라짐 0,1

subset(mydata,fit$cluster==2)  #군집화는 그룹정보가 없을때 쓴다. 실제로 iris 는 그룹정보가 있으나 떼어내고 썻다. 



# 대상 데이터 표준화 후 군집화
# 데이터와 데이터의 거리를 계산할 때 발생하는 문제
# 모든 변수가 거리 계산에 동등한 영향을 갖도록 하기 위해서
# 모든 변수의 자료 범위를 0~1 사이로 표준화한 후 거리 계산을 한다.
# ( x-min(A))/ max(A)-min(A))
#  x : 변수 A의 임의의 관측값
#  max(A), min(A) 는 변수 A 관측값 중 최대/최소값           ##ex)iris 는 표준화하나 안하나 비슷하지만 예를 들면 키, 시력을 가지고 군집화를 한다.0 둘이 차이 많이남. 그래서 표준화먼저

std <- function(x){      #식은 매번 이렇게 쓰면 된다.
  return((x-min(x))/(max(x)-min(x)))
}
mydata <- apply(iris[,1:4],2,std)
fit <- kmeans(x=mydata,center=3)
fit


#군집화: 그룹정보가 없는 Data의 그룹을 알아내는 model
#분류 : 특정 data가 어떤 그룹에 소하는지 알아내는 model ( 그룹정보는 있음) -> KNN (K-nearest neighbor 알고리즘 사용)

##KNN (K-Nearest Neighbor, K-최근접 이웃) 분류 알고리즘
#
#
library(class)
#훈련용/테스트용 데이터 준비
tr.idx <- c(1:25,51:75,101:125)   
#전체데이터 중 일부는 훈련용, 일부는 테스트용으로 쓴다. 
ds.tr <- iris[tr.idx,1:4] #훈련용 (그룹정보있음)
ds.ts <- iris[-tr.idx,1:4] #테스트용 (그룹정보없음)
cl.tr <- factor(iris[tr.idx,5]) #훈련용 그룹정보
cl.ts <- factor(iris[-tr.idx,5]) # 테스트 그룹정보
pred <- knn(ds.tr,ds.ts,cl.tr,k=3,prob=TRUE)      #k 값은 임의로 주는 것!  (보통 1~7 사이를 많이 준다), k값 계속 바꿔가ㅓ면서 예측 정확도 높은걸 찾자.
pred
acc <- mean(pred==cl.ts)
acc
table(pred,cl.ts)     # 왼쪽이 예측한것 오른쪽이 원래 데이터, 대각선이 맞춘것, 대각선이 아닌 값이 틀린것  
                      # 분류가 93% 정도 됐다. ( versicolor 로 예측했는데, 실제로는 virginica 인게 4개 있다)


#
# 교차 검증 방법 (K-fold cross validation )
#
install.packages("cvTools")           #훈련데이터로 훈련을 해서 모델을 만들고 테스트 데이터로 모델이 적절한지 확인한다.  
library(cvTools)                      
                                #근데 model 에 실제데이터 적용할 때 overffiting 이 일어날 수 있다.
#                                 (너무 훈련데이터에 적합하게 되어있어서 실제데이터랑 맞지 않음)
#                                 --> 첫번째 훈련했을때 훈련/테스트데이터, 2번째훈련할때 훈련/테스트데이터를 전부 다르게 한다 -교차 검증방법
k=10
folds <- cvFolds(nrow(iris),K=k)  #10번 훈련하겠다. (1번할때마다 훈련데이터와 테스트데이터가 계속 바뀐다)-> overfittng 현상 줄여줌

acc <- c()
for(i in 1:k){
  ts.idx <- folds$which == i        
  ds.tr <- iris[-ts.idx, 1:4]
  ds.ts <- iris[ts.idx,1:4]
  cl.tr <- factor(iris[-ts.idx,5])
  cl.tx <- factor(iris[ts.idx,5])
  pred <- knn(ds.tr,ds.ts,cl.tr,k=5)
  acc[i] <- mean(pred==cl.ts)
}
acc
mean(acc)       #10번의 예측률들의 평균을 구함.(554page~)


#514 -> 의사결정 tree
#519 -> 교차 검정
#537 -> 인공신경망(이게 확장된 것이 딥러닝이다)
#554 -> 비지도학습
#636까지 시계열 데이터 분석 나온다. (범주형, 연속형과는 별도로 본다)
#part 5 한번 훑어보라.



