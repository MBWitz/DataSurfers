# Q1:
## Which countries and regions contribute the most CO2 emissions, both on a total volume basis and from a per capita perspective? Do the top offenders have similar patterns of increasing and decreasing emissions? 

### Read the csv file:
ghg <- read.csv("https://github.com/MBWitz/DataSurfers/blob/master/air_ghg_data.csv")

### View a summary of the data:
summary(ghg)  
_Summary shows that we do not have enough ghg data points to do meaningful analysis. We have far more data for CO2 emissions, so_
_we will do the same analysis we planned but on CO2 emissions, which are the leading contributor to green house gases._

### Create a subset of just CO2 values:
ghg.sub <- ghg[ghg$SUBJECT == 'CO2', ]

### Create a subset of CO2 set with CO2 that is measured in Millions of Tons:
ghg.sub2 <- ghg.sub[ghg.sub$MEASURE == 'MLN_TONNE', ]

### Create subsets of millions of tons CO2 emissions by year for 2014:
ghg.sub2014 <- ghg.sub2[ghg.sub2$TIME == 2014, ]

### Rank the top 20 CO2 producers from 2014, omit top two (World and OED), store in top2014 dataframe:
top2014 <- tail(head(ghg.sub2014[order(ghg.sub2014$Value, decreasing= T),], n = 22), n=20)

### Create a barchart of top 20 CO2 producing nation for 2014:
barplot(top2014$Value, main="Top CO2 Producing Countries 2014", col = rainbow(20), space=0)  
axis(1, at=.5:19.5, labels=top2014$COUNTRY)  

### Rank and plot top 20 CO2 producers for 2010:
ghg.sub2010<-ghg.sub2[ghg.sub2$TIME == 2010, ]  
top2010<-tail(head(ghg.sub2010[order(ghg.sub2010$Value, decreasing= T),], n = 22), n=20)  
barplot(top2010$Value, main="Top CO2 Producing Countries 2010", col = rainbow(20), space = 0)  
axis(1, at=.5:19.5, labels=top2010$COUNTRY)  

### Rank and plot top 20 CO2 producers for 2005:
ghg.sub2005<-ghg.sub2[ghg.sub2$TIME == 2005, ]  
top2005<-tail(head(ghg.sub2005[order(ghg.sub2005$Value, decreasing= T),], n = 22), n=20)  
barplot(top2005$Value, main="Top CO2 Producing Countries 2005", col = rainbow(20), space = 0)  
axis(1, at=.5:19.5, labels=top2005$COUNTRY)  

### Rank and plot top 20 CO2 producers for 2000:
ghg.sub2000<-ghg.sub2[ghg.sub2$TIME == 2000, ]  
top2000<-tail(head(ghg.sub2000[order(ghg.sub2000$Value, decreasing= T),], n = 22), n=20)  
barplot(top2000$Value, main="Top CO2 Producing Countries 2000", col = rainbow(20), space = 0)  
axis(1, at=.5:19.5, labels=top2000$COUNTRY)  

### Rank and plot top 20 CO2 producers for 1995:
ghg.sub1995<-ghg.sub2[ghg.sub2$TIME == 1995, ]  
top1995<-tail(head(ghg.sub1995[order(ghg.sub1995$Value, decreasing= T),], n = 22), n=20)  
barplot(top1995$Value, main="Top CO2 Producing Countries 1995", col = rainbow(20), space = 0)  
axis(1, at=.5:19.5, labels=top1995$COUNTRY)  

### Rank and plot top 20 CO2 producers for 1990:
ghg.sub1990<-ghg.sub2[ghg.sub2$TIME == 1990, ]  
top1990<-tail(head(ghg.sub1990[order(ghg.sub1990$Value, decreasing= T),], n = 22), n=20)  
barplot(top1990$Value, main="Top CO2 Producing Countries 1990", col = rainbow(20), space = 0)  
axis(1, at=.5:19.5, labels=top1990$COUNTRY)  

### Rank and plot top 20 CO2 producers for 1985:
ghg.sub1985<-ghg.sub2[ghg.sub2$TIME == 1985, ]  
top1985<-tail(head(ghg.sub1985[order(ghg.sub1985$Value, decreasing= T),], n = 22), n=20)  
barplot(top1985$Value, main="Top CO2 Producing Countries 1985", col = rainbow(20), space = 0)  
axis(1, at=.5:19.5, labels=top1985$COUNTRY)  

### Rank and plot top 20 CO2 producers for 1980:
ghg.sub1980<-ghg.sub2[ghg.sub2$TIME == 1980, ]  
top1980<-tail(head(ghg.sub1980[order(ghg.sub1980$Value, decreasing= T),], n = 22), n=20)  
barplot(top1980$Value, main="Top CO2 Producing Countries 1980", col = rainbow(20), space = 0)  
axis(1, at=.5:19.5, labels=top1980$COUNTRY)  

### Rank and plot top 20 CO2 producers for 1975:
ghg.sub1975<-ghg.sub2[ghg.sub2$TIME == 1975, ]  
top1975<-tail(head(ghg.sub1975[order(ghg.sub1975$Value, decreasing= T),], n = 22), n=20)  
barplot(top1975$Value, main="Top CO2 Producing Countries 1975", col = rainbow(20), space = 0)  
axis(1, at=.5:19.5, labels=top1975$COUNTRY)  

### Rank and plot top 20 CO2 producers for 1971:
ghg.sub1971<-ghg.sub2[ghg.sub2$TIME == 1971, ]  
top1971<-tail(head(ghg.sub1971[order(ghg.sub1971$Value, decreasing= T),], n = 22), n=20)  
barplot(top1971$Value, main="Top CO2 Producing Countries 1971", col = rainbow(20), space = 0)  
axis(1, at=.5:19.5, labels=top1971$COUNTRY)  

### Calculate Per Capita CO2 Emissions and include in ghg.sub2:
ghg.sub2$CO2percap <- with(ghg.sub2, (ghg.sub2$Value/ghg.sub2$Population)*1000000)

### Rank the top 50 CO2 Per Capita producers from 2014, store in top2014PC dataframe:
top2014PC <-head(ghg.sub2014[order(ghg.sub2014$CO2percap, decreasing= T),], n = 50)

_We observed that the top countries for per capita use were not the same as the top countries for volume of CO2 emissions._ 
_We had planned on focusing our analysis on the countries with the highest volumes but since many small countries with relatively_
_low volumes actually have high per capita consumption, we want to include their numbers in the analysis. We will therfore_
_do some analysis based on geographic region._

_We had to find a list of countries by region, consolidate the regions, then append that information to our data file._

### Upload new data file:
ghg <- read.csv("https://github.com/MBWitz/DataSurfers/blob/master/air_ghg_data_w_regions.csv")

### Aggregate 2014 CO2 Emissions and Population by Region:
Region2014 <- with(ghg.sub2014, (aggregate(list(Population=ghg.sub2014$Population,Value=ghg.sub2014$Value), 
    by=list(Region=ghg.sub2014$Region), FUN=sum)))

### Calculate 2014 CO2 Emissions Per Capita by Region:
Region2014$CO2percap <- with(Region2014, (Region2014$Value/Region2014$Population)*1000000)  
Region2014<-Region2014[order(Region2014$CO2percap, decreasing= T),]  

### Create subsets of millions of tons CO2 emissions for just the USA:
ghg.subUSA <-ghg.sub2[ghg.sub2$COUNTRY == 'USA', ]

### plot the USA CO2 emissions over time with year as labels on x-axis :
plot(ghg.subUSA$Value,  main="USA CO2 Production", type = "l",  xaxt = "n")
axis(1, at=1:55, labels=ghg.subUSA$TIME)

### Create a subset for China and plot their emissions over time:
ghg.subCHN <-ghg.sub2[ghg.sub2$COUNTRY == 'CHN', ]  
plot(ghg.subCHN$Value,  main="China CO2 Production", type = "l",  xaxt = "n")  
axis(1, at=1:44, labels=ghg.subCHN$TIME)  
_Note that Chinese CO2 production drastically increased in the early 2000's_

### Create a subset for India and plot their emissions over time:
ghg.subIND <-ghg.sub2[ghg.sub2$COUNTRY == 'IND', ]  
plot(ghg.subIND$Value,  main="India CO2 Production", type = "l",  xaxt = "n")  
axis(1, at=1:44, labels=ghg.subIND$TIME)  

### Create a subset for Russia and plot their emissions over time:
ghg.subRUS <-ghg.sub2[ghg.sub2$COUNTRY == 'RUS', ]  
plot(ghg.subRUS$Value,  main="Russia CO2 Production", type = "l",  xaxt = "n")  
axis(1, at=1:25, labels=ghg.subRUS$TIME)  

### Create a subset for Germany and plot their emissions over time:
ghg.subDEU <-ghg.sub2[ghg.sub2$COUNTRY == 'DEU', ]  
plot(ghg.subDEU$Value,  main="Germany CO2 Production", type = "l",  xaxt = "n")  
axis(1, at=1:55, labels=ghg.subDEU$TIME)  

### Create a subset for Japan and plot their emissions over time:
ghg.subJPN <-ghg.sub2[ghg.sub2$COUNTRY == 'JPN', ]  
plot(ghg.subJPN$Value,  main="Japan CO2 Production", type = "l",  xaxt = "n")  
axis(1, at=1:55, labels=ghg.subJPN$TIME)  

### Create a subset for United Kingdom and plot their emissions over time:
ghg.subGBR <-ghg.sub2[ghg.sub2$COUNTRY == 'GBR', ]  
plot(ghg.subGBR$Value,  main="United Kingdom CO2 Production", type = "l",  xaxt = "n")  
axis(1, at=1:55, labels=ghg.subGBR$TIME)  

#### Attempting to graph all top 7 countries on the same graph...not yet successful
top7list <- c("USA", "CHN", "DEU","RUS", "IND", "GBR","JPN")  
top7data <- ghg.sub2$COUNTRY[top7list]  
#### Another attempt...still unsuccessful
plot(ghg.subUSA$Value~ghg.subUSA$TIME,type="l",col = cl[3], xlab = "Time", ylab = "CO2", main = "CO2 Emissions")  
lines(ghg.subDEU$TIME,ghg.subDEU$Value,col = cl[1],type = 'l')  
lines(ghg.subGBR$TIME,ghg.subGBR$Value,col = cl[2],type = 'l')  

### World subset and graph:
ghg.subWLD <- ghg.sub2[ghg.sub2$COUNTRY == 'WLD',]  
plot(ghg.subWLD$Value, main="World CO2 Production", type = "l", xaxt = "n")  
axis(1, at=1:44, labels=ghg.subWLD$TIME)   

### OED subset and graph:
ghg.subOED <- ghg.sub2[ghg.sub2$COUNTRY == 'OED',]  
plot(ghg.subOED$Value,  main="OECD Member CO2 Production", type = "l", xaxt = "n")  
axis(1, at=1:44, labels=ghg.subOED$TIME)  

# Q2: 
## Are urbanization rates correlated to carbon dioxide emissions?

### Read csv file
ghg <- read.csv("https://github.com/MBWitz/DataSurfers/blob/master/air_ghg_data.csv")

### converting Subject into factors
ghg1$SUBJECT <- factor(ghg1$SUBJECT)

### converting Region into factors
ghg1$Region <- factor(ghg1$Region)

### converting measure into factors
ghg1$MEASURE <- factor(ghg1$MEASURE)

### View a summary of data
summary(ghg1)

### creating a subset for CO2 
ghg.sub <- ghg1[ghg1$SUBJECT == 'CO2', ]

### creating a subset for CO2 measured in Millions of Tons
ghg.sub2 <- ghg.sub[ghg.sub$MEASURE == 'MLN_TONNE', ]

### creating a subset for CO2 for time 2000-2014
ghg.sub3 <- ghg.sub2[ghg.sub2$TIME>2000 & ghg.sub2$TIME<2015, ]

### Scatterplot between time and value
plot(ghg.sub3$Value~ghg.sub3$TIME)

### Scatterplot between region and value
This plot explains about the CO2 emission content based on region.
plot(ghg.sub3$Value~ghg.sub3$Region)

### creating a subset of CO2 values for year 2012.
ghg.sub2012<-ghg.sub3[ghg.sub3$TIME==2012,]

### Rank in descending order based on most Urbanized regions from 2012,top 15:
top52012 <- head(ghg.sub2012[order(ghg.sub2012$Urbanization., decreasing= T),], n = 15,)

### Create a barchart of Top Urbanizied Regions 2012:
barplot(top52012$Urabnization., main="Top Urbanizied Regions 2012", col = rainbow(15), space=0)
axis(1, at=.5:14.5, labels=top2014$region)


# Q3:
## Are Nitrogen Oxides (NOX) and Sulphur Oxides (SOX) emissions highest from OECD (Organization for Economic Cooperation and Development) member countries? Are these emissions correlated to urbanization?

### To read the csv file in to R
nox <- read.csv("https://github.com/MBWitz/DataSurfers/blob/master/air_ghg_data.csv")

### Get the sunset of rows that are having the subject as NOX
nox.sub <- nox[nox$SUBJECT == 'NOX', ]

### Get the sunset of rows that are having the subject as SOX
nox.sub1 <- nox[nox$SUBJECT == 'SOX', ]

### Vertical merging of  rows that are having the subject as NOX and SOX
nox_sox<-rbind(nox.sub,nox.sub1)

### Subset the values that are having the measure as 'THND_TONNE'
nox_sox_tonn <- nox_sox[nox_sox$MEASURE == 'THND_TONNE', ]
 

### Remove the unnecessary columns
 nox_sox_req<-nox_sox_tonn[,c(1,3,6,7)]

### Aggregate or Sum the values for each country over the years. This gives the sum of values of emmission of NOX or SOX gases for the country.
nox_sox_grouped<-aggregate(nox_sox_req$Value, by=list(Country=nox_sox_req$COUNTRY), FUN=sum)
 
### This gives the country that has the maximum nox_Sox emmission 
nox_sox_grouped[which.max(nox_sox_grouped$x),]
