#data14
#data0913

type <- c('EJS', 'GBF', 'EER', 'SPP', 'FID')

for(ntyp in c(1:length(type))){
  data14[[ntyp]]
  data0913[[ntyp]]
  thedata <- rbind(data14[[ntyp]], data0913[[ntyp]])
  write.csv(thedata, file=paste("judge_",type[ntyp],".csv",sep=""))
}

rbind(data14[[ntyp]], data0913[[ntyp]])
length(data14[[ntyp]][,1])
length(data0913[[ntyp]][,1])
View(data14$EJS)
