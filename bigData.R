
konta<-read.csv("konta.csv")
View(konta)

srednia<- function(filepath,columnname,header= TRUE, size, sep=","){
  fileConnection<-file(description = filepath, open = "r")
  suma<-0
  counter<-0
  data<-read.table(fileConnection,nrows = size,header = header,fill=TRUE,sep=sep)
  columnNames<-names(data)
  repeat{
    if(nrow(data)==0){
      break
    }
    data<-na.omit(data)
    suma<-suma+sum(data[[columnname]])
    counter <- counter +  nrow(data)
    data<-read.table(fileConnection,nrows = size,col.names = columnNames,fill=TRUE,sep=sep)
  }
  suma / counter
}


srednia("konta.csv","saldo",size=1000)


mean(konta[['saldo']], na.rm = TRUE) ## omijanie pustych












lengthOfFile<- function(filepath,systemLinuxUnix=FALSE){
  #if(.Platform$OS.type == "unix" )
  if ( systemLinuxUnix){
    l <- try(system(paste("wc -l",filepath),intern=TRUE))
    l<-strsplit(l,split=" ")
    l<-as.numeric(l[[1]])
    l
  }
  else{
    l<-length(count.fields(filepath))
    l
  }
}

lengthOfFile("konta.csv",TRUE)

start_time <- Sys.time()
lengthOfFile("konta.csv",TRUE)
end_time <- Sys.time()
wyn1<-end_time - start_time



start_time <- Sys.time()
lengthOfFile("konta.csv",FALSE)
end_time <- Sys.time()
wyn2<-end_time - start_time
print(wyn1)
print(wyn2)