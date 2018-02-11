library(data.table)
library(dplyr)
library(tokenizers)

options(scipen = 999)

# Tokenizers ---------------------------------------------------------------------------------------
todo <- readLines("Data/en_US/en_US.blogs.txt")

 # Wordcloud-----------------------------------
 
library(SnowballC)

library(tm)
library(wordcloud)

text <- readLines("Data/Test/1.txt")
text <- data.table(text)

textCorpus <- Corpus(VectorSource(text))
textCorpus <- tm_map(textCorpus, PlainTextDocument)
textCorpus <- tm_map(textCorpus, removePunctuation)
textCorpus <- tm_map(textCorpus, tolower)
textCorpus <- tm_map(textCorpus, removeWords, 
                     c("the", "this", "what", "it", "her", "his", stopwords('english'), "will", 
                       "can", "should", "time", "like", "one", "just", "get"))

stems <- tm_map(textCorpus, stemDocument)
wordcloud(textCorpus, max.words = 100, random.order = FALSE)
text_character <- as.character(textCorpus)
