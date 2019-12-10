#김은민
#2019-12-10   (HW)
#
#문제1) R에서 제공하는 state.x77 데이터셋을 차원 축소하여 2차원 산점도와 3차원 산점도를 작성하시오. 
#          (state.x77은 매트릭스 타입이기 때문에 데이터프레임으로 변환하여 실습한다.)
# 2차원 산점도
state.x77 <- as.data.frame(state.x77)
str(state.x77)
head(state.x77)

library(Rtsne)
library(ggplot2)

dup <- which(duplicated(state.x77))
dup

tsne <- Rtsne(state.x77, dim=2, perplexity= 10)
tsne

df.tens <- data.frame(tsne$Y)
head(df.tens)

ggplot(df.tens,aes(x=X1,y=X2)) +
  geom_point(size=5)

#3차원 산점도
library(car)
library(rgl)
library(mgcv)
tsne2 <- Rtsne(state.x77,dims=3,perplexity=10)
df.tsne2 <- data.frame(tsne2$Y)
head(df.tsne2)

scatter3d(x=df.tsne2$X1, y=df.tsne2$X2, z=df.tsne2$X3)
          





#문제2) R에서 제공하는 swiss 데이터셋을 차원 축소하여 2차원 산점도와 3차원산점도를 작성하시오.
# 2차원 산점도
str(swiss)
head(swiss)

dup <- which(duplicated(swiss))
dup

tsne <- Rtsne(swiss,dim=2,perplexity=10)
tsne$Y

df.tens <- data.frame(tsne$Y)

ggplot(df.tens,aes(x=X1,y=X2))+
  geom_point(size=1)

#3차원 산점도
tsne <- Rtsne(swiss,dims=3,perplexity=10)
df.tsne <- data.frame(tsne$Y)
scatter3d(x=df.tsne$X1, y=df.tsne$X2, z=df.tsne$X3)






#문제3) R을 이용하여 지도를 출력하시오.
library(ggmap)
register_google( key= 'AIzaSyDlmljbgzrqBC-ug1Mr1Q1Y4gvEOkOcR_g')
# (1) 서울시청을 중심으로 지도 크기는 600x600, 지도 유형은 roadmap인 지도를 출력하시오.
gc <- geocode(enc2utf8("서울시청"))
cen <- as.numeric(gc)

map <- get_googlemap(center=cen, zoom=10, size=c(600,600), maptype="roadmap")
ggmap(map)

# (2) 금강산 지역을 근방으로 지도 크기는 500x500, 지도 유형은 hybrid, zoom은 8인 지도를 출력하시오.
gc2 <- geocode(enc2utf8("금강산"))
cen2 <- as.numeric(gc2)

map2 <- get_googlemap(center=cen2, zoom=8, maptype="hybrid")
ggmap(map2)

# (3) 강남역 근방으로 지도 크기는 640x640, 지도 유형은 roadmap, zoom은 16인 지도를 출력하시오
gc3 <- geocode(enc2utf8("강남역"))
cen3 <- as.numeric(gc3)
map3 <- get_googlemap(center=cen3, zoom=16, maptype="roadmap",size=c(640,640))
ggmap(map3)

# (4) 지도 유형은 roadmap, zoom은 9인 경도 127.397692, 위도 36.337058 지역의 지도를 출력하시오.
cen4 <- c( 127.397692, 36.337058)
map4 <- get_googlemap(center=cen4, zoom=9,maptype = "roadmap")
ggmap(map4)

# (5) 지도 유형은 roadmap, zoom은 10인 경도 135.502330, 위도 34.693594 지역의 지도를 출력하시오
cen5 <- c(135.502330, 34.693594)
map5 <- get_googlemap(center=cen5, zoom=10,maptype="roadmap")
ggmap(map5)





# 문제4 ) R을 이용하여 서울시 한강 이남의 구청들의 위치에 마커와 구청 이름을 지도 위에 표시하시오.
#강남구, 송파구, 서초구
names <- c("강남구청","송파구청","서초구청")
gc6 <- geocode(enc2utf8(names))
df1 <- data.frame(name=names,lon=gc6$lon,lat=gc6$lat)
cen <-c(mean(df1$lon),mean(df1$lat))

map <- get_googlemap(center=cen,maptype="roadmap",zoom=12,marker=gc6)
ggmap(map) +
  geom_text(data=df1,
            aes(x=lon,y=lat),
            size=5,
            label=df1$name)


# 문제5) R을 이용하여 대한민국의 광역시를 지도 위에 출력하시오.단, 마커와 광역시 이름을 함께 표시하시오.
#부산, 대구, 인천, 광주, 대전, 울산

names <- c("부산광역시","대구광역시","인천광역시","광주광역시","대전광역시","울산광역시")
gc7 <- geocode(enc2utf8(names))
df2 <- data.frame(name=names,lon=gc7$lon,lat=gc7$lat)

cen <- c(mean(df2$lon),mean(df2$lat))

map <- get_googlemap(center=cen,maptype="roadmap",zoom=7,markers=gc7)
ggmap(map)+
  geom_text(data=df2,
            aes(x=lon,y=lat),
            size=5,
            label=df2$name)

# 문제6) R을 이용하여 서울, 경기, 강원 지역의 국립공원 위치를 지도 상에 마커로 표시하되 국립공원의 이름을 함께 표시하시오.
#북한산, 설악산, 오대산, 치안산, 태백산

names <- c("북한산","설악산","오대산","치악산","태백산")
gc8 <- geocode(enc2utf8(names))
gc8
df3 <- data.frame(name=names,lon=gc8$lon,lat=gc8$lat)
cen <- c(mean(df3$lon),mean(df3$lat))
map <- get_googlemap(center=cen,maptype="roadmap",zoom=8,markers=gc8)
ggmap(map) + 
  geom_text(data=df3,
            aes(x=lon,y=lat),
            size=5,
            label=df3$name)

#문제7) ‘2018년도 시군구별 월별 교통사고 자료’로부터 서울시의 각 구별 1년 교통사고 발생건수를 지도상에 원의 크기로 나타내시오.
install.packages("xlsx")
install.packages("rJava")
library(rJava)
library(xlsx) 
setwd("C:/")
accident <- read.xlsx(file="Report.xls",sheetIndex=1,encoding="UTF-8")
accident
accident.count <- accident[c(6:30),c(1,2,3)]
colnames(accident.count) <- c("교통사고","군","사고건수")
accident.count

names <- as.vector(accident.count[,2])
gc <- geocode(enc2utf8(names))
accident.view <- data.frame(name=names,lon=gc$lon,lat=gc$lat,"사고건수"=accident.count$"사고건수")
head(accident.view)

cen <- c(mean(accident.view$lon),mean(accident.view$lat))
gc <- data.frame(lon=accident.view$lon, lat=accident.view$lat)
head(gc)

map <- get_googlemap(center=cen,
                     maptype="roadmap",
                     zoom=12,
                     marker=gc)
ggmap(map)
gmap <- ggmap(map)
gmap+
  geom_point(data=accident.view,
             aes(x=lon,y=lat,size=accident.view$"사고건수"),
             alpha=0.5,col="blue") 
##scale_size_continuous???
