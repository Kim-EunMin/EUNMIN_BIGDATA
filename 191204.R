#
#7일차
#2019-12-04
#
#Data Preprocessing (데이터 전처리) : 원시 자료에 대하여 Data 정제/가공을 수행하여 분석에 적합한 형태로 만드는 과정

#    1. Data 정제 : 결측치(missing value, R에서는 NA 로 표기, data를 읽을 수 없다란 의미, NA 가 있으면 산술연산이 안됨)에 대한 처리 
#               이상치에 대한 처리 (해당하는 변수에 들어가면 안되는 값이 들어갔을때 어떻게 처리하나? 예를 들어서 나이라는 변수에 -10 이 들어감)

      ##결측치에 대한 처리 
       #1) rational approach ( 어떤 변수에 결측치가 있다. 계산공식 알면 결측치 채워주면 된다. ex) 성별에 결측치가 있는데 주민번호가 있다. 그럼 성별 구할 수 있다)  
       #2) listwise Delection ( 결측치가 포함된 row 를 전체 삭제한다 )
       #3) pairwise Delection ( 상관관계가 높은 다른변수를 이용해서 예측해서 결측치를 채워준다. 임의로 넣은것이므로 왜곡 가능성있다)
       #4) 단순대입법 ( 결측치빼고, 나머지들끼리의 평균을 구하거나 중앙값을 구해 결측치에 그 값을 넣는다 , 변수의 성격을 보고 0을 넣는게 적합할지, 평균, 최대값을 넣는게 적합한지 정한다)
       #5) 다중대입법 ( 데이터셋을 추출해서 NA를 예측해보고 대입하는데 그걸 여러번 한다 )


#vecotr 의 결측치 처리
z <- c(1,2,3,NA,5,NA,8)
sum(z)
is.na(z)
sum(is.na(z))
sum(z,na.rm=TRUE)


#결측치 대체 및 제거 
z1 <- z
z2 <- c(5,8,1,NA,3,NA,7)
z1[is.na(z1)] <- 0         #단순대입법
z1
z3 <- as.vector(na.omit(z2))  #listwise delection  (na.omit 함수는 결측치를 삭제)
z3

#Matrix/Data Frame 결측치 처리
x <- iris
x[1,2] <- NA
x[1,3] <- NA
x[2,3] <- NA
x[3,4] <- NA

head(x)

#Matrix/Data Frame 열별 결측치 확인
#for 문 이용
for(i in 1:ncol(x)) {               
  this.na <- is.na(x[,i])          
  cat(colnames(x)[i],
  "\t",sum(this.na),
  "\n")
}

#apply() 이용
col_na <- function(y){
  return(sum(is.na(y)))
}
na_count <- apply(x,2,col_na)   #행방향 1 , 열방향 2
na_count

 #또 다른 표현
na_count <- apply(x,2,function(y) sum(is.na(y)))          #function(y) sum(is.na(y)) 이런 것을 익명함수 라고 한다.
na_count #각 변수의 결측치 수가 나온다.



barplot(na_count[na_count>0])

install.packages("VIM")    
require( VIM )       #require 은 library 랑 같은 기능이다.

#결측치 자료 조합 확인용 시각화 도구
aggr(x,prop=FALSE, numbers=TRUE)                 #왼쪽그래프 x가 변수에 대한 결측치 수 (0개1개2개1개0개), 오른쪽 그래프에서 147이 결측치 없는 데이터갯수)

#두 개의 변수간의 결측치 관계 확인 시각화 도구
marginplot(x[c("Sepal.Width","Petal.Width")],     #두 변수간의 결측치 위치를 보여줌.(이런게 pairwise delection 에 쓰일 수 있다)
           pch=20,
           col=c("darkgray","red","blue"))
marginplot(x[c("Sepal.Width","Sepal.Length")],     #빨간색이 결측치, 회색은 결측치 없는 데이터  
           pch=20,
           col=c("darkgray","red","blue"))


#Matrix/Data frame 의 행(data) 별 결측치 확인
rowSums(is.na(x))
sum(rowSums(is.na(x))>0) #결측치가 있는 행이 3개이다

sum(is.na(x))   #행열 구분 없이 결측치 4개 있다



#지금까지 행과 열의 결측치 확인을 했음. 이제 처리해보자

#결측치를 제외한 새로운 데이터셋 생성
head(x)
x[!complete.cases(x),] #NA 가 포함된 행출력(! 썼으니까 반대 )           complete.cases(x) 함수를 쓰면 결측치가 포함된 행을 제외시켜준다.
y <- x[complete.cases(x),]
head(y)




        ##이상치(outlier) 
#               1. 논리적으로 성립되지 않는 값
#               2. 상식적으로 용인되지 않는 값 -> 상자수염시각화도구 를 통해 확인가능( boxplot )

st <- data.frame(state.x77)
summary(st$Income)
boxplot(st$Income)
boxplot.stats(st$Income)$out    #6315 가 이상치값이다. 


#데이터 형태를 확인하고 그에따라 결측치, 이상치 찾는다. 그 다음 어떻게 해야하나?
#이상치는 대부분 결측치로 변환시킨다. (나이가 200살 상식적으로 이상함. -> 일단 NA 로 바꾼다. 그 다음 NA 빼고 나머지의 평균 나이를 구해서 집어넣는다.)


#특이값 처리 : NA 로 변환 후 결측치 처리방법 이용
out.val <- boxplot.stats(st$Income)$out
st$Income[st$Income %in% out.val] <- NA        #이상치가 NA 로 바뀜.(st$Income 에 out.val 즉 이상치가 있으면 NA로 바꾸라는것)
head(st)
newdata <- st[complete.cases(st),]            #NA 가 들어간 행 삭제함.
head(newdata)


#일반적인 순서 : 이상치 찾기 -> 결측치로 바꾸기 -> 결측치 전부 찾기 -> 결측치 처리하기

#Data 정제 : 결측치 처리/ 이상치 처리
#Data 가공 : 정렬/ 병합/ 추가/ 필터링/ 집계 
#이게 끝나면 데이터 전처리 끝



#
#데이터 가공
#
#1. 데이터 정렬
##vector 정렬 -> sort 함수
v1 <- c(1,7,6,8,4,2,3)
order(v1)    
v1 <- sort(v1)
v1
v2 <- sort(v1,decreasing=T)
v2

##Matrix/ Data Frame 정렬
head(iris)
order(iris$Sepal.Length)           #꽃받침의 길이를 order 씀 ( 첫번째 행이 정렬했을때 14번째다. )
iris[order(iris$Sepal.Length),]  #Ascending
iris[order(iris$Sepal.Length,decreasing=T),] #Descending
iris.new <- iris[order(iris$Sepal.Length),]
head(iris.new)
iris[order(iris$Species,decreasing=T,iris$Sepal.Length),] #정렬기준을 2개 설정


#2.데이터 분리
sp <- split(iris, iris$Species)
sp 
summary(sp)
summary(sp$setosa)
sp$setosa


#3. 데이터 선택
subset(iris,Species=="setosa")
subset(iris,Sepal.Length>7.5)
subset(iris,Sepal.Length>5.1&Sepal.Width>3.9)
subset(iris,Sepal.Length>7.6, select=c(Petal.Length,Petal.Width))


#4. 데이터 sampling (비복원추출/복원추출)
# 숫자를 임의로 추출 (Vector)
x <- 1:100
y <- sample(x,size=10,replace=FALSE)
y


#행을 임의로 추출
idx <- sample( 1:nrow(iris),size=50,replace=FALSE)
iris.50 <- iris[idx,]
dim(iris.50)
head(iris.50)

sample(1:20,size=5)   #이건 복원추출
sample(1:20,size=5)
sample(1:20,size=5)

set.seed(100)             #sample 전에 set.seed 를 쓰면 동일한 값 나옴.
sample(1:20,size=5)
set.seed(100)
sample(1:20,size=5)
set.seed(100)
sample(1:20,size=5)

#5. 데이터 조합
combn(1:5,3)       #combination : 1~5 사이의 3가지 수를 뽑는 것의 결과

x=c("red","green","blue","black","white")
com <- combn(x,2)
com


for(i in 1:ncol(com)){
  cat(com[,i],"\n")
}



#6. 데이터 집계
agg <- aggregate(iris[,-5],by=list(iris$Species),FUN=mean) #aggregate는 집계함수( 집계할 대상,집계할 기준, 집계해서 할 동작)
agg  #품종별 꽃잎길이의 평균, 너비의 평균, 등등이 구해진다.

agg <- aggregate(iris[,-5],by=list(iris$Species),FUN=sd) 
agg  

head(mtcars)
agg <- aggregate(mtcars,by=list(cyl=mtcars$cyl,vs=mtcars$vs),FUN=max)
agg    #cyl(실린더수) 와 vs 를 기준으로  max 를 구한다. 


#7. 데이터 병합
x <- data.frame(name=c("a","b","c"),mat=c(90,80,40))
y <- data.frame(name=c("a","b","d"),korean=c(75,60,90))
z <- merge(x,y,by=c("name"))   #merge 는 합친다. 공통변수 name 에 같은 값들만 나옴
z


merge(x,y)
merge(x,y,all.x=T)
merge(x,y,all.y=T)
merge(x,y,all=T)


x <- data.frame(name=c("a","b","c"),mat=c(90,80,40))
y <- data.frame(sname=c("a","b","d"),korean=c(75,60,90))
merge( x, y, by.x = c("name"), by.y = c("sname" ))


#
#dplyr package
#
install.packages("dplyr")            #%>% : pipe 연산자 ( 단축기 : 왼쪽 ctrl + 왼쪽 shift + M ) 
library(dplyr)

df <- data.frame(var1=c(1,2,1),var2=c(2,3,2))
df

#rename () : 이름변경
df <- rename(df,v1=var1,v2=var2)   #왼쪽이 바뀐 이름 오른쪽이 원래 이름이다
df

#파생변수 추가
df$sum <- df$v1+df$v2
df

df[2,1] <- 5
df

df <- data.frame(id=c(1,2,3,4,5,6),class=c(1,1,1,1,2,2),math=c(50,60,45,30,25,50),english=c(98,97,86,98,80,89),science=c(50,60,78,58,65,98))
df

#filter() : 행추출
df %>% filter(class==1)    #df 를 입력해서 filter(class==1) 을 출력한다.
df %>% filter(class==2)
df %>% filter(class!=1)
df %>% filter(class!=2)

df %>% filter(class==1) %>% filter(math>=50)

df %>% filter(science>70)
df %>% filter(math<50)

df %>% filter(class==1 & math>=50)
df %>% filter(math>=50|english>=90)
df %>% filter(class %in% c(1,3,5))

class1 <- df %>% filter(class==1)
class2 <- df %>% filter(class==2)
class1
class2                        #split 함수와 비슷함


#select() : 변수 추출 (열추출)
df %>% select(math)
df %>% select(science)
df %>% select(class,math,science)
df %>% select(-math)

#dplyr 함수 조합
df %>% 
  filter(class==1) %>% 
  select(science)

df %>% 
  select(id, science) %>% 
  head


df %>% 
  select(id,science) %>% 
  max

#arrange() : 정렬
df %>% arrange(science)
df %>% arrange(desc(science))


#mutate() : 파생변수 추가
df %>% 
  mutate(total=math+english+science) %>% 
  head

df %>% 
  mutate(total=math+english+science, average=(math+english+science)/3) %>% 
  head

df %>% 
  mutate(grade=ifelse(science>=60, "pass","fail")) %>% 
  head




df %>% 
  mutate(total=math+english+science, average=(math+english+science)/3) %>% 
  mutate(grade=ifelse(average>=90,"pass",ifelse(average<60,"fail","normal"))) %>% 
    head


df.sort<- df %>% 
  mutate(total=math+english+science, average=(math+english+science)/3) %>% 
  arrange(desc(average)) %>% 
  head

df.sort



#summarise() : 집단별 요약
#group_by() : 집단별나누기
df %>% summarise(mean_math=mean(math))      #math의 평균을 mean_math 란 이름으로 요약정보를 제공한다.

df %>% 
  group_by(class) %>%    
  summarise ( mean_math= mean(math),
              mean_english=mean(english),
              mean_science=mean(science),
              n=n())
               #group_by : 그룹핑 
              #class로 그룹핑하고(1반,2반) 요약한다. 수학평균,영어평균,과학평균,빈도수를 제공한다. n() 은 빈도수를 계산해주는 함수다




install.packages("ggplot2")
str(ggplot2::mpg)           #mpg 란 데이터셋이 있는데, 그걸  ggplot2 가 가지고 있다는 의미 (원래는 설치하고 library 해야하는데 그걸안하고 쓸 수 있는 방법이 "패키지이름::데이터셋이름" 이라고 쓰는것이다. )
mpg <- data.frame(ggplot2::mpg)
dim(mpg)
str(mpg)
head(mpg)
View(mpg)  #대문자쓰기

mpg %>% 
  group_by ( manufacturer,drv) %>% 
  summarise(mean_cty=mean(cty)) %>% 
  head(10)

mpg %>% 
  group_by ( manufacturer) %>% 
  filter(class=="suv") %>% 
  mutate(tot=(cty+hwy)/2) %>% 
  summarise(mean_tot=mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)





#데이터 합치기
#left_join() : 가로로 합치기 ( 변수추가)
#inner_join() : 가로로 합치기(변수추가)
#full_join() : 가로로 합치기(변수추가)
#blind_rows() : 세로로 합치기(data 추가)
df1 <- data.frame(id=c(1,2,3,4,5),midterm=c(60,80,70,90,85))
df2 <- data.frame(id=c(1,2,3,4,5),final=c(60,80,70,90,85))
total <- left_join(df1,df2,by="id")

df1 <- data.frame(id=c(1,2,3),address=c("서울","부산","제주"),stringsFactors=F)  #stringsFactors=F 은 팩터로 만들지 마라??
df2 <- data.frame(id=c(1,2,4),gender=c("남","여","남"))
df_left <- left_join(df1,df2,by="id")  #df1 이 기준이다
df_left
df_inner <- inner_join(df1,df2,by="id")  #df1,df2 동일하게 있는 것들만 
df_inner
df_full <- full_join(df1,df2,by="id")
df_full


df1 <- data.frame(id=c(1,2,3,4,5),test=c(60,80,70,90,85))
df2 <- data.frame(id=c(1,2,3,4,5),test=c(60,80,70,90,85))
df_all <- bind_rows(df1,df2)
df_all          #행추가 




install.packages("psych")
library(psych)

summary(mtcars)
describe(mtcars)       #describe 는 summary 랑 비슷하지만 더 많은 내용을보여준다. 




install.packages("descr")
library(descr)

df <- data.frame(id=c(1,2,4),gender=c("남","여","남"))

table(df$gender) 
freq(df$gender)    #freq 는 도수분포표도 그려주고 막대그래프도 그려준다.
freq(df$gender,plot=F)  #막대그래프 필요없으면 plot=F 라고 옵션주기




#172~233
