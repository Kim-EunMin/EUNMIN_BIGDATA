#
#6일차
#2019-12-03
#
#분석하기전에  str,class,head 등을 해준다. 그래야 어떤 방향으로 분석할 지 알 수 있다.
#즉 범주형+일변량인지, 범주형+다변량, 연속형+일변량인지 등등 을 확인해볼 수 있다.
#그래야 막대그래프 그리는지, 히스토그램 그리는지 등을 알 수 있다. 예를 들어 연속형이면 평균구해봐서 좀 이상하다 싶으면 이상치 있는지 보는 것등을 해주면 된다.고

#ex) str을 해서 num 으로 되어있으면 연속형이다. 
# 그러나 숫자형이더라도 범주형일 수 있다. (ex) head함수써봐서 만약 4,6,8만 있다면 범주형일수도 있다.)

#예를 들면 mtcars#cyl 을 보면
mtcars
mtcars$cyl
class(mtcars$cyl)
#(과제HW5)숫자형이지만 4,6,8 3가지로만 구성되어있으므로 연속형보다는  범주형으로 보고 분석해야한다. 
# 그래서 cyl 에 대해서는 도수분포표를 만들고, 막대그래프를 그린다.
# 해석을 하는게 중요하다.




#다중변수(다변량) 자료 탐색
#두 변수 사이의 산점도
#산점도(scatter plot) - 2변수로 구성된 자료의 분포를 알아보는 그래프 , 관측값들의 분포를 통해 2변수 사이의 관계파악

wt <- mtcars$wt
mpg <- mtcars$mpg
plot(wt, mpg,main="중량-연비 그래프", xlab="중량",ylab="연비",col="pink",pch=19)   #pch 는 점 모양(0~25까지 가능) 
plot(mtcars$wt, mtcars$mpg,main="중량-연비 그래프", xlab="중량",ylab="연비",col="pink",pch=19)
plot(mtcars[,c("wt","mpg")],main="중량-연비 그래프", xlab="중량",ylab="연비",col="pink",pch=1)
plot(mpg~wt,data=mtcars,main="중량-연비 그래프", xlab="중량",ylab="연비",col="pink",pch=3)
#중량이 낮아지면 연비는 높다. (이런걸 상관분석이라 한다. 상관분석 할때 산점도 많이 씀)
#중량이 높아지면 연비는 낮다. 두 변수는 음의 상관관계를 갖는다.





#여러 변수들간의 산점도
vars <- c("mpg","disp","drat","wt")       #벡터생성(변수이름)
target <- mtcars[,vars]
head(target)
pairs(target, main="muti plots")     #이변량 이상인 다변량일때 산점도를 그려주는 함수는 pairs 다.
#산점도에서 대각선이면 l두변수간에 관계가 있다. 분포가 일정하지 않거나 모여있거나 이러면 두변수 사이에 관계가 없다고 보면 된다.




#그룹정보가 있는 두변수의 산점도 
iris.2 <- iris[,3:4]                  
point <- as.numeric(iris$Species)      #품종은 범주형(그룹)이다. 근데 문자여서 숫자로 바꿔준다. 
point                                 #품종별로 꽃잎의 길이와 폭을 볼 것 이다.(우리의 궁극적 목적은 꽃잎의 길이와 폭의 관계를 보는 것이다, 하지만 그룹별로 나눠봄)
color <- c("red","green","blue")
plot(iris.2,main="Iris plot", pch=c(point),col=color[point])

#길이와 폭 의 양의 상관관계를 확인했고, 뿐만 아니라 그룹별 정보도 알수 있다.
#빨간색 품종은 대체적으로 길이와 폭이 짧다. 파란색 품종은 길이도 길고, 폭도 넓다. 
#pdf 상관분석 확인하자
#상관계수 는 -1과 1 사이 에 있는데. -1에 가까우면 음의 상관관계/ +1에 가까우면 양의 상관관계, 
#대체적으로 기준을 0.5 로 잡는데 0.5 이상이면 상관관계가 높다. -0.5 이하이면 상관관계가 높다 라고 한다. 
#다변량일땐 상관분석을 하고, 상관분석을 하기위해 시각화하는 도구로 산점도를 쓴다.



#상관분석
beers <- c(5,2,9,8,3,7,3,5,3,5)
bal <- c(0.1,0.03,0.19,0.12,0.04,0.0095,0.07,0.06,0.02,0.05)
tb1 <- data.frame(beers,bal)
tb1
   ###1. 산점도를 그려보자.
plot(bal~beers,data=tb1)   #맥주잔 몇잔을 먹었냐에 따라 혈중 알코올 농도를 볼 수 있다.(산점도를 보면 어느정도 상관간계가 있다고 볼 수 있다)
  
   ###2. 회귀식을 도출하자 (lm함수이용)
res <- lm(bal~beers,data=tb1)
res
   #==> 회귀식: y=wx+b (x는 독립변수, y는 종속변수, w는 weight, b 는 bias)
   #==> y=0.01578x-0.00995

   ###3.회귀선을 그려보자. (몇잔을 먹었을 때 혈중 알코올 농도가 어떻게 되는지 보여주는 최적의 예측선이 회귀선이다.)
abline(res)   

   ###4.상관계수 r(상관관계를 정확한 수치로 보자)
cor( tb1[,1:2])         #이변량 상관계수 ( 0.67 은 0.5를 넘으니 강한 상관관계, 양수니까 양의 상관관계)
cor( iris[,1:4])        #다변량 상관계수


#산점도 그리고 회귀식 그리고 상관계수 구하는 것이 상관분석이다. 상관분석을 통해 여러변수들의 상관관계를 파악할수 있다.



#상관분석 순서 (절대적인 것은 아니지만 활용해라)
#
#1. 상관분석 대상 변수선정
#2. 산점도 작성( 관측값 분포 확인 ) : plot()
#3. 회귀식 도출 : lm()
#   (회귀식 : 두 변수의 선형관계를 가장 잘 나타낼 수 있는 선의 식)
#   (y = xw + b)
#4. 회귀선을 산점도에 표시 : abline()
#   (회귀선 : 관측값들의 추세를 가장 잘 나타낼 수 있는 선)
#5. 상관계수 계산 : cor()
#6. 상관분석 결과 해석



 

#시계열 Data - 선그래프(시각화 도구)  

month <- 1:12
late <- c(5,8,7,9,4,6,12,13,8,6,6,4)
plot(month,late,main="지각생통계", type="l",lty=1,lwd=1,xlab="Month",ylab="late cnt")
plot(month,late,main="지각생통계", type="b",lty=1,lwd=1,xlab="Month",ylab="late cnt")
plot(month,late,main="지각생통계", type="o",lty=1,lwd=1,xlab="Month",ylab="late cnt")
plot(month,late,main="지각생 통계",type="s",lty=1,lwd=1,xlab="Month",ylab="late cnt")                       
#type 은 그래프 모양 결정, lty 는 선의 모양, lwd 는 선의 두께
#x축에 시간 정보가 들어가는 것이 시계열 데이터다.



#복수의 선 그래프
late1 <- c(5,8,7,9,4,6,12,13,8,6,6,4)
late2 <- c(4,6,5,8,7,8,10,11,6,5,7,3)
plot(month,late1,main="지각생통계",type="b",lty=1,col="red",xlab="Month",ylab="late cnt",ylim=c(1,15))
lines(month,late2,type="b",col="blue")


#문제 정의 -> Data 수집 -> Data 전처리 가공 -> 탐색적 data 분석 -> Data 분석 -> 보고서


# 자료 탐색 실습 - 탐색적 데이터 분석 (절대적인것은 아님)
#탐색적 데이터 분석을 통해 data 이해 가능 (data set 에 대한 이해/ 문제 정의 검증/ 문제 정의에 대한 1차 결과 파악)

#
# 0단계 : 문제 정의
# 1단계 : 분석 대상 데이터셋 준비
#         BostonHousing 데이터셋 (mlbench pac.)
install.packages("mlbench")
library( mlbench )
data("BostonHousing")
class(BostonHousing)
dim(BostonHousing)
str(BostonHousing)
head(BostonHousing)
tail(BostonHousing)

#crim : 1인당 범죄율/  rm: 주택 1가구당 방수/ dis : 보스턴 5개 지역센터까지의 거리
#tax : 재산세율 / medv : 주택가격

myds <- BostonHousing[,c("crim","rm","dis","tax","medv")]
str(myds)   #수치형이더라도 범주형일 수도 있다. 그럴땐 vector 하나씩 출력해서 확인하면 된다. 

# 2단계 : 파생변수 추가
#       : grp 변수 추가(주택가격상중하)
grp <- c()
for(i in 1:nrow(myds)){                          #1부터 506까지 반복해라 , 즉 i 는 1, 2, 3, ...506
  if(myds$medv[i]>=25.0){
    grp[i] <- "H"
  } else if (myds$medv[i] <= 17.0) {
    grp[i] <- "L"
  } else {
    grp[i] <- "M"
  }
}
grp <- factor(grp)
grp <- factor(grp,levels=c("H","M","L"))
myds <- data.frame(myds,grp)
head(myds)

# 3단계 : 데이터셋의 형태와 기본적인 내용 파악
str(myds)
head(myds)
table(myds$grp)      #factor 타입 있으니까 도수분포표정도는 만들어볼 수 있다.


#4단계 : 히스토그램에 의한 관측값의 분포 확인
par( mfrow=c(2,3))
for(i in 1:5) {
  hist(myds[,i],main=colnames(myds)[i],
       col="yellow")
}                                                        #str 보면 변수5개는 전부 연속형이다.( 범주형 아님) -> 히스토그램 그려봄
par(mfrow=c(1,1))                                     #히스토그램은 rm 처럼 정규분포모양(종모양) 이 나오는게 제일 좋다.

#crim 범죄율은 한쪽에 치우침, rm 정규분포모양이다. tax 은 모양이 이상함. medv 도 완전하진 않지만 종모양이다.


                              
#5단계 : 상자그림에 의한 관측값의 분포 확인
par( mfrow=c(2,3))
for(i in 1:5) {
  boxplot(myds[,i],main=colnames(myds)[i])
}                                                        #str 보면 변수5개는 전부 연속형이다.( 범주형 아님) -> 히스토그램 그려봄
par(mfrow=c(1,1))  

#상자그림을 통해 분포와 이상치 볼 수 있다. 범죄율 이상치 많다/ tax 는 이상치 없다. 
#나중에 전처리 할때 이상치 처리를 해줘야한다.
#세금은 높은 편이다. 란 정보도 얻을 수 있다.

#6단계 : 그룹별 관측값 분포 확인
boxplot(myds$crim~myds$grp,main="1인당범죄율") #집값 낮은 곳이 범죄율 높다다
boxplot(myds$rm~myds$grp, main="방의 개수")  #집값이 높을 수록 방의 수도 높다
#이런식으로 다른것도 확인 가능

#7단계 : 다중 산점도를 통한 변수 간 상관 관계 확인
pairs(myds[,-6])
 #rm과 medv 가 상관관계가 있어보인다. 

#8단계 : 그룹 정보를 포함한 변수 간 상관관계 확인
point <- as.integer(myds$grp)
color <- c("red","green","blue")
pairs(myds[,-6],pch=point, col=color[point])

 #iris .를 품종별로 나타낸것처럼 grp 로 나눠서 쓴다. (7단계와 8단계는 똑같으나 8단계는 그룹별로 확인)

#9단계 : 변수 간 상관계수 확인
cor(myds[,-6])


