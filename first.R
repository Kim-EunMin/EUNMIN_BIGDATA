#
# R 프로그래밍 1일차
#
# first.R
#
# 작성자 : 김은민
#
# 최초작성일 : 2019.11.26
#
#
print("Hello, World!!!")

number <- 10   #왼쪽 alt + - 누르기
number2 = 100   #범위지정 shift+enter , ctrl +enter 하면 오른쪽에변수생성

#변수 : 값을 저장하는 기억장소 , 값쓰기와 값 읽기 기능이 있다. 값쓰기는 치환연산자 왼쪽, 읽기는 치환연산자 오른쪽

number3 <- number


numberValue <- 1
str_value <- "R Language"
booleanvalue <- TRUE


numberValue <- "R script"

numberValue <- 1

print(numberValue)     
print(str_value)
print(booleanvalue)

#print 은 단순 인쇄할때, cat 은 결합해서 인쇄할때 쓴다 (print 와 cat 도 값읽기 기능의 하나이다, 읽기 기능을 하는 출력명령어)



cat ( "Numeric number: ", numberValue, "\n")    #"\n" 은 줄바꿔라  "\t" 은 tab
cat ( "String : ", str_value, "\n" )
cat ("Boolean value : ", booleanvalue, "\n" )


cat("Numberic number:", numberValue, "\n", "\t",3)


numberValue <- scan()   #쓰기 기능을 하는 입력명령어

cat( "Numeric number : ", numberValue, "\n" )



#산술연산 (결과값은 숫자형)


number1 <- 10
number2 <- 20
resultAdd <- number1 + number2
resultSub <- number1 - number2
resultMul <- number1 * number2
resultDiv <- number1 / number2
resultRem <- number2 %% number1  #나머지
resultSec <- number2 ^ 5   #number2 ** 5 도 같다.


print( resultAdd )
print( resultSub )
print( resultMul )
print( resultDiv )
print( resultRem )
print( resultSec )


number1 <- 0
number1 <- number1 + 10
number1
number1 <- number1 + 10
number1
number1 <- number1 + 10
number1

number2 <- 100
number1 <- number2 + 10
number1
number2

print(number1 + 10 * number2 /2 )

#누적할때는 반드시 누적이전에 초기값 설정해야한다
number300 <- number300 + 10
number300

number300 <- 10
number300 <- number300 + 10
number300

number301 <- number300 * 2
number301   #number301은 누적이 아니라 치환이기때문에 초기값 설정 불필요


number1 <-  10.5
number2 <-  10
print( number1 > number2 )
print( number1 >= number2 )
print( number1 < number2 )
print( number1 <= number2 )
print( number1 == number2 )
print( number1 != number2 )


print( number1 > 10 & number2 > 10)  #AND
print( number1 > 100 | number2 > 10)   #OR
print( !number1 > 10 )     #Not


number <- 100
str <- "R language"
result = number + str
print ( result )


#제어구조- 선택구조

  ##양자택일형 구조

job.type <- 'A'

if(job.type =='B') {
  bonus <- 200
} else {
  bonus <-100
}
cat("joy type : ",job.type, "\t\tbonus : ", bonus)
cat("joy type : ",job.type, "\tbonus : ", bonus)


  ##단순택일형 구조
job.type <- 'B'

if( job.type == 'A'){
  bonus <- 200
}
cat( "joy type : ",job.type, "\t\tbonus : ",bonus)


  ##다중선택 구조

score <- 85


if( score >= 90) {
   grade <- 'A'
} else if (score >= 80) {
  grade <- 'B'
} else if (score >= 70) {
  grade <- 'C'
} else if (score >= 60) {
  grade <- 'D'
} else {
  grade <- 'F'
}

cat( "score : ", score, "\t\tgrade : ", grade)




##문제
number <- 10
if( number %% 2 == 0) {
  answer <- "짝수이다"
} else  {
  answer <- "홀수이다"
}

cat("Number : ",number,"는 ", answer)



##선생님 답
number <- 10
remainder <-  number %% 2

if( remainder ==0 ) {
  oddeven <- "짝수"
} else {
  oddeven <- "홀수"
}

cat("Number :", number, "는", oddeven, " 이다.")



a <- 5
b <- 20

if( a > 5 & b >5) {
  cat(a, "> 5 and ",b,">5 ")
} else {
  cat (a, "<=5 or",b,"<=5")
}


a <- 10
b <- 20

if(a>b) {
  c <- a
} else {
  c<- b
}
cat( "a = ", a, "\tb = ",b,"\tc = ", c )

#간결하게 쓰기
c <- ifelse( a > b, a, b)
cat("a = ", a, "\tb = ", b,"\tc = ", c )



help(ifelse)



#문제 : 제일 큰 수를 max 에 저장후 출력하라
a <- 10
b <- 10
c <- 3

help(max)

max <- max(a,b,c)


#선생님 답
cat( "a = ", a, " b = ", b, "c =", c, "max =", max )



a <- 10
b <- 16
c <- 8
max <- a
if(b >max) {
   max=b
}
if(c>max) {
  max =c
}
cat("a=",a,"b=",b,"c=",c,"max=",max)


#
#반복구조
#
#for문

for(i in 1:10) {
  print(i)
}


multiple=2
for(i in 2:9) {
  cat (multiple, 'X', i, ' = ', multiple * i, '\n' )
}



#while 문 (조건이 거짓이면 끝난다,거짓이면 빠져나간다 반복제어변수 필수 여기서는 i다)
i <- 1
while (i <= 10) {
  print( i )
  i <- i + 1
}

#무한반복주의(i<-i+1이 없으면 무 한반복한다)

multiple <- 2
i<-2
while( i <= 9 ) {
  cat(multiple, 'X', i, "=",multiple * i, "\n")
  i<-i+1
}

#의미 : i가 2부터 시작, 10일때 빠져나간다



#문제 : 1~100까지 한줄에 10개씩 출력 (for 문 사용)

for(i in 1:100) {
  print(i,'\n')
}



#선생님답

#1 
lineCount <- 1               #초기화
for( i in 1:100) {
  cat(i,'')
  lineCount <- lineCount + 1
  if (lineCount > 10) {
    print( '\n' )
    lineCount <- 1              #RESET
  }
}

#2
for ( i in 1:100) {
  cat(i, ' ' )
  if ( i %% 10 == 0 ) {
    print( '\n' )
  }
}


##11/28
#HW 실습문제 1
#1~1000 까지 3의 배수와 5의 배수를 한줄에 10개씩 출력하고 마지막에 개수를 출력
##문제를 보면 필요한 변수가 보인다:1~1000까지를 제어해줄 반복변수 1개 필요(i)+한줄에 10개씩 출력하라했으니까 개수를 세줄 변수 1개 필요(linecount)
##+개수를 또 구하라했으니까 그 변수 1개 필요(count)


linecount <-1
count<-0
for (i in 1:1000) {
  if(i%%3==0 | i%%5==0) {
    cat(i,"")
    linecount <- linecount+1
    count <- count+1
    if(linecount>10|i==1000){
      cat(count,'\n')
      linecount<-1
         }
  }
}



##선생님
#R 기본 자료형: 숫자,문자,논리,NULL(아무것도 없다)
i<-1
count <- 0
lineCount<-1
multiple3<-NULL
multiple5<-NULL
while(i<=1000) {
  multiple3 <- i%%3
  multiple5 <- i%%5
  if(multiple3==0|multiple5==0){
    count <- count+1
    cat(i,"")
    lineCount <- lineCount+1
    if(lineCount>10){
      lineCount<-1
      print('\n')
    }
  }
  i<-i+1
}
print('\n')
cat('1~1000사이의 3의 배수와 5의 배수의 개수 :',count,'\n')