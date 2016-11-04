#import libraries to work with
library(plyr)
library(stringr)
library(e1071)
library(tm)
library(tm.plugin.mail)
library(party)
library(randomForest)
library(caret)

#load up word polarity list and format it
afinn_list <- read.delim(file='E:/Books/Msc CA/Sem 3/DM/sentiment_analysis-master/AFINN/AFINN-111.txt', header=FALSE, stringsAsFactors=FALSE)
names(afinn_list) <- c('word', 'score')
afinn_list$word <- tolower(afinn_list$word)

#categorize words as very negative to very positive
vNegTerms <- afinn_list$word[afinn_list$score==-5 | afinn_list$score==-4]
negTerms <- c(afinn_list$word[afinn_list$score==-3 | afinn_list$score==-2 | afinn_list$score==-1])
posTerms <- c(afinn_list$word[afinn_list$score==3 | afinn_list$score==2 | afinn_list$score==1])
vPosTerms <- c(afinn_list$word[afinn_list$score==5 | afinn_list$score==4])

#load up positive and negative sentences and format
posText <- read.csv("E:/Books/Msc CA/Sem 3/DM/posemails.csv")
posText <- as.character(posText$emails)
negText <- read.csv("E:/Books/Msc CA/Sem 3/DM/negemails.csv")
negText <- as.character(negText$emails)

#build tables of positive and negative sentences with scores
posResult <- as.data.frame(sentimentScore(posText, vNegTerms, negTerms, posTerms, vPosTerms))
negResult <- as.data.frame(sentimentScore(negText, vNegTerms, negTerms, posTerms, vPosTerms))
posResult <- cbind(posResult, 'positive')
colnames(posResult) <- c('sentence', 'vNeg', 'neg', 'pos', 'vPos', 'sentiment')
negResult <- cbind(negResult, 'negative')
colnames(negResult) <- c('sentence', 'vNeg', 'neg', 'pos', 'vPos', 'sentiment')

#combine the positive and negative tables
results <- rbind(posResult, negResult)

