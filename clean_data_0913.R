


# for data22-data27

# separate different types in one year, for all judges

data2x <- data27

data0913 <- list()
data0913[['EJS']] <- c(data2x[,1:5], data2x[,6:11])
data0913[['GBF']] <- c(data2x[,1:5], data2x[,12:14])
data0913[['EER']] <- c(data2x[,1:5], data2x[,15:17])
data0913[['SPP']] <- c(data2x[,1:5], data2x[,18:20])
data0913[['FID']] <- c(data2x[,1:5], data2x[,21:23])

# for each type, we build a data frame
type <- c('EJS', 'GBF', 'EER', 'SPP', 'FID') # types' name
cc <- c(7,6,6,6,6) # for each type, set a column number used to count the records. 
cd <- c(11,6,6,6,6)
for(ntyp in c(1:length(type))){
  
  # reorganize the data09[[ntyp]], the ntypth type
  # and put them in a list and split different items apart.
  tmp <- list()
  for(i in c(1:length(data09[[ntyp]]))){
    tmp[[i]] <- strsplit(as.character(data09[[ntyp]][[i]]), split="\r\n") # split the ith column of the ntypth type
  }
  #print(length(tmp))
  #
  # every record has been separated, put them in a data frame.
  # first get the number of record
  len <- 0
  for(i in c(1:length(tmp[[1]]))){
    len <- len + length(tmp[[cc[ntyp]]][[i]])
  }
  
  # build a new data.frame to save records separately, dim: num of records, num of columns
  newdf <- data.frame(matrix(NA,len,length(tmp)))
  
  colnames(newdf) <- names(data09[[ntyp]])
  
  # now lets put data into the new data frame
  rcount=1
  for(i in c(1:length(tmp[[1]]))){ # i represents judges
    for(k in c(1:length(tmp[[cd[ntyp]]][[i]]))){ # k represents number of records of the ith judges # cd !!!!!
      for(j in c(1:length(tmp))){ # j represents column
        if(j < cc[ntyp]){ # j <= 6 means the column records basic information and total incom of a judge 
          newdf[rcount,j] <- tmp[[j]][[i]][1] # ignore the \r\n in top 5 column, AKA judges' base information !!!
        } else {
          print(tmp[[j]][[i]][k])
          newdf[rcount,j] <- tmp[[j]][[i]][k]
        }
        
      }
      #print(len)
      #print(tmp[[i]])
      rcount <- rcount + 1
    }
  }
  
  data0913[[ntyp]] <- newdf
  print(type[ntyp]);print("Done")
  
}
