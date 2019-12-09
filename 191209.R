#
#10일차
#2019.12.09
#

# markdown 형식 -> 보고서 작성 ( 코딩 스크립트를 바로 보고서로 만든다. )
# https://www.tidyverse.org/packages/      가보기.


#ggplot2 는 품질높은 그래프 그려준다. 다양한 시각화 표현해준다. 

install.packages("tidyverse")   #tidyverse 안에 다양한 게 많다. tidyverse 라 하면 그 안에 있는거 한번에 설치가능
library(tidyverse)  
library(ggplot2)

dim(mpg)
str(mpg)
head(mpg)
View(mpg)              #http://www.dodomira.com/2016/03/18/ggplot2-%EA%B8%B0%EC%B4%88/

ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ,y=hwy))        
#ggplot은 시각화함수, 항상 '+ 연산자'로 연결해야한다. mpg 란 데이터셋에서, displ(중량) , hwy(연비) 와 관련된 산점도를 그려준다.
#geom_point : 산점도를 그려주는 함수
#ggplot 함수와 실제그래프를 그려주는 함수랑 +로 연결되어야한다. (ggplot함수 + geom_point함수)
#mapping 은 인수 지정하는 것


month <- c(1,2,3,4,5,6)
rain <- c(55,50,45,50,60,70)
df <- data.frame(month, rain)
df


ggplot(df,aes(x=month, y=rain)) +       # ggplot(데이터프레임넣기. ggplot에 변수지정하면 mapping 안써도되고 써도 되고, aes 는 꼮 쓰기)
  geom_bar( stat="identity",            #y를 가지고 막대그래프를 만들어라. => stat="identity" 
            width=0.7,
            fill="steelblue")



ggplot(df,aes(x=month, y=rain)) +    #x,y 값은 그대로인데 가로로 눕힌것이다. 
  geom_bar( stat="identity",              
            width=0.7,
            fill="steelblue") +
ggtitle("월별 강수량") +            #ggtitle 은 제목
theme(plot.title=element_text(size=25,         #theme 는 ggtitle 의 형식이다. 
                              face="bold",
                              colour="steelblue")) +
labs(x="월",y="강수량") +       # labs 는 x, y 축 제목
  coord_flip()                #coord_flip() 은 가로축으로 뉘어라.




ggplot(iris, aes(x=Petal.Length)) +     
  geom_histogram( binwidth=0.5)         
# 히스토그램 : 연속형 자료의 빈도체크 -> 꽃잎의 길이를 빈도체크하겠다. (y 값에 의미가 없어서 지정안함)
# binwidth -> 꽃잎의길이를　０．５　단위로 카운트하겠다. 



ggplot( iris, aes( x = Sepal.Width, fill = Species,   #꽃받침 폭을 가지고 히스토그램 그린다. 품종별로 그리고 싶어서, fill 에 품종을 지정했다. fill 은 막대를 채우는 색 말하는 것이다. ( speices 는 범주형이지만 R에서 1,2,3 으록 읽는다)
                 color = Species)) +                #color 는 경계선의 색이다.
  geom_histogram( binwidth = 0.5, position ="dodge") +       #position ="dodge" 옵션을 하면 품종ㅈ별로 각각 그리라는것이다( 옵션 지워봐라)
  theme(legend.position="top")   #theme 를 통해 범례위치를 지정했다.



a <- c("pink","red","blue")
ggplot(iris, aes( x = Sepal.Width, fill = Species,
                  color= Species))+
  geom_histogram(binwidth=0.5, position ="dodge") +
  scale_fill_manual(values=a)         #막대색지정(http://egloos.zum.com/entireboy/v/4800689)



#ggplot2 scatter chart
ggplot(data=iris, mapping=aes(x=Petal.Length,       #ggplot 에 dataframe 과 x,y 를 지정 / geom_point 는 산점도를 그림
                               y=Petal.Width)) +
  geom_point()

ggplot(data=iris) +
  geom_point ( mapping = aes(x=Petal.Length,       #ggplot 에 dataframe 지정/ geom_point에서 x,y 지정하고 점도 찍음
                             y=Petal.Width))     #같은 방식임 





ggplot(data=iris, mapping=aes(x=Petal.Length,
                              y=Petal.Width,
                              color=Species )) +
  geom_point(size=3)+
  ggtitle("꽃잎의 길이와 폭")+
  theme( plot.title = element_text(size=25,
                                   face="bold",
                                   colour="red"))


ggplot(data=iris, mapping=aes(x=Petal.Length,
                              y=Petal.Width,
                              color=Species,
                              shape=Species)) +
  geom_point(size=3)+
  ggtitle("꽃잎의 길이와 폭")+
  theme( plot.title = element_text(size=25,
                                   face="bold",
                                   colour="red"))




a <- c("pink","red","green")
ggplot(data=iris, mapping=aes(x=Petal.Length,
                              y=Petal.Width,
                              color=Species )) +
  geom_point(size=3)+
  ggtitle("꽃잎의 길이와 폭")+
  theme( plot.title = element_text(size=25,
                                   face="bold",
                                   colour="red"))+
  scale_colour_manual(values= a)       #점, 선 색깔은 이거로 바꾸는듯         



#ggplot Box plot
ggplot(data=iris, mapping=aes(y=Petal.Length)) +
  geom_boxplot(fill="yellow")                #boxplot 의 x 값은 의미가 없음. 그러니까 y 를 지정한다


ggplot(data=iris, mapping=aes(y=Petal.Length,
                              fill=Species)) +
  geom_boxplot()   


#ggplot Line chart
year <- 1937:1960
cnt <- as.vector(airmiles)      
df <- data.frame(year,cnt)
head(df)

ggplot(df,aes(x=year,y=cnt)) +
  geom_line(col="red")



# ggplot 작성 graph 꾸미기 (공통)
str( economics )

##사선
ggplot( economics, aes(x= date, y=psavert )) +
  geom_line() +
  geom_abline(intercept = 12.18671,         
              slope=-0.000544 )
   #intercept = y 절편값
   #slope = 기울기

##평행선
ggplot( economics, aes(x=date, y=psavert))+
  geom_line() +
  geom_hline( yintercept = mean( economics$psavert))    # 평균값을 그려줌.
                                  


##수직선
x_inter <- filter(economics,
                  psavert == min( economics$psavert ) )$date         
ggplot(economics,aes( x=date, y=psavert)) +
  geom_line()+
  geom_vline(xintercept=x_inter)



#텍스트 추가
ggplot( airquality, aes(x=Day, y=Temp)) +
  geom_point() +
  geom_text( aes (label=Temp,
                  vjust=0,
                  hjust=0))        #+1, +1 로 바꾸면 하단 좌측모서리에 인쇄됨
                                    #-1,-1 fh 바꾸면 위 오른쪽에 인쇄된다. 일반적으론 0,0 을 많이 준다.

#영역 지정 및 화살표 표시
ggplot( mtcars, aes(x = wt, y=mpg) ) + 
  geom_point() + 
  annotate( "rect", 
            xmin=3,
            xmax=4,
            ymin=12,
            ymax=21,
            alpha = 0.5,      #alpha 0.1~1 사이로 하기 (투명도)
            fill = "skyblue" )

ggplot( mtcars, aes(x = wt, y=mpg) ) + 
  geom_point() + 
  annotate( "rect", 
            xmin=3,
            xmax=4,
            ymin=12,
            ymax=21,
            alpha = 0.5,      
            fill = "skyblue" ) +
  annotate("segment",x=2.5, xend = 3.7,
           y=10, yend=17, color = "red", 
           arrow = arrow() )        #arrow 는 화살표 모양으로 보여지게 해줌

ggplot( mtcars, aes(x = wt, y=mpg) ) + 
  geom_point() + 
  annotate( "rect", 
            xmin=3,
            xmax=4,
            ymin=12,
            ymax=21,
            alpha = 0.5,      
            fill = "skyblue" ) +
  annotate("segment",x=2.5, xend = 3.7,
           y=10, yend=17, color = "red", 
           arrow = arrow() )   +
  annotate("text", x=2.5, y=10,
           label= "point" )


#https://ggplot2.tidyverse.org/     들어가서 reference 들어가봐라



#https://rpubs.com/brandonkopp/creating-a-treemap-in-r (트리맵): 상자하나크기가 데이터의 크기다 . 상자작으면 데이터 크기 작다



#treemap    
install.packages("treemap")
library(treemap)

data( GNI2014 )
dim( GNI2014 )
str(GNI2014)
head(GNI2014)
View(GNI2014)

treemap( GNI2014,
         index = c("continent" , "iso3"),    # 계층구조         #GNI2014 를 continet(e대륙) a밑에 iso3(국가)  로 계층화해라
         vSize = "population",               # 타일 크기         # 타일 사이즈를 인구로 하겠다 ( 인구많으면 타일크기 크다)
          vColor = "GNI",                     # 타일 컬러         #색상은 GNI (총생산)로 해라 ( 진하면 총생산 높다, 연하면 총생산 낮다)
         type = "value",                     # 타일 컬러링 방법    # 값에 의해 타일 색을 정해라
         bg.labels = "yellow",               #레이블 배경색         
         title = "World's GNI" )            # 제목



st <- data.frame(state.x77)
st <- data.frame(st, stname=rownames(st))
treemap(st,
        index=c("stname"),
        vSize="Area",
        vColor="Income",
        type="value",
        title="미국 주별 수입")


#산점도에 Bubble  추가( Bubble chart)
symbols ( st$Illiteracy, st$Murder,        #원의 x,y 좌표
          circles = st$Population,         #원의 반지름      (인구수가 반지름이 된다)
          inches=0.3,                      #원크기 조절값
          fg="white",                      #원 테두리 색
          bg="Lightgray",                  #원 바탕색
          lwd=1.5,                         # 원 테두리선 두께
          xlab="rate of Illiteracy",
          ylab="crime(murder) rate",
          main="Illiteracy and Crime")
text(st$Illiteracy, st$Murder,           #텍스트출력 x,y 좌표
     rownames(st),                       #출력할 text
     cex=0.6,                            #폰트크기
     col="brown")                        #폰트컬러





#https://www.r-graph-gallery.com/index.html  
#ggplot 으로 버블차트 그리기
# Libraries
library(ggplot2)
library(dplyr)
library(plotly)
library(viridis)
library(hrbrthemes)


# The dataset is provided in the gapminder library
library(gapminder)
data <- gapminder %>% filter(year=="2007") %>% dplyr::select(-year)
data
# Interactive version
p <- data %>%
  mutate(gdpPercap=round(gdpPercap,0)) %>%
  mutate(pop=round(pop/1000000,2)) %>%
  mutate(lifeExp=round(lifeExp,1)) %>%
  
  # Reorder countries to having big bubbles on top
  arrange(desc(pop)) %>%
  mutate(country = factor(country, country)) %>%
  
  # prepare text for tooltip
  mutate(text = paste("Country: ", country, "\nPopulation (M): ", pop, "\nLife Expectancy: ", lifeExp, "\nGdp per capita: ", gdpPercap, sep="")) %>%
  
  # Classic ggplot
  ggplot( aes(x=gdpPercap, y=lifeExp, size = pop, color = continent, text=text)) +
  geom_point(alpha=0.7) +          #산점도 그려라
  scale_size(range = c(1.4, 19), name="Population (M)") +
  scale_color_viridis(discrete=TRUE, guide=FALSE) +
  theme_ipsum() +                #버블형식의 산점도가 나온다.
  theme(legend.position="none")

pp <- ggplotly(p, tooltip="text")
pp


