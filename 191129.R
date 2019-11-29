#
#4일차
#2019-11-29
#
#함수 반환값(return 값) 이 여러 개 일 때의 처리
myfunc <- function(x,y){
  val.sum <- x+y
  val.mul <- x*y

  return (list(sum=val.sum,mul=val.mul))
}

result <- myfunc(5,8) 
s <- result$sum
m <- result$mul
cat('5+8=',s,'\n')
cat('5*8=',m,'\n')


##정리
#scalar(값) : 일반변수(data type:숫자,문자,논리,NULL,NA,NAN,FACTOR) (FACTOR는 data의 범위가 있다)
#1차원배열(동일 자료형 집합) : Vector(scalar를 여러개 저장)
#1차원배열(다른 자료형 집합) : list 
#2차원 배열(행/열의 집합)  : Matrix (Matrix 는 동일자료형 집합이다)
#                            Data Frame(Data Frame은 다른 자료형 집합이다)
#      *2차원 배열에서 열을 변수, 특성(Feature) 이라고 한다.
#      *2차원 배열에서 행을 관측치,데이터 라고 한다.




#Matrix 생성
z <- matrix(1:20,nrow=4)    #R에서는 디폴트로 열 먼저 채운다(열 우선 방식) 
z                           

z <- matrix(1:20,ncol=4)
z

z <- matrix(1:20,nrow=4,ncol=5)
z


z <- matrix(1:20,nrow=4,ncol=5,byrow=T)       #행 우선
z


x <- 1:4
x
y <- 5:8
y
z <- matrix(1:20,nrow=4,ncol=5)
z

m1 <- cbind(x,y)
m1
m2 <- rbind(x,y)
m2
m3 <- rbind(m2,x)
m3
m4 <- cbind(z,x)
m4


#Matrix 에서 cell의 값 추출
z[2,3]            #2행3열 (값 하나)
z[1,4]           
z[2,]             #열은 생략, 행 전체 의미한다
z[,4]             #4열 전체

z[2,1:3]
z[1,c(1,2,4)]
z[1:2,]
z[,c(1,4)]


#Matrix에서 행/열 에 이름 지정
score <- matrix(c(90,85,69,78,
                  85,96,49,95,
                  90,80,70,70),
                nrow=4,ncol=3)
score
rownames(score) <- c("Hong","Kim","Lee","Yoo")
colnames(score) <- c("English","Math","Science")
score

score["Hong","Math"]
score["Kim",c("Math","Science")]
score["Lee",]
score[,"English"]
rownames (score)
colnames(score)
colnames(score)[2]

#64page~67page


#Data Frame : 2차원 구조, 동일/다른 자료형의 행/열 집합, 변수(열)은 동일 자료형(세로로는 같아야한다)
#Data Frame 생성

city <- c("Seoul","Tokyo","Washington")
rank <- c(1,3,2)
city.info <- data.frame(city,rank)
city.info                               #dataframe 은 변수이름이 명확하게 나옴

name <- c("Hong","Kim","Lee")
age <- c(22,20,25)
gender=factor(c("M","F","M"))
blood.type=factor(c("A","O","B"))
person.info <- data.frame(name,age,gender,blood.type)
person.info

person2.info <- data.frame(name=c("Hong","Kim","Lee"),              
                           age=c(22,20,25),
                           gender=factor(c("M","F","M")),
                           blood.type=factor(c("A","O","B")))
person2.info


city.info[1,1]
city.info[1,]
city.info[,1]
city.info[city.info$city,]    #여기서는 오류다
city.info[,"rank"]

person.info$name
person.info[person.info$name=="Hong",]
person.info[person.info$name=="Hong",c("name","age")]

data()             #R에서 기본적으로 제공하는 dataset

iris
iris[,c(1:2)]
iris[,c(1,3,5)]
iris[,c("Sepal.Length","Species")]
iris[1:5,]
iris[1:5,c(1,3)]


#Matrix 와 Data Frame 에서 사용하는 함수
dim(person.info)              #(데이터 분석에 많이 쓰임) 관측치,변수 갯수
nrow(person.info)
nrow( m3 )
ncol(person.info)
ncol(m3)
head(iris)                    #앞부분 일부
tail(iris)                    #뒷부분 일부
str(iris)                     #(데이터 분석에 중요하다)정보제공 (dataframe 형태이다. 150개 관측치, 5개변수다, $뒤가 변수내용이다, datatype 이 나오는데, 몇몇 변수는 자동으로 factor 가 된게 보인다)
                              #factor 는 산술연산이 안됨. 그럴땐 as.integer 이런거 이용해서 바꿔서 계산한다.
                              #외부데이터 가져올때 str 써서 확인해보는게 좋다 (factor 로 바뀌는 경우가 많음)
str(city.info)
str(person.info)
iris[,5]
unique(iris[,5])              #중복된 데이터가 많을때 종류만 나열해라
table(iris[,"Species"])       #(데이터 분석에 많이 쓴다) factor 타입을 count 해준다.
table(person.info[,"blood.type"])        
table(person.info[,"gender"])

#77page~80page




#Matrix/Data Frame 사용 함수
#행별/열별 합계와 평균 계산

colSums(iris[,-5])            #각 열의 합계(5열은 제외해라)
apply(iris[,1:4],2,sum)       #apply함수는 인수3개 (대상,숫자가1이면 행방향 2이면 열방향,하려는 동작)

colMeans(iris[,-5])           #각 열의 평균(각 변수의 평균)
apply(iris[,1:4],2,mean)      #2니까 각 변수의 평균 즉 세로의 평균 구해라

rowSums(iris[,-5])            #각 행의 합계 (그래서 150개 벡터가 나옴)
apply(iris[,-5],1,sum)

rowMeans(iris[,-5])
apply(iris[,-5],1,mean)

apply(iris[,-5],2,median)     #apply 가 더 많이 쓰인다. 



#행/열 방향 전환
z <- matrix(1:20,nrow=4,ncol=5);
z
t(z)

#조건에 맞는 행과 열의 값 추출(Data Frame만 가능)
IR.1 <- subset(iris,Species=="setosa")          
IR.1
IR.2 <- subset(iris,Sepal.Length>5.0 &Sepal.Width >4.0)
IR.2
IR.2[,c(2,4)]



#Matrix/Data Frame 산술연산
a <- matrix(1:20,4,5);a
b <- matrix(21:40,4,5);b

2*a
b-5
2*a+3*b
b/a
a*b


#Matrix/Data Frame 자료구조 확인/변환
class(iris) ;str(iris)
class(state.x77)  ; str(state.x77)
is.matrix(iris)
is.data.frame(iris)
is.matrix(state.x77)
is.data.frame(state.x77)

st <- data.frame(state.x77)
str(st)
head(st)
class(st)


iris.m <- as.matrix(iris[,1:4])
head(iris.m)
class(iris.m)
dim(st)    #관측치 50, 변수 8개
str(iris.m)


head(st)
Population
attach(st)  #attach 를 하면  변수명 직접적으로 쓸 수 있다. (열하나가 벡터인데 attach 를 써서 그걸 이름만 불러도 불러오는게 가능)
Population
detach(st)  #detach 를 하면 이제 안됨
Population




#airquality.csv 파일 만들었음
#CSV(comma seperator values, 콤마로 데이터 분리)
#TSV(tab seperator values, 탭으로 데이터 분리)

#Text file ->ASCII 형식 (메모장으로 열수있다)
#BInary file ->Binary 형식(메모장으로 열수없다로 구분하면됨)


#csv file 내용 읽기
setwd("D:/workR")          #setwd 는 경로지정 (역슬래시가 아니라 슬래시쓰는거 조심)
air <- read.csv("airquality.csv",header=T)     #header 첫줄을 head로 인식하냐마냐(데이터부터 나오면 F로 해야함)    

class(air)
dim(air)
str(air)      #int 도 숫자로 생각하기 (그러나 오류날수도 있으니 as.number 로 바꿔주기)
head(air)
tail(air)       #요거 5개는 파일을 읽어올때 꼭 해주자



#csv file 생성

name <- c("Hong","Kim","Lee")
age <- c(22,20,25)
gender=factor(c("M","F","M"))
blood.type=factor(c("A","O","B"))
person.info <- data.frame(name,age,gender,blood.type)
person.info

setwd("D:/WorkR")
write.csv(person.info,"person_info.csv",row.names=F)


#98,109page

