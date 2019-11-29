#김은민
#2019-11-29
#
#문제1)

a<-c(10,40,60,20)
b<-c(21,60,70,30)

score<-matrix(c(a,b),nrow=4,ncol=2)
score                            #1

colnames(score) <- c("male","female")
score                            #2

score[2,]                        #3
score[,"female"]                 #4    
score[3,2]                       #5

#문제2)

data()
state.x77
class(state.x77)
dim(state.x77)
str(state.x77)     
head(state.x77)
tail(state.x77)

st<-as.data.frame(state.x77)     #1
st                               #2
colnames(st)                     #3
rownames(st)                     #4
dim(st)                          #5
str(st)                          #6

rowSums(st)
apply(st,1,sum)
rowMeans(st)
apply(st,1,mean)                 #7

colSums(st)
apply(st,2,sum)
colMeans(st)
apply(st,2,mean)                 #8

st["Florida",]                   #9
st[,"Income"]                    #10
st["Texas","Area"]               #11
st["Ohio",c("Population","Income")]          #12

subset(st,Population>=5000)                  #13
subset(st,Income>=4500)[,c("Population","Income","Area")]    #14

nrow(subset(st,Income>=4500))              #15

subset(st,Area>=100000 & Frost>=120)       #16
subset(st,Population<2000 & Murder<12)     #17

apply(subset(st,Illiteracy>=2.0),2,mean)["Income"]     #18  

a<-apply(subset(st,Illiteracy>=2.0),2,mean)["Income"]
b<-apply(subset(st,Illiteracy<2.0),2,mean)["Income"]
b-a                                                    #19

max(st[,"Life Exp"])
subset(st, st[,"Life Exp"] == max(st[,"Life Exp"]))            #20 (다시하기)



