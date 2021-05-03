###################################################################
#Zadania:
#1.Utworz funkcje: rankAccount <- function(dataFrame,colName,groupName,valueSort,num)
#ktora bedzie zwracala dla danej tabeli(dataFrame) n wierszy posiadajace najwieksze wartosci(sortowanie po kolumnie valueSort)
#dla wybranej grupy(konkretna wartosc komorki , np. "NAUCZYCIEL) z kolumny(colName) np. occupation-zawod.
library(dplyr)


data<-read.csv('konta.csv')
rankAccount <- function(dataFrame,colName,groupName,valueSort,num){
  df<-dataFrame%>%filter(.[[colName]]==groupName)
 df<-df[order(-df[[valueSort]]),]%>%head(num)
 View(df) 
}

rankAccount(data,'occupation','NAUCZYCIEL','saldo',10)



#2.Tak jak w 1 tylko z uzyciem datachunku.

rankAccountBigDatatoChunk<-function(filename, size, colName, groupName, valueSort,num, sep=',', header=TRUE){
  fileConnection<-file(description = filename, open = "r")
  data<-read.table(fileConnection, nrows = size, header = header,fill=TRUE,sep=sep)
  df<-data%>%filter(.[[colName]]==groupName)
  df<-df[order(-df[[valueSort]]),]%>%head(num)
  columnNames<-names(data)
  repeat{
    if(nrow(data)==0){break}
    data<-read.table(fileConnection,nrows = size,col.names = columnNames,fill=TRUE,sep=sep)
    df<-rbind(df, data%>%filter(.[[colName]]==groupName))
    df<-df[order(-df[[valueSort]]),]%>%head(num)
  }
  View(df)
}

rankAccountBigDatatoChunk("konta.csv",1000, "occupation", "NAUCZYCIEL","saldo",10)

#przyklad naglowka:
#rankAccountBigDatatoChunk(filename = "usersAccounts.csv", 1000,"occupation", "NAUCZYCIEL", "saldo",10)
#3.SPRAWIDZIC CZY DA SIE ZROBIC TO SAMO W zapytaniu SQL dla takich wartosci jak: tabelaZbazyDanych,occupation, nauczyciel, saldo
######################################################################