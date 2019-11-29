#2019/11/28
#
#break/next
#
sum<-0
for (i in 1:10) {
  sum <- sum+i
  if(i>=5){
    break
  }
}
sum



sum<-0
for(i in 1:10) {
  if(i%%2==0) {
    next
  }
  sum<-sum+i
}
sum




##함수 : 단위 기능을 수행하는 code 집합
#내장함수(library 함수, R에서 제공하는 기본 함수)/ 사용자 정의 함수


#
#산술 내장 함수
#
log(10)+5                   #로그함수
log(10,base=2) 
sqrt(25)                    #제곱근
max(5,3,2)                  #가장 큰 수
min(3,9,5)                  #가장 작은 수
abs(-10)                    #절대값
factorial(5)                #팩토리얼
sin(pi/2)                   #삼각함수



#
#사용자 정의 함수
#
##정의
#함수명 <-function([인수 list]){
#     함수내용 code작성
#        return(되돌릴값)
#   }


mymax <- function(x,y) {             #함수 정의
  num.max <- x
  if(y>num.max){
    num.max <- y
  }
  return(num.max)
}
mymax(10,15)                         #함수호출




a<-10
b<-5
c<-8

max<-mymax(a,b)
max<-mymax(max,c)
max


#122page 복습



#사용자 정의 함수 매개변수 초기값 설정
mydiv <- function(x,y=2) {
  result<-x/y

  return(result)
}

mydiv(x=10,y=3)         #함수 호출하는 방법 여러가지다.
mydiv(10,3)
mydiv(10)       #이건 인수가 1개다, 그러나 y값에 기본값2를 넣어뒀으니 인식한다.


# y라는 인수에 기본값2를 주겠다.함수를 쓸 때 y값이 없으면 그때 기본값을 쓰겠다.





#외부 파일에 있는 함수 호출 (mylib에서 만들어진 함수를 부를 것 이다)
setwd("D:/workR")        #경로지정(역슬래시 아니다 슬래시다)
source("mylib.R")        #Lib 파일 지정

#함수 호출
my_max(10,5)
my_div(10,2)
my_div(10)


#123page ,133page 









#Scalar(원시값): 하나의 값(숫자,문자,논리)
#ex) a<-10  메모리 a 라는 변수에 10 저장 스칼라값
#scalar 로는 한계가 있다 
#vector ( 1차원 배열, 열의 집합) , vector 는 동일자료형집합이다(숫자면 숫자, 문자면 문자끼리)
#vector 는 scalar 형 기억장소의 집합, index구성



#
# Vector 도입
#
# scalar형 변수 사용
a <- 10
b <- 5
c <- 8
max <- a
if(b>max) {max <- b}
if(c>max) {max <- c}
max

#vector 사용
v<-c(10,5,8)
max<-v[1]
for(i in length(v)){
  if(v[i]>max) {
    max <- v[i]
  }
}
max


#아래와 같이 scalar 로는 불편하다.(더 많아지면 힘들다)
a <- 10 ;b <- 5 ;c <- 8 ;d <- 20 ;e <- 12
max <- a
if(b>max) {max <- b}
if(c>max) {max <- c}
if(d>max) {max <- d}
if(e>max) {max <- e}
max

#벡터는 단순히 숫자만 추가해주면 된다. 
v<-c(10,5,8,13,22,31)
max<-v[1]
for(i in length(v)){
  if(v[i]>max) {
    max <- v[i]
  }
}
max


#vector 생성 (아래 c 는 벡터를 생성하는 함수이다)
x <- c(1,2,3)
y <- c("a","b","c")
z <- c(TRUE,TRUE,FALSE,TRUE)
x
y
z

class(x)
class(y)
class(z)

w <- c(1,2,3,"a","b","c")
w
class(w)               #vector 는 동일자료형이여야 한다.!!


v1 <- 50:90
v1
v2 <- c(1,2,3,50:90)
v2
class(v1)
class(v2)


#벡터를 만드는 또 다른 방법
v3<-seq(1,101,3)
v3
v4 <- seq(0.1,1.0,0.1)
v4
v5<-rep(1,times=5)
v5
v6 <- rep(1:5,times=3)
v6
v7<-rep(c(1,5,9),times=3)
v7


#벡터 원소값에 이름 지정
score <- c(90,85,70)
score
names(score) <- c("Hong","Kim","Lee")
names(Score)
score

#벡터 원소 접근
score[1]
score[2]
score[3]
score["Hong"]    #이름 부여하면 인덱스 대신 이름 넣어도 접근 가능
score["Kim"]
score["Lee"]

d <- c(1,4,3,7,8)
d[1]
d[2]
d[3]
d[4]
d[5]
d[6]    #NA : 결측치(missing value) , 값을 읽을 수 없을때 나타남
        #NULL :원래부터 아무것도 없다. (NA는 읽을 수 없다)
        #NAN : 계산할 수 없다.
        #inf : 무한대


for(i in 1:length(score)){
  print(score[i])
}


score_names <- c("Hong","Kim","Lee")
for(i in 1:length(score)) {
  print(score[score_names[i]])
}

#벡터에서 여러 개의 값을 한번에 추출
d <- c(1,4,3,7,8)
d[c(1,3,5)]
d[1:3]
d[seq(1,5,2)]
d[-2]                      #인덱스에서 - 붙으면 제외시키겠다
d[-c(3:5)]




GNP <- c(2090,2450,960)
GNP
names(GNP) <- c("Korea","Japan","Nepal");
GNP
GNP[1]
GNP["Korea"]
GNP[c("Korea","Nepal")]


#벡터 요소값 변경
v1 <- c(1,5,7,8,9)
v1
v1[2]<-3
v1
v1[c(1,5)] <- c(10,20)
v1


#벡터 간 연산 (벡터 간 요소의 갯수가 같아야 한다, 다르면 자동순환)
x<-c(1,2,3)
y <- c(4,5,6)
x+y
x*y
z<-x+y
z

#벡터에 적용가능한 함수
d <- c(1,2,3,4,5,6,7,8,9,10)
sum(d)                        #합계
sum(2*d) 
length(d)                     #벡터의 요소 개수(길이)
mean(d[1:5])                  #평균
mean(d)
median(d[1:5])                #중앙값
median(d)
max(d)                        #최대값
min(d)                        #최소값
sort(d)                       #정렬
sort(d,decreasing=FALSE) 
sort(d,decreasing=TRUE)
range(d)                      #값의 범위(최소값~최대값)
var(d)                        #분산
sd(d)                         #표준편차
#129page


#벡터에 논리연산 적용
d>=5
d[d>5]               
sum(d>5)          #갯수
sum(d[d>5])
d==5

cond <- d>5 & d<8
cond
d[cond]


all(d>5)
any(d>5)


head(d)     #아무것도 지정안하면 디폴트 6개
tail(d)
head(d,3)
tail(d,3)

x <- c(1,2,3)
y <- c(3,4,5)
z <- c(3,1,2)

w <- c(x,y)
w
union(x,y)             #합집합
intersect(x,y)         #교집합
setdiff(x,y)           #차집합
setdiff(y,x)
setequal(x,y)          #x,y에 동일한 요소가 있는지 확인
setequal(x,z)

#59~64page

#자료구조
  ##Vector
  ##List - 다른 Datatype 의 자료를 저장하는 구조
  #      - key(변수) : value 형식으로 저장

  #Fector형 ( 외부 데이터 읽어오면 숫자,문자, 논리 외에도 fector 형으로 잡힐때가 있다, 범위형 type 이다)



#List
ds<-c(90,85,70,84)
my.info <- list(name="Hong", age=30,status=TRUE,
                score=ds)
my.info
my.info[1]                      #name,age,status,score 이 key다.(사진)
my.info[[1]]          #실제 필요한건 value 일텐데, 대괄호 2개쓰는거 잊지말자
my.info$name
my.info[[4]]
my.info[[4]][1]        #4번째요소 즉 c(90,85,70,84) 벡터를 말하는 것 인데 거기서 첫번째니까 90

#72~75page




#Factor 형 (범주형)
bt <- c('A','B','B','O','AB','A')    #bt는 문자형벡터, bt.new는 팩터형 벡터
bt.new <- factor(bt)
bt
bt.new   #factor형일땐 levels 가 나옴(levels 는 가질 수 있는 값의 범위다,즉 앞으로 bt.new 에는 4종류외에 다른 값을 넣으면 안된다)
bt[5]
bt.new[5]
levels(bt.new)
as.integer(bt.new)      #44,45page (is로 시작하면 결과값은 논리형, as 로 시작하면 변환함수)
#범주형이여서 산술형 계산이 안되는데 as로 바꿈. level 에 따라 숫자로 바꿔준다.
bt.new[7]<-'B'
bt.new[8]<-'C'     #C는 levels 에 포함되는 값이 아니므로 에러가 뜬다.그러나 8번째가 요소가 생긴다. (NA로)
bt.new
