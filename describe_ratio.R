eer <- read.csv("Judges/judge_EER.csv")
ejs <- read.csv("Judges/judge_EJS.csv")
fid <- read.csv("Judges/judge_FID.csv")
gbf <- read.csv("Judges/judge_GBF.csv")
spp <- read.csv("Judges/judge_SPP.csv")
View(eer)
# get name, court, year
court_ratio_raw <- rbind(eer[c(2,3,dim(eer)[2])],
                         ejs[c(2,3,dim(ejs)[2])],
                         fid[c(2,3,dim(fid)[2])],
                         gbf[c(2,3,dim(gbf)[2])],
                         spp[c(2,3,dim(spp)[2])])

# get rid of duplicated rows
court_ratio <- court_ratio_raw[which(!duplicated(court_ratio_raw)),]

# reorganization
court_ratio$count <- with(court_ratio, 1)
court_ratio <- subset(court_ratio, is.na(court_ratio$NAME)==F)
View(court_ratio)

# get court ratio chart
library(ggplot2)
ggplot(data=court_ratio, aes(x=COURT, y=count)) + 
  geom_bar(aes(fill=factor(COURT)),stat="identity") +
  facet_wrap(~year) +
  coord_polar((theta="y"))


# get name, position, year
position_ratio_raw <- rbind(eer[c(2,4,dim(eer)[2])],
                            ejs[c(2,4,dim(ejs)[2])],
                            fid[c(2,4,dim(fid)[2])],
                            gbf[c(2,4,dim(gbf)[2])],
                            spp[c(2,4,dim(spp)[2])])

# clean up the judges' position
table(position_ratio_raw$JUDICIAL.POSITION)
position_ratio_raw$JUDICIAL.POSITION <- as.vector(position_ratio_raw$JUDICIAL.POSITION)
position_ratio_raw$JUDICIAL.POSITION[position_ratio_raw$JUDICIAL.POSITION=='ASSOC. JUSTICE'] <- 'ASSOCIATE JUSTICE'
position_ratio_raw$JUDICIAL.POSITION[position_ratio_raw$JUDICIAL.POSITION=='ASSOC. JUSTICE, RECALL'] <- 'ASSOC. JUSTICE (RECALL)'


 # get rid of duplicated rows
position_ratio <- position_ratio_raw[which(!duplicated(position_ratio_raw)),]

# reorganization
position_ratio$count <- with(position_ratio, 1)
position_ratio <- subset(position_ratio, (is.na(position_ratio$JUDICIAL.POSITION)==F))
View(position_ratio)

# get position ratio chart
library(ggplot2)
ggplot(data=position_ratio, aes(x=JUDICIAL.POSITION, y=count)) + 
  geom_bar(aes(fill=factor(JUDICIAL.POSITION)),stat="identity") + 
  facet_wrap(~year) + 
  coord_polar((theta="y"))

