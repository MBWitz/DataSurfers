
#To read the csv file in to R
nox<-read_csv("E:/MISF/air_ghg_data_w_regions_new1130.csv")

#Get the sunset of rows that are having the subject as NOX
nox.sub <- nox[nox$SUBJECT == 'NOX', ]

#Get the sunset of rows that are having the subject as SOX
nox.sub1 <- nox[nox$SUBJECT == 'SOX', ]

#Vertical merging of  rows that are having the subject as NOX and SOX
nox_sox<-rbind(nox.sub,nox.sub1)

#Subset the values that are having the measure as 'THND_TONNE'
nox_sox_tonn <- nox_sox[nox_sox$MEASURE == 'THND_TONNE', ]


#Remove the unnecessary columns
nox_sox_req<-nox_sox_tonn[,c(1,3,6,7,10,11,13,14)]

#Calcuate the urbanized population from percentage and total population
nox_sox_req$urbanized<-with(nox_sox_req, (nox_sox_req$Urbanization*nox_sox_req$Population)/100)


#Aggregate or Sum the values for all countries over the years. This gives the sum of values of emmission of NOX or SOX gases for the country.
nox_sox_grouped_value<-aggregate(nox_sox_req$Value, by=list(TIME=nox_sox_req$TIME,OECD_Flag=nox_sox_req$OECD_Flag), FUN=sum)


#Aggregate or Sum the urbanzed poplation for all  countries over the years. This gives the percentages of urbanized people in all countries in the year.
nox_sox_grouped_urban<-aggregate(((nox_sox_req$urbanized/nox_sox_req$YearPopulation)*100), by=list(TIME=nox_sox_req$TIME,OECD_Flag=nox_sox_req$OECD_Flag), FUN=sum)

#Urban population data is added as a column to the nox_sox_grouped_urban varibale above
nox_sox_grouped_value$urban<-with(nox_sox_grouped_urban,x[match(nox_sox_grouped_value$TIME,TIME)])

#Seperating data for non OECD countries
nox_sox_non_OECD = subset(nox_sox_grouped_value,OECD_Flag == "0")

#Seperating data for OECD countries
nox_sox_OECD = subset(nox_sox_grouped_value,OECD_Flag == "1")


#This gives the plot that show relation between OECD countries and urbanization rate

ggplot(data=(nox_sox_OECD))+
  geom_line(color="black", mapping= aes(x= TIME , y= x), stat="identity")+
  ylab("Millions of Tons")+
  geom_line(color="blue", mapping= aes(x= TIME , y= urban*(109052/6)), stat="identity")+
  theme(axis.title.y.right = element_text(color = "blue"),axis.text.y.right = element_text(color = "blue"))+
  scale_y_continuous(name = expression("Millions of Tons"), sec.axis = sec_axis(~ . * 6/109052 ,name = "Urbanization %"),limits = c(37774,109052))


#This gives the plot that show relation between non-OECD countries and urbanization rate

ggplot(data=(nox_sox_non_OECD))+
  geom_line(color="black", mapping= aes(x= TIME , y= x), stat="identity")+
  ylab("Millions of Tons")+
  geom_line(color="blue", mapping= aes(x= TIME , y= urban*(109052/6)), stat="identity")+
  theme(axis.title.y.right = element_text(color = "blue"),axis.text.y.right = element_text(color = "blue"))+
  scale_y_continuous(name = expression("Millions of Tons"), sec.axis = sec_axis(~ . * 6/109052 ,name = "Urbanization %"),limits = c(37774,109052))


