library(DBI)
library(RMySQL)
library(rstudioapi)
library(tidyverse)

connectMe<-function(typ=MySQL(), dbname="big_data", host="localhost", user="root"){
  con<-dbConnect(typ,
                 dbname=dbname,
                 host=host,
                 user=user,
                 password=askForPassword("database password"))
}


con<-connectMe()






readToBase<- function (connection,filepath, tablename, size, header = TRUE,  sep=",", deleteTable=TRUE){
  ap=!deleteTable
  ov=deleteTable
  
  fileConnection<-file(description = filepath,open = "r")
  dbConn<-dbConnect(connection)
  data<-read.table(fileConnection,nrows = size,header = header,fill=TRUE,sep=sep)
  columnNames<-names(data)
  dbWriteTable(conn = dbConn, name=tablename, data, append=ap, overwrite=ov)
  
  repeat{
    if(nrow(data)==0){
      close(fileConnection)
      dbDisconnect(dbConn)
      break
    }
    
    
    data<-read.table(fileConnection,nrows = size,col.names = columnNames,fill=TRUE,sep=sep)
    dbWriteTable(conn = dbConn, name=tablename, data, append=TRUE, overwrite=FALSE)
    
  }
}

con<-connectMe()
readToBase(con,'pjatk_su.csv','suicides',1000)



con<-connectMe()
dbGetQuery(con, paste0("SELECT COUNT(*) FROM suicides;" ) )



