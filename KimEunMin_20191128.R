#김은민
#2019-11-28
#
#문제1)
d1 <- 1:50
d2 <- 51:100

d1;d2;           #1
length(d2)       #2
d1+d2    #3
d2-d1    #3    
d1*d2    #3
d2/d1    #3
sum(d1)  #4
sum(d2)  #4
sum(d1,d2)  #5
max(d2)     #6
min(d2)     #6
mean(d2)    #7
mean(d1)    #7
mean(d2)-mean(d1)   #7
sort(d1,decreasing=TRUE) #8
sort(d1,decreasing=FALSE) #9
sort(d2,decreasing=FALSE) #9
a <- head(sort(d1,decreasing=FALSE),10)  #9
b <- head(sort(d2,decreasing=FALSE),10)  #9
d3 <- c(a,b)     #9
d3               #9


#문제2)
v1 <- 51:90
v1[v1<60]     #1
v1[v1<70]     #2
length(v1[v1<70]) 

#2
v1[v1>65]     #3
sum(v1[v1>65])     #3
v1[v1>60&v1<73]    #4
v1[v1<65|v1>80]    #5
v1[v1%%7==3]       #6
v1[v1%%7==0]<-0    #7
v1[v1%%2==0]       #8
sum(v1[v1%%2==0])  #8
v1[v1%%2==1|v1>80]    #9
v1[v1%%3==0&v1%%5==0&v1!=0]  #10
v1[v1%%2==0&v1!=0]*2         #11
v1[v1%%7!=0]       #12
