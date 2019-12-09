#김은민
#2019-12-09  
#
#문제1) R에서 제공하는 mtcars 데이터셋에서 gear(기어의 수)에 대해 ggplot으로 막대그래프를 작성하시오. 
#       단, 제목과 x축 레이블은 ‘기어의 수’, y축 레이블은 ‘빈도수’로 나타내시오.

install.packages("tidyverse")
library(tidyverse)


ggplot(mtcars, aes(x=gear))+     #방법1
  geom_bar(width=0.6)



mtcars                           #방법2
ds <- table(mtcars$gear)
ds <- as.data.frame(ds)
ds

ggplot(ds, aes(x=Var1, y=Freq))+
  geom_bar( stat="identity",
            width=0.6,
            fill="steelblue") +
  labs(x="기어의 수",y="빈도수")









#문제2) R에서 제공하는 mtcars 데이터셋에서 cyl(실린더의 수)에 대해 막대 색이 초록색인 막대그래프를 ggplot으로 작성하시오.

ggplot(mtcars) +                                 #방법1
  geom_bar( mapping=aes(x=cyl),
            width=0.6,
            fill="green")


cyl <- table(mtcars$cyl)                         #방법2
cyl <- as.data.frame(cyl)
cyl

ggplot(cyl, mapping=aes(x=Var1, y=Freq)) +
  geom_bar( stat="identity",
            width=0.6,
            fill="green") +
  labs(x="실린더",y="실린더의 수") +
  ggtitle("실린더의 수") +
  theme(plot.title=element_text(size=25,
                                face="bold",
                                colour="green"))








#문제3)  R에서 제공하는 mtcars 데이터셋에서 mpg(연비)에 대해 구간 간격이 5.0인 히스토그램을 ggplot으로 작성하시오.
ggplot(mtcars, aes(x=mpg)) +
  geom_histogram(binwidth=5)







#문제4) R에서 제공하는 trees 데이터셋의 Girth(나무 둘레)에 대해 ggplot으로 히스토그램을 작성하시오. 
#       여기에서는 히스토그램의 제목, x축 레이블, y축레이블을 한글로 표시하시오. 
#       (구간 간격은 3.0, 막대의 색은 steelblue로 한다.)

ggplot(trees, aes(x=Girth)) +
  geom_histogram(binwidth = 3, fill="steelblue")+
  ggtitle("나무둘레") +
  theme(plot.title=element_text(size=25,
                                face="bold",
                                colour="blue")) +
  labs(x="나무둘레",y="수")








#문제5) R에서 제공하는 mtcars 데이터셋에서 mpg(연비)를 x축으로 하고, wt(중량)를 y축으로 하는 산점도를 
#      ggplot으로 작성하시오. (단, 점의 색은 gear의수에 따라 다르게 표시한다.)
ggplot(data=mtcars)+
  geom_point( mapping=aes(x=mpg,
                          y=wt,
                          color=gear))






#문제6) R에서 제공하는 mtcars 데이터셋에서 mpg(연비)에 대해 ggplot으로 상자그림을 작성하되,
#     cyl(실린더 수)에 따라 그룹을 나누어 작성하시오.

mtcars$cyl <- as.factor(mtcars$cyl)
str(mtcars)

ggplot( data= mtcars,mapping=aes(y=mpg,
                                 fill=cyl)) +
  geom_boxplot()




#문제7) 다음은 2015년부터 2026년도까지의 예상 인구수 추계 자료이다. 연도를 x축으로 하여 ggplot으로 선그래프를 작성하시오.

#       연도		총인구 (천명)		연도		총인구 (천명)
#       2015		51014			     	2021		52123
#       2016		51245		    		2022		52261
#       2017		51446			    	2023		52388
#       2018		51635		    		2024		52504
#       2019		51811		    		2025		52609
#       2020		51973			    	2026		52704	

year <- 2015:2026
population <- c(51014,51245,51446,51635,51811,51973,
                52123,52261,52388,52504,52609,52704)
df <- data.frame(year,population)
df
ggplot(df,aes(x=year,y=population)) +
  geom_line(col="purple")



#문제8) 다음과 같이 데이터셋 us를 생성한 후 물음에 답하시오. 
#        여기서 state.x77은 미국 50개 주의 통계정보가, state.division은 미국 50개 주의 지역 구분 (예: 북부, 중부, 남부……) 
#       정보가 저장된 데이터셋이다.
#        us <- data.frame(state.x77, state.division)

us <- data.frame(state.x77, state.division)
us


##(1) 미국 50개 주에 대해 각각의 주들이 지역구분별로 묶인 트리맵을 작성하시오.
#    또한, 타일의 면적은 Population(인구수), 타일의 색은 Income(소득)으로 나타내고, 
#    각각의 타일에는 주의 이름을 표시하시오. 마지막으로 이 트리맵에서 관찰할 수 있는 것이 무엇인지 설명하시오
us <- data.frame(us,usname=rownames(us))

treemap(us,
        index=c("state.division","usname"),
        vSize="Population",
        vColor="Income",
        type="value")

#해석: East North Central 주의 인구수가 많다. 




##(2)미국 50개 주에 대해 각각의 주들이 지역구분별로 묶인 트리맵을 작성하시오.
#     또한, 타일의 면적은 HS.Grad(고등학교 졸업률), 타일의 색은 Murder(범죄률)로 나타내고, 
#       각각의 타일에는 주의 이름을 표시하시오. 마지막으로 이 트리맵에서 관찰할수 있는 것이 무엇인지 설명하시오.
treemap(us,
         index=c("state.division","usname"),
         vSize="HS.Grad",
         vColor="Murder",
         type="value")

#해석 : Mountain 주의 고등학교졸업률이 높다. 특히 New Mexico 와 Nevada 의 살인율은 높다.
#        반비례???



##(3)us 데이터셋에 대해 x축은 Income(소득), y축은 Illiteracy(문맹률), 원의 크기는Population(인구수), 
#       원의 색은 green(초록색), 원 내부에는 주의 이름을 표시한 버블차트를 작성하시오. 
#       또한 이 버블차트에서 관찰할 수 있는 것이 무엇인지 설명하시오.
symbols(us$Income, us$Illiteracy,
        circles=us$Population,
        bg="green",
        inches=0.3)
text(us$Income, us$Illiteracy,
     rownames(us),
     cex=1,
     col="black")

#해석: 원의 크기가 큰 xx 주의 인구수가 많다/ 수입과 문맹률은 반비례한다.    (???)


##(4) us 데이터셋에 대해 x축은 Illiteracy(문맹률), y축은 Murder(범죄률), 원의 크기는 Area(면적),
#     원의 색은 green(초록색), 원 내부에는 주의 이름을 표시한 버블차트를 작성하시오. 
#      또한 이 버블차트에서 관찰할 수 있는 것이 무엇인지 설명하시오.

symbols(us$Illiteracy, us$Murder,
        circles=us$Area,
        bg="green",
        inche=0.5)
text(us$Illiteracy,us$Murder,
     rownames(us),
     cex=1,
     col="red")

#해석 : 문맹률과 살인률은 비례한다. 원의 크기가 큰 xx 주의 면적은 넓다. 
