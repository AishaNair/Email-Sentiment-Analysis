hq=function(emailist){
  res=names(which.max(table(emailist)))
  ifelse(res=="positive","Congratulations!!!You are going to have a happy week",
         "So Sorry!!!You are going to have a bad week")
}