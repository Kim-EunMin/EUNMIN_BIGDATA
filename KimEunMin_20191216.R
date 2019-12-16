#김은민
#2019-12-16 (HW)
#
#문제1) state.x77 데이터셋에서 문맹률(Illiteracy)을 이용해 범죄율(Murder)을 예측하는 
# 단순선형 회귀모델을 만드시오. 그리고 문맹률이 0.5, 1.0, 1.5일 때 범죄율을 예측하여 보시오.
state.x77 <- as.data.frame(state.x77)
plot(Murder~Illiteracy,data=state.x77)
model <- lm(Murder~Illiteracy,data=state.x77)  
model
abline(model)

coef(model)

new_Illiteracy <- data.frame(Illiteracy=c(0.5,1.0,1.5))
predict(model,new_Illiteracy)


#문제2) trees 데이터셋에서 나무둘레(Girth)로 나무의 볼륨(Volume)을 예측하는 단선형 
# 회귀모델을 만드시오. 그리고 나무 둘레가 8.5, 9.0, 9.5일 때, 나무의
# 볼륨(Volume)을 예측하여 보시오.
plot(Volume~Girth,data=trees)
model <- lm(Volume~Girth,data=trees)
abline(model)

new_Girth <- data.frame(Girth=c(8.5,9.0,9.5))

predict(model,new_Girth)

#문제3) pressure 데이터셋에서 온도(temperature)로 기압(pressure)을 예측하는 
# 단순선형 회귀모델을 만드시오. 그리고 온도가 65, 95, 155일 때 기압을 예측하여 보시오.

plot(pressure~temperature,data=pressure)
model <- lm(pressure~temperature,data=pressure)
abline(model)

new_temperature <- data.frame(temperature=c(65,95,155))
predict(model,new_temperature)
