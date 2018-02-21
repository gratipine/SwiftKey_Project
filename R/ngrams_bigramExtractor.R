ngrams_bigramExtractor <- function(character_vector) {
  character_vector <- data.table(character_vector)
  setnames(character_vector, "V1")
  bigrams <- unnest_tokens(character_vector, bigram, V1, token = "ngrams", n = 2)
  to_get <- bigrams$bigram
  names(to_get) <- NULL
  return(to_get)
}
