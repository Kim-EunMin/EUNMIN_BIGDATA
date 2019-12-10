#
#11일차
#2019.12.10
#


#www.rdocumentation.org/packages/vcd/versions/1.4-4/topics/mosaic
# 범주형일때 쓴다. (막대그래프는 범주형인데 변수1개 일때 쓴다) 범주형인데 변수 여러개일때, 빈도의 비율을 표현하는 목적으로 쓰는 시각화 도구


#mosaic plot
# 다중변수 범주형 데이터에 대한 각 변수의 그룹별 비율을 면적으로 표시
# 그룹별 비율을 면적으로 표시
str(mtcars)
head(mtcars) 
mosaicplot(~gear + vs, #대상 변수      # ~ 다음이 x 축, + 다음이 y 축이다. 
           data = mtcars, #데이터셋
           color = TRUE, # y측 변수의 그룹별 음영 다르게 표시      
           main = "Gear and VS" )  #제목

#gear 의 수가 3,4,5, 개 있고, vs 0, 1 이 있는데 합쳤다.
#gear 3 인 경우  vs 1 보다 vs 0 의 비율이 더 크다.  (정확한 값보다는 , 그룹별 비율을 면적으로 표현한다 )


mosaicplot( ~gear + vs, data= mtcars,
            color = c("green", "blue"),
            main="Gear and Vs")


tb1 <-  table( mtcars$gear, mtcars$vs)  
tb1  #기어가 3 이고 vs=0 일때 갯수 12개
mosaicplot  (tb1, color= T, main="gear and Vs" )




#
# 차원 축소 (dimension reduction)
# 차원 축소 기법 : t-sne 기법  
install.packages("Rtsne")

library( Rtsne )
library( ggplot2 )

ds <- iris[,-5]
# 변수 4개의 산점도를 그려보자. 4차원이니까 평상시에는 못그렸음 -> 차원을 축소해보자. 2차원형태로 그릴거면 2차원형태로 축소시켜야한다.

# 차원 축소 단계 1 : 중복 데이터 제거
dup <- which(duplicated(ds))  
dup  #143번행에 중복데이터가 있다.

ds <- ds[-dup,]
ds.y <- iris$Species[-dup]   #143번 데이터 지웠으니까 품종에서도 지워준다. 
ds.y

# 차원 축소 단계 2 : 차원 축소 수행 (t-SNE 라는 함수 실행)
# tsne <- Rtsne(ds, #차원 축소 대상 데이터셋
#              dim = 2, #축소할 차원 2/3 차원 )
#              perplexity = 10 ) # 차원 축소 과정에서 데이터 샘플링을 수행하는데 샘플의 갯수,  (대상데이터 수 ) /3 보다 작게 지정 한다.

# => 4차원을 2차원으로 축소한다.  내부적으로 데이터 샘플링을 하면 오류를 좀 줄인다. 그래서 perplexity 를 지정한다. (149/3 보다 작은 것)
tsne <- Rtsne(ds, dim=2, perplexity = 10)
tsne  #차원이 축소 된 것이다.

# 차원축소 결과 시각화
df.tens <- data.frame( tsne$Y )  #  Y 라는 값에 차원축소된 결과가 있다. 
head(df.tens)

ggplot(df.tens, aes(x=X1, y=X2, color=ds.y)) +
  geom_point( size= 2)

# 그래프의 의미 : iris(Sepal.length, width, petal.length, width) 를 X1, X2 로 축소했다. 
# 4 가지  전부(width, length, width, ledngth)  가지고 그린 것이다.                     
#품종별로 분포가 대략 저러하다 라는 것을 알 수 있다. (데이터가 이렇게 군집화 되는 구나를 알 수 있다.  상관관계 강하다 약하다 보긴 어렵다)
# setosa 의 분포는 저기 있고, virginica 의 분포는 저기 있다. 이런식으로 보자                                    


install.packages( c("rgl","car"))
library( car ) 
library ( rgl )
library( mgcv )

tsne <- Rtsne(ds,dims=3, perplexity = 10 )
df.tsne <- data.frame(tsne$Y)
head(df.tsne)

scatter3d ( x= df.tsne$X1, y= df.tsne$X2, z= df.tsne$X3)    # 3차원을 3d 로 그려주는 함수이다. = scatter3d
# 파란색 = 회귀면  (산점도에서 회귀선과 같은 의미,. 예측 정확도가 높은것)  
# 149개 데이터와 회귀면으로 부터 얼마나 떨어져있는지가 오차 라고 보면 된다. 

points <-  as.integer( ds.y)
color <- c("red", "green", "blue" )
scatter3d ( x= df.tsne$X1, y= df.tsne$X2, z=df.tsne$X3,
            point.col=color[points], surface=FALSE)      # 품종별로 여기 있구나를 확인. 데이터 분포를 확인 가능 (4차원d을 3차원으로 축소해서 본 것,  )


# 4차원을 2차원 축소, 3차원 축소 해보는것을 해봤다.
#https://skyeong.net/186





#https://cloud.google.com/maps-platform/#get-started

#
# 공간 시각화
#
# google map 사용
#
# 절차
# 1. R 최신버전 설치
# 2. ggplot2 최신버전 설치
# 3. ggmap 설치
# 4. 구글맵을 사용하기 위한 API key 획득
# 5. 구글맵을 이용한 공간 시각화 수행

install.packages("ggmap")
library(ggmap)
register_google( key= 'AIzaSyDlmljbgzrqBC-ug1Mr1Q1Y4gvEOkOcR_g')       #본인꺼 있으면 본인키 넣기

gc <- geocode( enc2utf8("제주"))   #원하는 지점 경도, 위도 획득
#특정지점의 위도와 경도정보를 알아오는 함수 = geocode/ enc2utf8 은 한글을 번역해주는것. => google 이 알고 있는 제주의 위도 경도값이 나온다. 
gc       #geocode 로 위도,경도를 알아내거나/ 또는 직접 위도,경도를 알아오거나 2가지 

#https://www.google.co.kr/maps

cen <- as.numeric( gc )   #경도/ 위도를 숫자로 변환 (v필수 )  
cen
#반약 내가 위도 경도를 알면 굳이 이렇게 안해도 된다. (geocode, 랑 as.numeric )



# 지도ㅓ표시
map <- get_googlemap ( center = cen) # 지도 중심점 좌표
ggmap (map)     # 진짜 그리는 함수는 ggmap 임



gc <- geocode(enc2utf8("한라산"))
cen <- as.numeric( gc )
map <- get_googlemap( center = cen,        # 지도 중심점 좌표
                      zoom = 10,           # 지도 확대 정도
                      size= c(640,640),    # 지도 크기
                      maptype="roadmap")   # 지도 유형      #hybrid  타입도 있다.
ggmap( map ) 


cen <- c(126.561099,33.253077)   #앞이 위도, 뒤가 경도
map <- get_googlemap(center=cen, zoom=15, maptype="roadmap")
ggmap(map)


# 지도위 마커 표시
gc <- geocode( enc2utf8("제주"))
cen <- as.numeric(gc)
map <- get_googlemap(center=cen,
                     maptype="roadmap",
                     marker=gc)
ggmap(map)

#제주관광지를 지도위에 표시
names <- c("용두암","성산일출봉","정방폭포",
           "중문관광단지","한라산1100고지","차귀도")
addr <- c("제주시 용두암길 15",
          "서귀포시 성산읍 성산리",
          "서귀포시 동홍동 299-3",
          "서귀포시 중문동 2624-1",
          "서귀포시 색달동 산1-2",
          "제주시 한경면 고산리 125")
gc <- geocode( enc2utf8 (addr))
gc

#관광지 명칭과 좌표값으로 Data Frame 생성
df <- data.frame(name=names,lon=gc$lon, lat=gc$lat)
df

cen <- c(mean(df$lon),mean(df$lat))
cen

map <- get_googlemap(center=cen, 
                     maptype="roadmap",
                     zoom=10,
                     size=c(640,640),
                     marker=gc)
ggmap(map)

# 지도에 관광지 이름 추가
gmap <- ggmap(map)
gmap +
  geom_text( data= df, #데이터셋
             aes(x=lon, y=lat), # 텍스트 위치
             size=5, # 텍스트 크기
             label=df$name) # 텍스트 이름




# 지도에 데이터 표시
dim( wind )
str ( wind )
sp <- sample(1:nrow(wind),50)
df <- wind[sp,]
head(df)
cen <- c(mean(df$lon), mean(df$lat))
gc <- data.frame(lon=df$lon, lat=df$lat)
head(gc)




#1. 지도에 마커표시
map <- get_googlemap(center = cen,
                     maptype="roadmap",
                     zoom=6,
                     marker=gc)
ggmap(map)

#2. 지도에 풍속을 원의 크기로 표시
map <- get_googlemap(center = cen,
                     maptype="roadmap",
                     zoom=6)
gmap <- ggmap(map)
gmap+
  geom_point(data=df,
             aes(x=lon,y=lat,size=spd),
             alpha=0.5, col="blue") +     #alpha 투명도, 
  scale_size_continuous( range= c(1,14))     #원 크기 조절 (1,14범위로 원의 크기를 결정한다)




#단계 구분도   (treemap 처럼 색으로 구분)  , stage_diagram 해보기
install.packages("ggiraphExtra")

library(ggiraphExtra)

dim(USArrests)
str(USArrests)
head(USArrests)

library(tibble)
crime <- rownames_to_column(USArrests, var="state")   
crime$state <- tolower(crime$state)  #소문자로 바꾼다.
str(crime)

library(ggplot2)
install.packages("mapproj")
library(mapproj)

state_map <- map_data("state")
str(state_map)

ggChoropleth(data=crime, aes(fill=Murder, map_id=state),      # 이 함수는 국내지도 표현이 잘 안됨
             map=state_map)



#https://rpubs.com/cardiomoon/222145
#한국지도
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")       #github 에 접근하려고 devtools 이용
devtools::install_github("cardiomoon/moonBook2")

library(kormaps2014)
library(moonBook2)


areacode
str(kormap1)

library(ggplot2)
theme_set(theme_gray(base_family="NanumGothic"))

# 단계구분도 그리기 
ggplot(korpop2,aes(map_id=code,fill=총인구_명))+
  geom_map(map=kormap2,colour="black",size=0.1)+
  expand_limits(x=kormap2$long,y=kormap2$lat)+    #경도, 위도를 범위로 지정함/ kormap1은 시도별 2도 있고 3도 있음.
  scale_fill_gradientn(colours=c('white','orange','red'))+ #칠해지는 색깔
  ggtitle("2015년도 시도별 인구분포도")+
  coord_map()     #회전

  