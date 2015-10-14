library(ggplot2)
library(plyr)
library(reshape2)
## read data as a list 
library(readxl)
data1<-read_excel("Refined Version.xlsx",sheet = 7)
data<-list()
Y<-c("09","10","11","12","13","14")
t<-1
for(i in 1:5)
{
  data[[t]]<-read_excel("Refined Version.xlsx",sheet = i+1)
  t=t+1
}
data[[6]]<-read_excel("Record 2014.xlsx",sheet = 1)
## create null observation value
Moneybyyear<-rep(0,6)
Maxbyyear<-rep(0,6)
Minbyyear<-rep(0,6)
meanbyyear<-rep(0,6)
medianbyyear<-rep(0,6)

## data cleanning
## change to vector
dim(data[[1]])
length(data[[1]][,1])##row
length(data[[1]][1,])##cols
for(i in 1:6)
{
  for(j in 1:length(data[[i]][1,])) 
    data[[i]][,j]<-as.vector(data[[i]][,j])
}

##calculate the simple Descriptive statistics
for(k in 1:6)
{
  Moneybyyear[k]<-sum(data[[k]][,6],na.rm = TRUE)
  Maxbyyear[k]<-max(data[[k]][,6],na.rm = TRUE)
  Minbyyear[k]<-min(data[[k]][,6],na.rm = TRUE)
  meanbyyear[k]<-mean(data[[k]][,6],na.rm = TRUE)
  medianbyyear[k]<-median(data[[k]][,6],na.rm = TRUE)
}
y<-c(2009,2010,2011,2012,2013,2014)
Total<-data.frame(y,Moneybyyear,Maxbyyear,Minbyyear,meanbyyear,medianbyyear)

## make some simple plot
ggplot(Total,aes(x=y))+xlab("year")+geom_histogram(aes(y=Moneybyyear),stat="identity",binwidth=0.5,colour="blue",fill="white")
ggplot(Total,aes(x=y))+xlab("year")+ylab("change")+geom_line(aes(y=Minbyyear),colour="blue")+geom_line(aes(y=Maxbyyear),colour="red")+geom_line(aes(y=meanbyyear),colour="black")+geom_line(aes(y=medianbyyear),colour="green")

## combind ratio

#test
## create a new dataframe for total&extra income&gift..
id1<-rep("T",6)
id2<-rep("E",6)
id3<-rep("G",6)
df<-data.frame(year=c(y,y,y),value=c(medianbyyear,Minbyyear,meanbyyear),id=c(id1,id2,id3))
df
## plot to see the change of total &extra income&gift by year
qplot(year, value, data = df, geom = c("line", "point"), id = id,  colour = id)
