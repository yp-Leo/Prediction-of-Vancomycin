library(xlsx)
library(mice) 
data<- read.xlsx("r'../data/Vanc(missing).xlsx'", 1, encoding = "UTF-8")
names(data)
data_1 <- data[,-1]
names(data_1)
md.pattern(data_1)

tempData <- mice(data_1,m=50,maxit=50,method='rf',seed=500)
summary(tempData)

modelFit1 <- with(tempData,lm(上一次TDM值~ 上一次日剂量+移植术后天数+是否亲属活体+性别+年龄+身高+体重+BMI+CYP3A5+ABCB1+五酯软胶囊+康唑类+钙通道阻滞剂+MPA类药物+糖皮质激素日剂量+中性粒细胞百分数+尿酸+淋巴细胞百分数+红细胞压积+肌酐+谷草转氨酶+高血压+生理病理状况))
summary(pool(modelFit1))
completedData <- complete(tempData,5)
completedData
write.csv(completedData, file="r'../data/Vanc(fill).xlsx'")

