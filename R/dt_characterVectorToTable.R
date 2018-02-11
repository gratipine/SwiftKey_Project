dt_characterVectorToTable <- function(character_vector) {
  # Transform a character vector of lines into a character vector of words
  mine <- paste(character_vector, sep = "", collapse = "")
  words <- unlist(tokenize_words(mine))
  
  # Clean up unnecessary characters
  to_nothing <- c("_", "\\.")
  words <- gsub(paste(to_nothing, collapse = "|"), "", words, perl = TRUE)
  words <- words %>%
    data.table()
  names(words) <- "words"
  
  # Return the resulting data table
  return(words)
}