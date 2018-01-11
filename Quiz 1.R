todo <- readLines("C:\Users\Galina.Endarova\Downloads\SwiftKey_project\Data\Coursera-SwiftKey\final\en_US\en_US.twitter.txt")
todo <- readLines("Data/Coursera-SwiftKey/final/en_US/en_US.twitter.txt")
library(data.table)
library(dplyr)
dt_table <- data.table(todo)
dt_table[,Length := nchar(todo),][,Type := "twitter",]
setnames(dt_table, "todo", "text")

blogs <- readLines("Data/Coursera-SwiftKey/final/en_US/en_US.blogs.txt")
dt_blogs <- data.table(blogs)
dt_blogs[,Length:=nchar(blogs),][,Type := "blogs",]
setnames(dt_blogs, "blogs", "text")

news <- readLines("Data/Coursera-SwiftKey/final/en_US/en_US.news.txt")
dt_news <- data.table(news)
dt_news[,Length := nchar(news),][,Type := "news",]
setnames(dt_news, "news", "text")

todo <- rbind(dt_table, dt_blogs)
todo <- rbind(todo, dt_news)
View(todo[Length == max(Length),,])

# Divide love by hate
twitter_love <- grep("love", dt_table$text)
twitter_hate <- grep("hate", dt_table$text)
length(twitter_love)/ length(twitter_hate)

# What about biostats?
twitter_biostats <- grep("biostats", dt_table$text)
dt_table$text[twitter_biostats]

# Kicking a computer when it is down
twitter_biostats <- grep( "A computer once beat me at chess, but it was no match for me at kickboxing",dt_table$text)
