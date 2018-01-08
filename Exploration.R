todo <- readLines("C:\Users\Galina.Endarova\Downloads\SwiftKey_project\Data\Coursera-SwiftKey\final\en_US\en_US.twitter.txt")
todo <- readLines("Data/Coursera-SwiftKey/final/en_US/en_US.twitter.txt")
library(data.table)
dt_table <- data.table(todo)
dt_table[,Length := nchar(todo),]

blogs <- readLines("Data/Coursera-SwiftKey/final/en_US/en_US.blogs.txt")
dt_blogs <- data.table(blogs)
dt_blogs[,Length:=nchar(blogs),]

news <- readLines("Data/Coursera-SwiftKey/final/en_US/en_US.news.txt")
dt_news <- data.table(news)
dt_news[,Length := nchar(news),]
