#
# 워드 클라우드 ( Word  Cloud )
#
#Data Mining : 의사결정을 위해서 DB(정형화 Data) 로부터 규칙과 패턴을 발견하는 기법
#Text Mining : Text(비정형 Data) Data 로 부터 규칙과 패턴을 발견하는 기법, 자료 처리 과정과 자료 분석 과정( 분석과정에 사용되는 시각화 도구 => word cloud )

#word cloud 는 단어의 빈도수를 체크한다. (빈도가 높은 단어를 확인해서 그게 왜 높게 나오는지 분석해본다)


# 한글 워드 클라우드 절차
# 1. Java 실행환경 구축  (JDK 설치했었으니 따로 하지 않는다), notion 연결해주자.
# 2. 자료 수집 ( Text 자료 )
#   2.1 text file 형태로 수집    (-메모장으로 열었을때 내용확인이 되면 text file 이다.)
#   2.2 web scraping 을 이용하여 수집    (text file 없으면 직접 내가 웹페이지를 긁어온다)



#mis document 어쩌고를 수집했다. (텍스트 파일 형식이다, 없으면 이런식으로 직접 만든다)
 
# 3. 명사 추출




Sys.setenv ( JAVA_HOME = 'C:/Program Files/Java/jre1.8.0_231') #java 실행환경 위치를 지정해준다. jre 위치 지정(슬래시로 바꾼다)

#필요시 설치
install.packages("wordcloud")      # word cloud
install.packages("wordcloud2")     # word cloud        (wordcloud/ wordcloud2 차이 크게 없음 그냥 선택해라)
install.packages("KoNLP")          # 한국어 처리       (필수 설치 해야 한다.)
install.packages("RColorBrewer")   # 색상 선택         

library(wordcloud)
library(wordcloud2)
library(KoNLP)            #checking user defined dictionary! 라는 설명이 뜬다. KoNLP 에는 사전이 몇개가 있는데, 사전에 따라 저장된 단어수가 다르다. 사용할 때 사전 설정하는게 있다. 후에 진행
library(RColorBrewer)

library(dplyr)            #위에 4개는 워드클라우드에 필요한 패키지/ 아래 2개는 시각화에 쓰는 패키지
library(ggplot2)


setwd("D:/EUNMIN_BIGDATA")
text <- readLines("mis_document.txt",encoding="UTF-8")     #readLines 함수 : 텍스트 파일 한줄씩 읽어라
#mis_document 에는 맨 마지막에 공백줄이 없다.( -> 아래처럼 경고 뜬다 )
# 경고메시지(들): In readLines("mis_document.txt", encoding = "UTF-8") :  'mis_document.txt'에서 불완전한 마지막 행이 발견되었습니다 )
# 꼭 마지막에 빈줄 최소 1줄이상 만들어주자!! (오류 최소화)
text


#자료 수집 했으니, 명사 뽑아 오자. (문장이니까 분석이 안되니까 분석할 대상, 즉 명사를 뽑아오자.)
buildDictionary(ext_dic = "woorimalsam" )  #"우리말씀" 한글사전        
#사전로딩 함수로, 마지막에 우리말씀 한글사전의 단어수가 나온다(약 629897 단어가 들어간 사전이다) , 사전로딩 안하고 KoNLP 에서 다운받아도 된다. 
pal2 <- brewer.pal( 8, "Dark2" )           #색상 팔레트 생성             #8번 다크계열의 색상을 쓸거다.
noun <- sapply(text,extractNoun, USE.NAMES = F )  #명사 추출           #이게 실제 명사 추출하는 것이다. (옵션해석하면 : 명사추출해라, UseNAMES=f 는 행이름은 안쓰겠다는것)
noun     # 사전에 있는 명사들만 뽑아낸다. 실제로는 원본 파일과 비교해서 빠진 단어가 있나 확인해봐야한다. (이게 텍스트 마이닝의 자료 처리 과정 중 하나 이다)
        # 없으면 사용자 사전에 추가해줘야한다. 

#
#  4. 추출된 단어( 주로 명사)에 대한 빈도수 계산 및 시각화
noun2 <- unlist( noun ) #list <- vector 로 변환
wordcount <- table(noun2) #빈도체크 
sort.noun <- sort(wordcount,decreasing=T)[1:10]  #빈도가 높은것에서 낮은 순으로 정렬
sort.noun
sort.noun <- sort.noun[-1]  #공백이여서 이건 의미없으니까  제거해준것이다. 
barplot(sort.noun, names.arg = names(sort.noun), 
        col="steelblue", main="빈도수 높은 단어",
        ylab="단어빈도수")     #아직 전처리 한 건 아니고, 단순히 빈도 체크 한 것이다. 


df <- as.data.frame(sort.noun)       
df
ggplot(df,aes(x=df$noun2,y=df$Freq)) +
  geom_bar(stat="identity",
           width=0.7,
           fill="steelblue") +
  ggtitle("빈도수 높은 단어") +
  theme(plot.title=element_text(size=25,
                               face="bold",
                               colour="steelblue",
                               hjust=0,
                               vjust=1)) +
  labs(x="명사",y="단어빈도수") +
  geom_text(aes(label=df$Freq),hjust=-0.3) + #빈도표시
  coord_flip()   

#막대그래프로 빈도 확인 했으니 실제 워드클라우드작성하자.

# 5. word cloud 작성 
wordcloud ( names (wordcount),    #단어           (출력할 단어가 오는 것)
            freq=wordcount,        #단어 빈도        (빈도에 대한 정보를 넣는다)
            scale=c(6,0.7),        #단어 폰트 크기(최대,최소)
            min.freq=3,            #단어최소빈도         #빈도수 최소 이정도 이상만 나타내라 ( 빈도가 3이상인것만 cloud 에 표현해라)
            random.order=F,        #단어출력위치           #출력위치가 F 이면 빈도가 높은게 가운데로 몰린다.
            rot.per=.1,            #90도 회전단어비율            #회전된 단어들의 비율 (10% 만 회전시켜라)
            colors=pal2)           #단어 색            
#pal3 <- brewer.pal(9,"Blues")[5:9] #로 해봐라.

#글자 큰게 빈도수 높은 것

#그래프를 확인해봤더니  들 이나 한, 하 이런 조사들은 사실 의미가 없음. (자료 처리 과정에서 빼줘야 한다)


# 6. 전처리 과정 수행
#     
#     6.1 생략된 단어를 사전에 등재
buildDictionary(ext_dic="woorimalsam",
                user_dic=data.frame("정치","ncn"),       #단어등록을 한 것이다. ncn 은 명사를 뜻 하는 것이다.=> 정치가 명사로 사전에 등재하겠다. 라는 의미
                replace_usr_dic=T)                 
noun <- sapply(text,extractNoun,USE.NAMES = F)          #단어 추가해서 사전이 바뀌었으니까, 다시 단어추출을 한다. 
noun2 <- unlist(noun)


#     6.2 불필요한 단어 삭제
noun2 <-  noun2[nchar(noun2)>1]     #길이가 1보다 작은 거 삭제
noun2 <- gsub("하지", "",noun2)     #하지, 때문과 같은 조사는 빼겠다. 일부만 한 것이지만 실제로는 다 찾아보고 하나하나빼야한다. 
noun2 <- gsub("때문","",noun2)      #하지를 noun2 로 바꿔라 의 함수가 gsub 이다. 
                                       #table 로 빈도계산하고 다시 wordcloud 를 그려본다. 

# 7. word cloud 작성
wordcount <- table(noun2)
wordcloud ( names (wordcount),    #단어           (출력할 단어가 오는 것)
            freq=wordcount,        #단어 빈도        (빈도에 대한 정보를 넣는다)
            scale=c(6,0.7),        #단어 폰트 크기(최대,최소)
            min.freq=3,            #단어최소빈도         #빈도수 최소 이정도 이상만 나타내라 ( 빈도가 3이상인것만 cloud 에 표현해라)
            random.order=F,        #단어출력위치           #출력위치가 F 이면 빈도가 높은게 가운데로 몰린다.
            rot.per=.1,            #90도 회전단어비율            #회전된 단어들의 비율 (10% 만 회전시켜라)
            colors=pal2)  

#이걸 통해 어떤 경향인지,방향,흐름성을 확인하고 자료수집하면 좀 더 문제에서 요구하는 내용을 파악하기 쉽다. 그와 비슷한 자료를 하기 쉽다.
# 텍스트 마이닝을 언제해야하는지 정해진 것은 없지만 문제정의를 했을때, 문제정의와 관련된 sns ,검색키워드, 등을 검색하면서 활용하는게 도움된다. (그렇다고 처음에 꼭 하라는 건 아니다)


#위는 외부사전인 woorimalsam 을 사용했다. worrimalsam 에 없는 단어인 w정치를 넣기 위해 buildDictiona교ㅕ 6.1 처럼 했다.(user_dic 옵션+ext_dic)
#아래는  KoNLP 라는 라이브러리 안에 있는 내부사전 세종을 쓸건데 세종에 없는 단어를 추가할때는 buildDictionary 해서 user_dic 옵션만 추가해주면됨)





#
# 애국가 형태소 분석
#
library(KoNLP)
useSystemDic()            #사전이다.28만단어 가지고 있는 사전
useSejongDic()            #사전임.
useNIADic()               #사전임.

#
#애국가 가사:
#https://mois.go.kr/frt/sub/a06/b08/nationalIcon_3/screen.do
#
#1. 사전 설정  #세종사전을 쓸 것이다.
useSejongDic()

#2. 텍스트 데이터 가져오기
word_data <-readLines("애국가(가사).txt")
word_data

#3. 명사추출
word_data2 <- sapply(word_data,extractNoun,USE.NAMES=F)
word_data2

#남산이나 백두산이 남산위에 이런식으로 추출된다. 이런식으로 추출되면 안된다. 위에는 필요 없는 단어.  이 사전에 남산 이라는 단어자체가 없는지 있는지 확인해봐야한다.
#3.1 제대로 추출되지 않는 단어를 사용자 사전에 등록

add_words <- c("백두산","남산","철갑","가을","하늘","달")
buildDictionary(user_dic = 
                  data.frame(add_words, rep('ncn',length(add_words))),
                replace_usr_dic = T)
get_dictionary('user_dic')

#3.2 단어 추가 후 다시 명사 추출
word_data2 <- sapply(word_data, extractNoun, USE.NAMES = F)
word_data2                                                     

#4. 행렬을 벡터로 변환
undata <- unlist( word_data2 )
undata

#5. 사용빈도확인
word_table <- table(undata)
word_table

#6. 필터링 : 두 글자 이상 단어만 선별, 공백이나 한 자리 문자를 걸러냄
undata2 <- undata[nchar(undata)>=2]
undata2
word_table2 <- table(undata2)
word_table2

#7. 데이터 정렬
sort(word_table2,decreasing=T)

# 애국가 형태 분석 완료
# 가장 기본적인 전처리만 수행, 100% 정확한 데이터라 볼 수 없음


#8. word cloud 작성 후 분석
library(wordcloud2)
wordcloud2(word_table2)
#분석하고 나서 의미없는 단어들 나오면 다시 빼고 작성                     #밝은달은 이런거 안되면 리스트내에서 직접 강제로 바꾸기 같은 방법으로 써도 됨.


#8.1 배경 및 색상 변경
wordcloud2(word_table2,
           color='random-light',
           backgroundColor="black")

#8.2 모양변경
wordcloud2(word_table2, fontFamily="맑은고딕",size=1.2,color="random-light", #color 는 글자색상,  size 는 글자 크기
           backgroundColor="black",
           shape="star") #shape 는 인쇄되어서 나타나는 모양 (다이아몬트, 트라이앵글 등등이 있다)

#8.3 선택 색상 반복
 wordcloud2(word_table2, size=1.6, color= rep_len(c("red","blue"),
                                                  nrow(word_table2))) #2가지 색상으로만 표현
 wordcloud2(demoFreq, size=1.6,color=rep_len(c("red","blue"),
                                             nrow(word_table2)))

#8.4 일정 방향 정렬
 wordcloud2(word_table2, minRotation=-pi/6,
            maxRotation=-pi/6,
            rotateRatio=1)
 wordcloud2(demoFreq,minRotation=-0.5,
           maxRotation=0.52,rotateRatio=1.3)
 


#웹스크래핑도 확인
 