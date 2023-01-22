install.packages("dplyr")
install.packages("RMySQL")

library(RMySQL)
mysqlconnection = dbConnect(RMySQL::MySQL(),
                            dbname='pnad_covid',
                            host='localhost',
                            port=3306)
dbListTables(mysqlconnection)