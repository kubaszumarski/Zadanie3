library(DBI)
library(RSQLite)
library(RMySQL)



readToBase<- function (filepath, dbpath, tablename, size, header = TRUE,  sep=",", deleteTable=TRUE){
  ap=!deleteTable
  ov=deleteTable
  
  fileConnection<-file(description = filepath,open = "r")
  dbConn<-dbConnect(SQLite(),dbpath)
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

dbp="bazaSQLlight"
con=dbConnect(SQLite(),dbp)
tablename="dane_klientow"
dbGetQuery(con, paste0("SELECT COUNT(*) FROM ",tablename,";" ) )



