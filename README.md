# Email-Sentiment-Analysis

This repository consists of analyzing the sentiment of an email, classifying it as negative or positive and predicting the happiness quotient of the week on the basis of the training data.
The email data set consists of emails extracted from my gmail account. You can also download your mailbox from https://takeout.google.com/settings/takeout here and convert the .mbox to .eml files
The presentation (http://prezi.com/s-ggob34somq/?utm_campaign=share&utm_medium=copy) explains the conceptual flow of the system. Three algorithms were tested; Linear Model,Naive Bayes and Random Forest.
The confidence can vary for each model with the data. The model best suited for my model was Random Forest; hence, I used it for further predictions.
The happiness quotient is calculated based on how many emails are negative or positive in the past week.
