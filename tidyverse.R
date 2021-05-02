library(tidyverse)

connectMe<-function(typ=MySQL(), dbname="big_data", host="localhost", user="root"){
  con<-dbConnect(typ,
                 dbname=dbname,
                 host=host,
                 user=user,
                 password=askForPassword("database password"))
}


con<-connectMe()

suicidesFromFile<-read.csv("pjatk_su.csv")
nrow(suicidesFromFile)
View(suicidesFromFile)
object.size(suicidesFromFile)
dbGetInfo(con)
dbListTables(con)
dbListFields(con,"suicides")
suicideTable<-tbl(con,"suicides")
object.size(suicideTable)
suicideTable%>%select(country,year,age,generation)
tabelaR<-suicideTable%>%select(everything())%>%collect()
View(tabelaR)


ggplot(data=suicideTable)+geom_bar(aes(x=country))+coord_flip()



ggplot(data=tabelaR)+geom_bar(aes(x=country))+coord_flip()

dataPoland<-suicideTable%>%filter(country =='Poland')%>%collect()
ggplot(data=dataPoland)+geom_bar(aes(x=year))
ggplot(data=dataPoland)+geom_point(aes(x=year,y=suicides_no))



