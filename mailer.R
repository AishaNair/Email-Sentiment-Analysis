mail <- paste0(getwd(), "/Mail")
convert_mbox_eml("./Mail/Inbox.mbox", mail)
vc <- VCorpus(DirSource(mail), readerControl = list(reader = readMail))


-------------------------------------------------------------------------------------------
#Linear Model

ind=sample(2,nrow(results),replace=T,prob=c(0.7,0.3))
trainData=results[ind==1,]
testData=results[ind==2,]

#train data
res_tree=ctree(myFormula,data=trainData)
cf=table(predict(res_tree),trainData$sentiment,dnn=list('predicted','actual'))
binom.test(cf[1,1] + cf[2,2], nrow(trainData), 0.5)
plot(res_tree)

#results
Exact binomial test

data:  cf[1, 1] + cf[2, 2] and nrow(trainData)
number of successes = 4605, number of trials = 7487, p-value < 2.2e-16
alternative hypothesis: true probability of success is not equal to 0.5
95 percent confidence interval:
  0.6039346 0.6261080
sample estimates:
  probability of success 
0.6150661 

#test data
res_tree=ctree(myFormula,data=testData)
cf=table(predict(res_tree),testData$sentiment,dnn=list('predicted','actual'))
binom.test(cf[1,1] + cf[2,2], nrow(testData), 0.5)
plot(res_tree)

#results
Exact binomial test
data:  cf[1, 1] + cf[2, 2] and nrow(testData)
number of successes = 2017, number of trials = 3176, p-value < 2.2e-16
alternative hypothesis: true probability of success is not equal to 0.5
95 percent confidence interval:
  0.6180573 0.6518447
sample estimates:
  probability of success 
0.6350756 

-------------------------------------------------------------------------------------------
#Naive Bayes train data
x = trainData[,2:5]
y = trainData$sentiment
model = train(x,y,'nb',trControl=trainControl(method='cv',number=10))
#nb=naiveBayes(trainData$sentiment~.,data=trainData)
cfnb=table(predict(model$finalModel,x)$class,y)
binom.test(cfnb[1,1] + cfnb[2,2], nrow(trainData), p=0.5)
mN <- NaiveBayes(trainData$sentiment ~ ., data = trainData[,-c(1,6)])
plot(mN)

#results
Exact binomial test

data:  cfnb[1, 1] + cfnb[2, 2] and nrow(trainData)
number of successes = 3758, number of trials = 7487, p-value = 0.7462
alternative hypothesis: true probability of success is not equal to 0.5
95 percent confidence interval:
  0.4905454 0.5133265
sample estimates:
  probability of success 
0.5019367 

#Naive Bayes test data
x = testData[,2:5]
y = testData$sentiment
model = train(x,y,'nb',trControl=trainControl(method='cv',number=10))
#nb=naiveBayes(testData$sentiment~.,data=testData)
cfnb=table(predict(model$finalModel,x)$class,y)
binom.test(cfnb[1,1] + cfnb[2,2], nrow(testData), p=0.5)
mN <- NaiveBayes(testData$sentiment ~ ., data = testData[,-c(1,6)])
plot(mN)

#result
Exact binomial test

data:  cfnb[1, 1] + cfnb[2, 2] and nrow(testData)
number of successes = 1603, number of trials = 3176, p-value = 0.6068
alternative hypothesis: true probability of success is not equal to 0.5
95 percent confidence interval:
  0.4871796 0.5222576
sample estimates:
  probability of success 
0.5047229 
--------------------------------------------------------------------------------------------  
#random forest classifier
rf=randomForest(results[,2:5], results[,6])
rfconf <- table(predict(rf, results), results[,6], dnn=list('predicted','actual'))
binom.test(rfconf[1,1] + rfconf[2,2], nrow(results), p=0.5)

#results
Exact binomial test

data:  rfconf[1, 1] + rfconf[2, 2] and nrow(results)
number of successes = 6690, number of trials = 10663, p-value < 2.2e-16
alternative hypothesis: true probability of success is not equal to 0.5
95 percent confidence interval:
  0.6181455 0.6365912
sample estimates:
  probability of success 
0.6274032 
---------------------------------------------------------------------
#random forest train data
rftd=randomForest(sentiment~.,data=trainData[-1],ntree=100,proximity=TRUE)
cfrf=table(rftd$predicted,trainData$sentiment,dnn = list("predicted","actual"))
binom.test(cfrf[1,1] + cfrf[2,2], nrow(trainData), p=0.5)
plot(rftd)
legend("top", colnames(rftd$err.rate),col=1:4,cex=0.8,fill=1:4)
#result
Exact binomial test

data:  cfrf[1, 1] + cfrf[2, 2] and nrow(trainData)
number of successes = 4599, number of trials = 7487, p-value < 2.2e-16
alternative hypothesis: true probability of success is not equal to 0.5
95 percent confidence interval:
  0.6031292 0.6253112
sample estimates:
  probability of success 
0.6142647 

#random forest test data
rftd=randomForest(sentiment~.,data=testData[-1],ntree=100,proximity=TRUE)
cfrf=table(rftd$predicted,testData$sentiment,dnn = list("predicted","actual"))
binom.test(cfrf[1,1] + cfrf[2,2], nrow(testData), p=0.5)
plot(rftd)
legend("top", colnames(rftd$err.rate),col=1:4,cex=0.8,fill=1:4)
#result
Exact binomial test

data:  cfrf[1, 1] + cfrf[2, 2] and nrow(testData)
number of successes = 2022, number of trials = 3176, p-value < 2.2e-16
alternative hypothesis: true probability of success is not equal to 0.5
95 percent confidence interval:
  0.6196456 0.6534022
sample estimates:
  probability of success 
0.6366499 