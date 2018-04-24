# Model

# The data comes from :
# https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip

# What the model is:
# compiled n-grams from the three data sources we received. 
# each one of them will live in its own separate .RData file
# The way it models is if given one word / two words / three words it predicts the next one.

# It will be tested on Trumps speeches (out of curiousity, not political beliefs).
# Libraries
suppressWarnings(suppressPackageStartupMessages(library(data.table)))
suppressWarnings(suppressPackageStartupMessages(library(dplyr)))
suppressWarnings(suppressPackageStartupMessages(library(tokenizers)))
library(magrittr)
library(tidytext)
sapply(list.files("R/", full.names = TRUE), source)
options(scipen = 999)

# Data prep and read in
suppressWarnings(
  blogs <- readLines("Data/en_US/en_US.blogs.txt"))
suppressWarnings(
  tweets <- readLines("Data/en_US/en_US.twitter.txt"))
suppressWarnings(
  news <- readLines("Data/en_US/en_US.news.txt"))
saveRDS(blogs, file = "blogs.rds")
saveRDS(tweets, file = "tweets.rds")
saveRDS(news, file = "news.rds")

blogs <- readRDS("blogs.rds")
tweets <- readRDS("tweets.rds")
news <- readRDS("news.rds")

all_character <- c(blogs, tweets, news)
# To words
dt_blogs <- dt_characterVectorToTable(blogs)
dt_tweets <- dt_characterVectorToTable(tweets)
dt_news <- dt_characterVectorToTable(news)
dt_all <- rbind(dt_blogs, dt_news, dt_tweets)

# Calculate the frequencies.
dt_all_freq <- dt_calculateWordFrequencies(dt_all, "words")

# Put as keepers the words which are above the 0.95 mark, since the reverse (excluding small 
# frequency words will take too long)
keepers <- dt_all_freq[PercentageTextDescribed < 95]

# n-gram of order two

a <- lapply(all_character[1:2000], FUN = ngrams_bigramExtractor)
b <- unlist(a)


# n-gram of order 3
a <- lapply(all_character[1:2000], FUN = ngrams_trigramExtractor)
b <- unlist(a)

microbenchmark::microbenchmark(times = 100L, ngrams_trigramExtractor(all_character[1]))
# 2000 -> 79436
# https://cran.r-project.org/web/packages/text2vec/vignettes/text-vectorization.html
it_train <- text2vec::itoken(all_character[1:20],
                             tokenizer = word_tokenizer,
                             progressbar = FALSE)
vocab <- create_vocabulary(it_train)
