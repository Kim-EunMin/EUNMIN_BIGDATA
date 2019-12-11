#김은민
#2019-12-11   (HW)
#
#문제1) 20대 국회 개원 여·야 3당 대표 국회연설문에 대해 각각 워드클라우드를 작성하시오.
#          예제소스 파일은 ‘ex_10-1.txt’, ‘ex_10-2.txt’, ‘ex_10-3.txt’이다.

#1-1) ex_10-1 분석
##단계 1. 사전 설정
library(KoNLP)
useSejongDic()          

##단계 2. 텍스트 데이터 가져오기
setwd("D:/EUNMIN_BIGDATA")
text1 <- readLines("ex_10-1.txt",encoding="UTF-8")
text1

##단계 3. 명사추출
text1_1 <- sapply(text1,extractNoun,USE.NAMES=F)
text1_1

##단계 4. 백터로 변환
undata1 <- unlist(text1_1)
undata1

##단계 5. 사용빈도 확인
word_table1 <- table(undata1)
word_table1

##단계 6. 필터링 : 2글자 이상 단어만 선별, 불필요한 단어 삭제
undata1_1 <- undata1[nchar(undata1)>=2]
undata1_1 <- gsub("그것","",undata1_1)
undata1_1 <- gsub("여러분","",undata1_1)
undata1_1 <- gsub("그동안","",undata1_1)
undata1_1 <- gsub("민국","",undata1_1)
undata1_1 <- gsub("때문","",undata1_1)
word_table1_1 <- table(undata1_1)
word_table1_1

##단계 7. 데이터 정렬
sort(word_table1_1,decreasing=T)
library(wordcloud)
pal <- brewer.pal(8,"Dark2")
wordcloud(names(word_table1_1),freq=word_table1_1,scale=c(6,0.7),random.order=F, colors=pal,min.freq = 5)



#문제2) 스티브 잡스의 스탠포드 대학 졸업식 연설문에 대해 워드클라우드를 작성하시오.
#        Tip. 예제소스 파일은 ‘ex_10-4.txt’이다.      

##단계 1) 사전 설정 & 자료수집
setwd("D:/EUNMIN_BIGDATA")
text4 <- readLines("ex_10-4.txt",encoding="UTF-8")  
buildDictionary(ext_dic="woorimalsam")

##단계 2) 명사추출
text4_1 <- sapply(text4,extractNoun,USE.NAMES = F)
text4_1

##단계3) 벡터 변환 & 빈도 계산
noun4 <- unlist(text4_1)
wordcount4 <- table(noun4)
wordcount4

##단계 4) 전처리(생략된 단어를 사전에 등재)
add_word <- c("청강","픽사","자퇴","스탠포드","뜻")
buildDictionary(ext_dic="woorimalsam",
                user_dic=data.frame(add_word, rep('ncn',length(add_word))),
                replace_usr_dic = T)
noun4 <- sapply(text4,extractNoun,USE.NAMES = F)    
noun4 <- unlist(noun4)


##단계 5) 전처리(불필요한 단어 삭제)
noun4 <- noun4[nchar(noun4)>1]
noun4 <- gsub("훌륭","",noun4)  
noun4 <- gsub("때문","",noun4) 
noun4 <- gsub("여러분","",noun4) 
noun4 <- gsub("그때","",noun4) 
noun4 <- gsub("그것","",noun4) 
noun4 <- gsub("개월","",noun4)
noun4 <- gsub("들이","",noun4)

##단계 6) word cloud 작성
noun4
wordcount <- sort(table(noun4))

wordcloud(names(wordcount),freq=wordcount,scale=c(6,0.7),random.order=F, colors=pal,min.freq = 4)




#문제3) 오바마 대통령의 데통령 당선 연설문에 대해 워드클라우드를 작성하시오
#       Tip. 예제소스 파일은 ‘ex_10-5.txt’이다.
##
library(KoNLP)
useSejongDic()
setwd("D:/EUNMIN_BIGDATA")
word_data <- readLines("ex_10-5.txt",encoding="UTF-8")  

word_data2 <- sapply(word_data,extractNoun,USE.NAMES = F)
word_data2
undata <- unlist( word_data2 )
undata
word_table <- table(undata)
word_table
undata2 <- undata[nchar(undata)>=2]
undata2


undata2 <- gsub("때문", "",undata2)
undata2 <- gsub("들이", "",undata2)
undata2 <- gsub("이것","",undata2)
undata2 <- gsub("당신들","",undata2)


buildDictionary(user_dic = data.frame("미국","ncn"),
                replace_usr_dic = T)
get_dictionary('user_dic')

word_table2 <- sort(table(undata2),decreasing = F)

library(wordcloud2)
wordcloud2(word_table2)
