
# Q2: 
## Set working directory
setwd("D:/college/cs8086_data2decisions/Project")

## Read csv file
ghg1<-read.csv("air-n-ghg.csv",header=TRUE,stringsAsFactors=FALSE)

## Convert strings to factors
### converting Subject into factors
ghg1$SUBJECT <- factor(ghg1$SUBJECT)

### converting Region into factors
ghg1$Region <- factor(ghg1$Region)

### converting measure into factors
ghg1$MEASURE <- factor(ghg1$MEASURE)

## View a summary of data
summary(ghg1)

## creating a subset for CO2 
ghg.sub <- ghg1[ghg1$SUBJECT == 'CO2', ]

## creating a subset for CO2 measured in Millions of Tons
ghg.sub2 <- ghg.sub[ghg.sub$MEASURE == 'MLN_TONNE', ]

## creating a subset for CO2 for time 2000-2014
ghg.sub3 <- ghg.sub2[ghg.sub2$TIME>2000 & ghg.sub2$TIME<2015, ]

## Scatterplot between time and value
plot(ghg.sub3$Value~ghg.sub3$TIME)

## Scatterplot between region and value
This plot explains about the CO2 emission content based on region.
plot(ghg.sub3$Value~ghg.sub3$Region)

## creating a subset of CO2 values for year 2012.
ghg.sub2012<-ghg.sub3[ghg.sub3$TIME==2012,]

## Rank in descending order based on most Urbanized regions from 2012,top 15:
top52012 <- head(ghg.sub2012[order(ghg.sub2012$Urbanization., decreasing= T),], n = 15,)

## Create a barchart of Top Urbanizied Regions 2012:
barplot(top52012$Urabnization., main="Top Urbanizied Regions 2012", col = rainbow(15), space=0)
axis(1, at=.5:14.5, labels=top2014$region)


## Q3)
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
