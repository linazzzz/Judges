#data14
#data0913
type <- c('EJS', 'GBF', 'EER', 'SPP', 'FID')
# add year on two datasets
for(ntyp in c(1:length(type))){
  data14[[ntyp]]$year <- with(data14[[ntyp]], 2014)
  data0913[[ntyp]]$year <- with(data0914[[ntyp]], as.numeric(strtrim(data0913[[ntyp]]$`SIGNED DATE`, 4))-1)
}

View(data0913[[ntyp]])

# data where items are split

data0914 <- list()
for(ntyp in c(1:length(type))){
  data14[[ntyp]]
  data0913[[ntyp]]
  data0914[[ntyp]] <- rbind(data14[[ntyp]], data0913[[ntyp]])
  write.csv(data0914[[ntyp]], file=paste("judge_",type[ntyp],".csv",sep=""))
}

# origin data of 6 years



View(data0914[[1]])


View(data14$EJS)
