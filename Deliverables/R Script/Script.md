
## Q4)
#### To read the csv file in to R
nox<-read_csv("E:/DBA4-A/air.csv")

#### Get the sunset of rows that are having the subject as NOX
nox.sub <- nox[nox$SUBJECT == 'NOX', ]

#### Get the sunset of rows that are having the subject as SOX
nox.sub1 <- nox[nox$SUBJECT == 'SOX', ]

#### Vertical merging of  rows that are having the subject as NOX and SOX
nox_sox<-rbind(nox.sub,nox.sub1)

#### Subset the values that are having the measure as 'THND_TONNE'
nox_sox_tonn <- nox_sox[nox_sox$MEASURE == 'THND_TONNE', ]
 

#### Remove the unnecessary columns
 nox_sox_req<-nox_sox_tonn[,c(1,3,6,7)]

#### Aggregate or Sum the values for each country over the years. This gives the sum of values of emmission of NOX or SOX gases for the country.
nox_sox_grouped<-aggregate(nox_sox_req$Value, by=list(Country=nox_sox_req$COUNTRY), FUN=sum)
 
#### This gives the country that has the maximum nox_Sox emmission 
nox_sox_grouped[which.max(nox_sox_grouped$x),]
