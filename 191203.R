








grp <- factor(grp)
grp
grp <- factor(grp,levels=c("H","M","L"))
myds <- data.frame(myds,grp)
head(myds)

# 3단계 : 데이터셋의 형태와 기본적인 내용 파악
str(myds)
head(myds)
table(myds$grp)      #factor 타입 있으니까 도수분포표정도는 만들어볼 수 있다.


#4단계 : 히스토그램에 의한 관측값의 분포 확인
par( mfrow=c(2,3))
for(i in 1:5) {
  hist(myds[,i],main=colnames(myds)[i],
       col="yellow")
}                                                        #str 보면 변수5개는 전부 연속형이다.( 범주형 아님) -> 히스토그램 그려봄
par(mfrow=c(1,1))                                     #히스토그램은 rm 처럼 정규분포모양(종모양) 이 나오는게 제일 좋다.

#crim 범죄율은 한쪽에 치우침, rm 정규분포모양이다. tax 은 모양이 이상함. medv 도 완전하진 않지만 종모양이다.


                              
#5단계 : 상자그림에 의한 관측값의 분포 확인
par( mfrow=c(2,3))
for(i in 1:5) {
  boxplot(myds[,i],main=colnames(myds)[i])
}                                                        #str 보면 변수5개는 전부 연속형이다.( 범주형 아님) -> 히스토그램 그려봄
par(mfrow=c(1,1))  

#상자그림을 통해 분포와 이상치 볼 수 있다. 범죄율 이상치 많다/ tax 는 이상치 없다. 
#나중에 전처리 할때 이상치 처리를 해줘야한다.
#세금은 높은 편이다. 란 정보도 얻을 수 있다.

#6단계 : 그룹별 관측값 분포 확인
boxplot(myds$crim~myds$grp,main="1인당범죄율") #집값 낮은 곳이 범죄율 높다다
boxplot(myds$rm~myds$grp, main="방의 개수")  #집값이 높을 수록 방의 수도 높다
#이런식으로 다른것도 확인 가능

#7단계 : 다중 산점도를 통한 변수 간 상관 관계 확인
pairs(myds[,-6])
 #rm과 medv 가 상관관계가 있어보인다. 

#8단계 : 그룹 정보를 포함한 변수 간 상관관계 확인
point <- as.integer(myds$grp)
color <- c("red","green","blue")
pairs(myds[,-6],pch=point, col=color[point])

 #iris .를 품종별로 나타낸것처럼 grp 로 나눠서 쓴다. (7단계와 8단계는 똑같으나 8단계는 그룹별로 확인)

#9단계 : 변수 간 상관계수 확인
cor(myds[,-6])


