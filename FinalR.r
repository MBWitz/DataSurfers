
#Get the subset of rows that are having the subject as NOX
nox.sub <- ghg[ghg$SUBJECT == 'NOX', ]

#Get the subset of rows that are having the subject as SOX
nox.sub1 <- ghg[ghg$SUBJECT == 'SOX', ]

#Vertical merging of  rows that are having the subject as NOX and SOX
nox_sox<-rbind(nox.sub,nox.sub1)

#Subset the values that are having the measure as 'THND_TONNE'
nox_sox_tonn <- nox_sox[nox_sox$MEASURE == 'THND_TONNE', ]


#Remove the unnecessary columns
nox_sox_req<-nox_sox_tonn[,c(1,3,6,7,10,11,13,14)]

#Calcuate the urbanized population from percentage and total population
nox_sox_req$urbanized<-with(nox_sox_req, (nox_sox_req$Urbanization*nox_sox_req$Population)/100)


#Aggregate or Sum the values for all countries over the years. This gives the sum of values of emmission of NOX or SOX gases for the country.
nox_sox_grouped_value<-aggregate(c(nox_sox_req$Value ), by=list(TIME=nox_sox_req$TIME,OECD_Flag=nox_sox_req$OECD_Flag), FUN=sum)

#Column name for x is chnaged to value
colnames(nox_sox_grouped_value)[3] <- "VALUE";

#Aggregate or Sum the urbanzed poplation for all  countries over the years. This gives the percentages of urbanized people in all countries in the year.
nox_sox_grouped_urban<-aggregate(((nox_sox_req$urbanized/nox_sox_req$YearPopulation)*100), by=list(TIME=nox_sox_req$TIME,OECD_Flag=nox_sox_req$OECD_Flag), FUN=sum)

#Column name for x is chnaged to URBAN
colnames(nox_sox_grouped_urban)[3] <- "URBAN";


# Dataframes nox_sox_grouped_urban and nox_sox_grouped_value are merged into m4
m4<-merge(nox_sox_grouped_value,nox_sox_grouped_urban)


#Seperating data for non OECD countries
nox_sox_non_OECD = subset(m4,OECD_Flag == "0")

#Seperating data for OECD countries
nox_sox_OECD = subset(m4,OECD_Flag == "1")

# Aggregate or Sum the values for each country over the years. This gives the sum of values of emmission of NOX or SOX gases for the country.
nox_sox_grouped<-aggregate(nox_sox_req$Value, by=list(TIME=nox_sox_req$TIME,OECD_Flag=nox_sox_req$OECD_Flag), FUN=sum)


# This shows the plot that show variation between OECD and NON-OECD Countries

ggplot(data = nox_sox_grouped, aes(x = TIME, y = x, group = factor(OECD_Flag))) +
  xlab("Year") + ylab("Millions of Tons") +
  geom_line(aes(color = factor(OECD_Flag)))+
  scale_color_discrete(name = "OECD Indicator", labels = c("NON-OECD", "OECD"))

#This gives the plot that show relation between OECD countries and urbanization rate

ggplot(data=(nox_sox_OECD))+
  geom_line(color="black", mapping= aes(x= TIME , y= VALUE), stat="identity")+
  ylab("Millions of Tons")+
  geom_line(color="blue", mapping= aes(x= TIME , y= URBAN*(109052/13)), stat="identity")+
  theme(axis.title.y.right = element_text(color = "blue"),axis.text.y.right = element_text(color = "blue"))+
  scale_y_continuous(name = expression("Millions of Tons"), sec.axis = sec_axis(~ . * 16/109052 ,name = "Urbanization %"),limits = c(37774,109052))


#This gives the plot that show relation between non-OECD countries and urbanization rate

ggplot(data=(nox_sox_non_OECD))+
  geom_line(color="black", mapping= aes(x= TIME , y= VALUE), stat="identity")+
  ylab("Millions of Tons")+
  geom_line(color="blue", mapping= aes(x= TIME , y= URBAN*(109052/13)), stat="identity")+
  theme(axis.title.y.right = element_text(color = "blue"),axis.text.y.right = element_text(color = "blue"))+
  scale_y_continuous(name = expression("Millions of Tons"), sec.axis = sec_axis(~ . * 16/109052 ,name = "Urbanization %"),limits = c(37774,109052))


