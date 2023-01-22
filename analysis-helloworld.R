install.packages("dplyr")
install.packages("RMySQL")

library(RMySQL)
mysqlconnection = dbConnect(RMySQL::MySQL(),
                            dbname='pnad_covid',
                            host='localhost',
                            port=3306)
dbListTables(mysqlconnection)

rm(mergedDataSet)
mergedDataSet <- dplyr::bind_rows(
  read.csv("Downloads/PNAD_COVID_052020.csv"),
  read.csv("Downloads/PNAD_COVID_062020.csv"),
  read.csv("Downloads/PNAD_COVID_072020.csv"),
  read.csv("Downloads/PNAD_COVID_082020.csv"),
  read.csv("Downloads/PNAD_COVID_092020.csv"),
  read.csv("Downloads/PNAD_COVID_102020.csv"),
  read.csv("Downloads/PNAD_COVID_112020.csv"),
)

mergedDataSet[mergedDataSet == ''] <- NULL

mergedDataSet[mergedDataSet==""]<-0
mergedDataSet[is.empty(mergedDataSet)] <- NULL
mergedDataSet <- cbind(mergedDataSet, "index")

mergedDataSet$ID <- NULL

write.csv(mergedDataSet, "Downloads/merged_dataset.csv", row.names=FALSE)
mergedDataSet <- tibble::rowid_to_column(mergedDataSet, "id")


colnames(mergedDataSet)
View(mergedDataSet)
