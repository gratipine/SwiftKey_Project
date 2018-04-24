ngrams_trigramExtractor <- function(character_vector) {
  character_vector <- data.table(character_vector)
  setnames(character_vector, "V1")
  trigrams <- unnest_tokens(character_vector, trigram, V1, token = "ngrams", n = 3)
  to_get <- trigrams$trigram
  return(to_get)
}
