#
#5일차
#2019-12-02
#
#텍스트 파일 읽기    


setwd("D:/workR")
df <- read.table(file="airquality.txt",header=T)      #탭으로 할 땐 sep 옵션 따로 안해도 된다.
df
class(df)
dim(df)
str(df)
str(df)
head(df,3)
tail(df,3)

#96~97page
#NA 가 있어야 결측치 처리하기가 어렵다. 즉 NA로 읽어져야 유리하다.  이럴땐 na.strings 옵션을 쓰자!




#xlsx 파일 읽기

#R 에서 xlsx 을 읽을땐 package 설치가 필요 . 자바 개발 환경이 꼭 필요하다
#JDK (Java 개발 환경), JRE (Java 실행 환경: Java 로 만든 프로그램을 실행할 환경 구축, 개발은 안됨)
#JDK 를 설치하면 JRE 도 자동 설치 된다.


#다운 받는 방법
# www.oracle.com/technetwork/java/javase/downloads/index.html
#Java SE 에디션 다운 받으면 된다.  #8버전 이상 정도 설치하면 문제 없을 것이다. (수업 시간 Java SE 8u231 의 JDK 다운 받음)
#Accept License Agreement  클릭하고 window 64x 쓰니까 그거로 다운 받음



#JDK 설치하고 나서 D/S 별 환경설정(환경변수 path 에 JDK 설치 위치를 등록해줘야한다)
#즉 설치하면 c:\Program Files\Java\jdk1.8.0_231\bin 를 복사해서
#시작메뉴 마우스 오른쪽버튼 눌러서 시스템 들어가서 시스템 정보들어가서 고급시스템 설정 들어가기
#그 다음 환경변수 클릭하고 시스템 변수의 path 들어가서 등록해야 한다. path 편집 누르고 새로만들기 해서 복사하고 붙여넣는다.
#그러고 그 주소를 맨 위로 이동 시켜둔다. 
#cmd 들어가서 javac -version 과 java -version 입력해서 아래 처럼 나오면 환경 설정 끝낸 것이다. (환경구축 끝)

##C:\Users\ICT01_17>javac -version
##javac 1.8.0_231
##C:\Users\ICT01_17>java -version
##java version "1.8.0_231"
##Java(TM) SE Runtime Environment (build 1.8.0_231-b11)
##Java HotSpot(TM) 64-Bit Server VM (build 25.231-b11, mixed mode)


install.packages("xlsx")          #또한 이거 2개가 설치되어야 xlsx 가 읽어진다. (함수를 쓰는 법도 있고, 우측에 packages 탭 들어가도 된다)
install.packages("rJava")                  #우측 packages 탭에 내가 원하는게 없으면 install 들어가서 패키지명 써주면 된다


library(rJava)            #library 는 설치된 패키지를 쓰겠다라는 함수이다. (install.packages 는 설치하는것)
library(xlsx)             #만약 다음날 다시오면 install 은 할 필요는 없지만 library 는 매일 해줘야한다. 


df.xlsx <- read.xlsx ( file="airquality.xlsx",sheetIndex=1,         #엑셀파일 시트가 여러개일수 있으므로 지정하는게 중요하다
                     encoding = "UTF-8")                            #UTF-8 이면 거의 한글 안깨질것이다.
df.xlsx
class(df.xlsx)
str(df.xlsx)
head(df.xlsx,3)
tail(df.xlsx,3)


#read.table() <-  일반 text file 을 읽는다
#read.csv() <- csv text file 을 읽는다. (중요)
#read.xlsx() <- Excel file 을 읽는다.  (중요)
#이 외에도 JSON 파일( 중요) 이나 XML 로 된 걸 읽어드리기도 한다. 

##read.table()과 read.csv() 는 base 여서 패키지 설치 필요없다
##read.xlsx 는 rJava 설치도 필요하고  패키지 설치 필요하다 





score <- c(76,84,69,50,95,6,82,71,88,84)
which(score == 69)                          #위치값 찾아줌                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
which(score >=85)
max(score)
which.max( score)
min(score)
which.min( score )

idx <- which(score>=60)
score[idx] <- 61
score

idx <- which( iris [,1:4] > 5.0, arr.ind = TRUE)
idx        #1열~4열에서 5.0 넣는 위치를 가져오는 것. 1행1열 , 6행 1열 등등에 나오니 그렇게 적힘
           #arr.ind 를 써야 좌표값이 주어진다. 
iris


# DATA 분석 절차 : 문제 정의 -> DATA 수집 -> DATA 정제/ 전처리 -> DATA 탐색 -> DATA 분석 -> 보고서

#DATA 종류 
## 1. 특성에 따른 분류
##   1.1 범주형    ex) 성별, 혈액형, 취미 (산술연산이 불가능한 타입이다, 평균 표준편차 같은 건 중요하지 않고 갯수파악이 중요)   
#                                     -> Factor 타입으로 표현

##   1.2 연속형   (산술연산 가능)     -> 숫자형으로 표현

## 2. 변수 개수에 의한 분류
##   2.1 일변량 (변수개수 1개)        -> R에서는 벡터로 표현하면 된다.
##   2.2 다변량 (변수개수 2개 이상)   -> Matrix 또는 Dataframe 로 표현
##       이변량 (변수개수 2개)        -> Matrix 또는 Dataframe 로 표현



#
# 단일변수 (일변량) 범주형 자료 탐색     
# 
favorite <- c("WINTER","SUMMER","SPRING","SUMMER","SUMMER","FALL","FALL","SUMMER","SPRING","SPRING")
favorite
class( favorite )
table( favorite )                           #table 함수는 범주형에 대한 도수분포표를 만들어준다. 
table( favorite) /length( favorite)
ds <- table( favorite )
ds
barplot( ds, main="favorite season")        #도수분포표가 그려짐, main은 그래프 제목


ds.new <- ds[c(2,3,1,4)]
ds.new
barplot(ds.new, main="favorite season")

pie(ds, main="favorite season")
pie(ds.new,main="favorite season")
                      #help 에 그래프함수 검색해봐서 다른 옵션들도 넣어봐라
              
#           =>> 범주형 이면서 일변량인 data 의 탐색적 분석은 위와 같이 한다. (도수분포표 이용)



favorite.color <- c(2,3,2,1,1,2,2,               #  ==> 범주형이면서 숫자형
                    1,3,2,1,3,2,1,2)
ds <- table(favorite.color)
ds
barplot(ds,main="favorite season")
colors <- c("green","red","blue")
names(ds) <- colors
barplot(ds,main="favorite season",col=colors)
pie(ds,main="favorite season", col=colors)


#
# 단일변수( 일변량 ) 연속형 자료      
#
weight <- c(60,62,64,65,68,69)
weight
weight.heavy <- c(weight,120)
weight.heavy

#평균         -> 연속형은 산술연산 가능하니까 이런것들 구할 수 있다. 
mean(weight)        
mean(weight.heavy)
#중앙값
median(weight)
median(weight.heavy)
#절사평균     ( 낮은 값, 높은 값 제외하고 평균을 구한다) 
mean(weight,trim=0.2)    #상위,하위 20% 씩 제외하고 구한다. 
mean(weight.heavy, trim=0.2)
#사분위수
quantile(weight.heavy )   #1사분위 : 25%, 2사분위: 50%, 3사분위 : 75%
quantile(weight.heavy,(0:10)/10)
summary(weight.heavy)   

#산포(distribution) - 값이 퍼져있는 정도 파악
##분산,표준편차 : 작을수록 평균에 데이터들이 모여있다. 
var(weight)
sd(weight)
##값의 범위 (최소값과 최대값)
range(weight)
##최대값과 최소값의 차이
diff(range(weight))


#histogram : 연속형 자료의 분포를 시각화             #범주형은 막대/ 연속형은 히스토그램 이용
 # 연속형 자료에서는 구간을 나누고 구간에 속한       #범주형처럼 범주에 따라 나누는게 안되니까 구간을 나눔.
 # 값들의 개수를 세는 방법으로 사용
str(cars)
dist <- cars[,2]
hist(dist,main="Histogram for 제동거리",        #막대그래프는 막대끼리 떨어져있지만 히스토그램은 붙어있다.
     xlab="제동거리", ylab="빈도수",          
     border="blue",col="green",               #border 은 막대선색깔
     las = 1, breaks=5)                   #las(출력방향)는 0부터 3까지 있다. breaks 는 막대수


#상자그림(boxplot, 상자수염그림)
#   사분위수를 시각화하여 그래프 형태로 표시
#   상자그림은 하나의 그래프로 데이터의 분포형태를 포함한 다양한 정보를 전달
#   자료의 전반적인 분포를 이해하는데 도움
#   구체적인 최소/최대/중앙값을 알기는 어렵다
boxplot(dist,main="자동차 제동거리")
 #굵은 선이 2사분위, 동그라미는 이상치 ( 152page )
boxplot.stats( dist )                     #--> boxplot그림으로는 정확한 값을 모름. 하지만 이 함수를 쓰면 알 수 있다.
boxplot.stats( dist )$stats   #정상범위 사분위수   
boxplot.stats( dist )$n       #관측치 개수수
boxplot.stats( dist )$conf    #중앙값 신뢰구간
boxplot.stats( dist )$out     #이상치(특이값) 목록



#일변량 중 그룹으로 구성된 자료의 상자그림
boxplot(Petal.Length~Species, data=iris, main="품종별 꽃잎의 길이")  #품종별로 묶임 (연속형이고 일변량인데 그룹으로 묶인것이다)
boxplot(iris$Petal.Length~iris$Species, main="품종별 꽃잎의 길이")   # ~다음에 그룹의 변수를 써준다.
 #꽃잎의 길이(~앞에써준다)를 보는게 목표인데 품종별(~뒤에 그룹 써준다) 로 길이를 보려는 것이다. 

  #setosa 는 가장 짧다. 그리고 분포가 모여있다.
  #virginica 는 꽃잎의 길이가 가장 길고 분포가 넓다. (가장 품종안에서도 꽃잎끼리 길이 차이가 난다)

# 한 화면에 여러 그래프 작성
par( mfrow=c(1,3)) #1x 3 가상화면 분할
barplot( table(mtcars$carb), main="C",xlab="carburetors",ylab="freq", col="blue")
barplot( table(mtcars$cyl), main="Cyl", xlab="cyl",ylab="freq", col="red")
barplot(table(mtcars$gear),main="g",xlab="gear",ylab="freq",col="green")
par(mfrow=c(1,1))   #가상화면 분할 해제


#여기까지해서 일변량 끝! (범주형, 연속형 나눠서 봤었음)/ (벡터기반의 데이터를 볼때 주로 사용된다)




















