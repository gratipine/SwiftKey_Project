library(data.table)
library(dplyr)
library(tokenizers)

# Tokenizers ---------------------------------------------------------------------------------------
todo <- readLines("Data/Coursera-SwiftKey/final/en_US/en_US.blogs.txt")

dt_table <- data.table(todo)

strsplit(as.character(head(todo)), " ")
mine <- paste(todo, sep = "", collapse = "")
words <- unlist(tokenize_words(mine))
length(words)
tab <- table(words)
tab <- data_frame(word = names(tab), count = as.numeric(tab))
tab <- data.table(tab)

tab[, Frequency := count / sum(count),]
 workable <- tab %>% 
   filter(Frequency > 0.001)

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
