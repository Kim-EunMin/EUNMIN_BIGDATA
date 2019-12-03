#김은민
#2019-12-03 
#
#문제1) 다음은 직장인 10명의 수입과 교육받은 기간을 조사한 자료이다. 산점도와 상관계수를 구하고, 
#      수입과 교육기간 사이에 어떤 상관관계가 있는지 설명하시오.

#              수입 	 121 99 41 35 40 29 35 24 50 60
#             교육기간 19  20 16 16 18 12 14 12 16 17

income <- c(121,99,41,35,40,29,35,24,50,60)
day <- c(19,20,16,16,18,12,14,12,16,17)
tb1 <- data.frame(income,day)

plot(income~day,data=tb1)
res <- lm(income~day,data=tb1)
res
abline(res)
cor(income,day)

# 산점도와 상관계수를 확인했을때, 수입과 교육기간 사이에는 강한 양의 상관관계가 있다. 
# 즉 교육일수가 많을수록 수입이 높다.





#문제 2) 다음은 대학생 10명의 성적과 주당 TV 시청시간을 조사한 자료이다. 산점도와 상관계수를 구하고, 
#         성적과 TV 시청시간 사이에 어떤 상관관계가 있는지 설명하시오.

#             성적 	 77.5 60 50 95 55 85 72.5 80 92.5 87.5
#           시청시간 14   10 20  7 25  9 15   13  4   21

score <- c(77.5,60,50,95,55,85,72.5,80,92.5,87.5)
time <- c(14,10,20,7,25,9,15,13,4,21)
tb2 <- data.frame(score,time)

plot(score~time, data=tb2)
res2 <- lm(score~time,data=tb2)
res2
abline(res2)
cor(score,time)

# 산점도와 상관계수를 확인했을때, 성적과 TV 시청시간 사이에는 강한 음의 상관관계가 있다.
# 즉 TV 시청시간이 많을수록 성적은 낮다.






#문제 3) R에서 제공하는 mtcars 데이터셋에서 mpg와 다른 변수들 간의 상관계수를
#         구하시오. 어느 변수가 mpg와 가장 상관성이 높은지 산점도와 함께 설명하시오.	

class(mtcars)
str(mtcars)
head(mtcars)     #cyl, vs, am, gear, carb 는 factor

var <- c("mpg","disp","hp","drat","wt","qsec")
target <- mtcars[,vars]
pairs(target,main="mtcars")
cor(target)

# mpg 와 가장 상관성이 높은 변수는 wt 이다 ( -0. 867 로 강한 음의 상관관계가 있다 )
# mpg 가 높을수록 wt 는 낮다.






#문제 4) 다음은 2015년부터 2026년도까지의 예상 인구수 추계자료이다. 
#        연도를 x축으로 하여 선그래프를 작성하시오.

#        연도		총인구 (천명)		연도		총인구 (천명)
#        2015	   51014				  2021	 	 52123
#        2016 	 51245				  2022	 	 52261
#        2017		 51446			  	2023		 52388
#        2018		 51635				  2024		 52504
#        2019		 51811				  2025		 52609
#        2020		 51973				  2026		 52704

year <- 2015:2026
population <- c(51014,51245,51446,51635,51811,51973,52123,52261,52388,52504,52609,52704)
plot(year,population,main="예상 인구수", type="l",lty=3,lwd=2,xlab="year",ylab="population")






#문제 5) R에서 제공하는 trees 데이터셋에 대해 다음 문제를 해결하기 위한 R 코드를 작성하시오.

#(1) 나무의 지름(Girth)과 높이(Height)에 대해 산점도와 상관계수를 보이시오.

trees
class(trees)
str(trees)
dim(trees)
head(trees)

plot(Height~Girth,data=trees)
res3 <- lm(Height~Girth, data=trees)
res3
abline(res3)
cor(trees$Girth, trees$Height)
cor(trees[,c(1,2)])

#나무의 지름과 높이 사이에는 양의 상관관계가 있다. ( 지름이 길수록 나무의 높이도 길다 )



#(2) trees 데이터셋에 존재하는 3개 변수 간의 산점도와 상관계수를 보이시오.

pairs(trees[,c(1,2,3)],main="나무의 관계")
cor(trees[,c(1,2,3)])

#Girth 와 Volume 간에 강한 양의 상관관계가 있다. 