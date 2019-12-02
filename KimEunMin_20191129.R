#김은민
#2019-11-29
#
#문제1)
#1. 위와 같은 내용의 matrix score 를 생성
a<-c(10,40,60,20)
b<-c(21,60,70,30)
score <- matrix(c(a,b),nrow=4,ncol=2)
colnames(score) <- c("m","f")
score
#2. score의 열 이름을 각각 male, female 로 바꾸시오
colnames(score) <- c("male","female")
score
#3. 2행에 있는 모든 값을 출력
score[2,]
#4. female의 모든 값을 출력
score[,"female"]
#5. 3행 2열의 값을 출력
score[3,2]

#문제2) R에서 제공하는 state.x77 데이터셋을 이용하여 작성
#1. state.x77 을 변환하여 st에 data frame 으로 작성
data()
state.x77
class(state.x77);str(state.x77);dim(state.x77);head(state.x77)
st <- as.data.frame(state.x77)
is.data.frame(st)
#2. st의 내용을 출력
st
#3. st의 열 이름 출력
colnames(st)
#4. st의 행 이름 출력
rownames(st)
#5. st의 행의 개수와 열의 개수 출력
dim(st)
#6. st의 요약 정보 출력
str(st)
#7. st의 행별 합계와 평균 출력
apply(st,1,sum)
rowSums(st)
apply(st,1,mean)
rowMeans(st)
#8. st의 열별 합계와 평균 출력
colSums(st)
apply(st,2,sum)
colMeans(st)
apply(st,2,mean)
#9. Florida 주의 모든 정보 출력
st["Florida",]
#10. 50개 주의 수입(Income) 정보만 출력
st[,"Income"]
#11. Texas 주의 면적(Area) 을 출력
st["Texas","Area"]
#12. Ohio 주의 인구(Population)와 수입(Income) 출력
st["Ohio",c("Population","Income")]
#13. 인구가 5000 이상인 주의 데이터만 출력
subset(st,Population>=5000)
#14. 수입이 4,500 이상인 주의 인구, 수입, 면적을 출력
subset(st,Income>=4500)[,c("Population","Income","Area")]
#15. 수입이 4,500 이상인 주는 몇 개인지 출력
subset(st,Income>=4500)
nrow(subset(st,Income>=4500))
#16. 전체 면적(Area) 이 100,000 이상이고, 결빙일수(Frost) 가 120 이상인 주의 정보 출력
subset(st, Area>=100000&Frost>=120)
#17. 인구(Population) 가 2000 미만이고, 범죄율(Murder)이 12 미만인 주의 정보 출력
subset(st,Population<2000 & Murder<12)
#18. 문맹률(Illiteracy)이 2.0 이상인 주의 평균 수입은 얼마인지 출력
apply(subset(st,Illiteracy>=2),2,mean)["Income"]
#19. 문맹률(Illiteracy) 이 2.0 미만인 주와 2.0이상인 주의 평균 수입의 차이 출력
a <- apply(subset(st,Illiteracy<2),2,mean)["Income"]
b <- apply(subset(st,Illiteracy>=2),2,mean)["Income"]
a-b
#20. 기대수명(Life Exp) 이 가장 높은 주는 어디인지 출력
max(st[,"Life Exp"])
subset(st,st[,"Life Exp"] == max(st[,"Life Exp"]))
rownames(subset(st,st[,"Life Exp"] == max(st[,"Life Exp"])))
#21. Pennsylvania 주보다 수입(Income) 이 높은 주들 출력
st["Pennsylvania","Income"]
subset(st,Income>st["Pennsylvania","Income"])
rownames(  subset(st,Income>st["Pennsylvania","Income"]) )
#문제3) R에서 제공하는 mtcars 데이터셋은 자동차 모델에 대한 재원정보를 담고있다
#1. 이 데이터셋의 자료구조 출력
data()
mtcars
str(mtcars)
#2. 이 데이터셋의 행의 개수와 열의개수 출력
nrow(mtcars)
ncol(mtcars)
#3. 이 데이터셋 열들의 자료형 출력
str(mtcars)
#4. 연비(mpg)가 가장 좋은 자동차 모델 출력
rownames(subset(mtcars,mpg == max(mtcars[,1])))
#5. gear가 4인 자동차 모델 중 연비가 가장 낮은 모델 출력
subset(mtcars, gear==4)
min(subset(mtcars, gear==4)[,1])
rownames(subset(mtcars,mpg==min(subset(mtcars, gear==4)[,1])))
#6.Honda Civic의 연비 (mpg)와 gear 수 출력
subset(mtcars,rownames(mtcars)=="Honda Civic")[,c("mpg","gear")]
#7. Pontiac Firebird 보다 연비가 좋은 자동차 모델 출력#
subset(mtcars,rownames(mtcars)=="Pontiac Firebird")[,1]
subset(mtcars,mpg>subset(mtcars,rownames(mtcars)=="Pontiac Firebird")[,1])
rownames(subset(mtcars,mpg>subset(mtcars,rownames(mtcars)=="Pontiac Firebird")[,1]))
#8.자동차 모델들의 평균 연비 출력
apply(mtcars,2,mean)[1]
#9. gear의 수 종류 출력
factor(mtcars[,"gear"])         #다시풀기

#문제4) R에서 제공하는 airquality 데이터셋은 일별로 대기의 질을 측정한 정보를 담고 있다.
#1. 이 데이터셋의 자료구조 출력
data()
airquality
str(airquality)
#2.이 데이터셋의 앞쪽 일부분만 출력
head(airquality)
#3. 기온(Temp) 의 가장 높은 날은 언제인지 월(Month) 과 일(Day) 출력
max(airquality["Temp"])
subset(airquality,Temp==max(airquality["Temp"]))
subset(airquality,Temp==max(airquality["Temp"]))[,c("Month","Day")]
#4. 6월달에 발생한 가장 강한 바람(Wind)의 세기 출력
max(subset(airquality,Month==6)["Wind"])
#5. 7월 달의 평균 기온(Temp) 출력
subset(airquality,Month==7)
subset(airquality,Month==7)["Temp"]
apply(subset(airquality,Month==7)["Temp"],2,mean)
#6. 오존(Ozone)농도가 100을 넘는 날은 며칠이나 되는지 출력
nrow(subset(airquality,Ozone>100))

#문제5) 
#1.R 에서 제공하는 state.x77 데이터셋에서 수입(Income)이5000 이상인 주의 데이터에서
#수입(Income),인구(Population),면적(Area) 열의 값들만 추출하여 rich_state.csv 에 저장
a<-subset(state.x77,state.x77[,2]>=5000)[,c("Income","Population","Area")]
setwd("D:/workR")
write.csv(a,"rich_state.csv",row.names=T)
#2. 1. 에서 만든 rich_state.csv 파일을 읽어서 ds 변수에저장한후 ds 내용 출력
setwd("D:/WorkR")
ds <- read.csv("rich_state.csv",header=T)