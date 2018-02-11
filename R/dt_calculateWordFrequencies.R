dt_calculateWordFrequencies <- function(dt, column_to_calculate) {
  
  # Calculate the counts of words
  counted <- data.table(table(dt))
  # Calculate the frequences of each word
  counted[, Frequency := N / sum(N),]
  
  # Sort by maximum frequency
  counted <- counted[order(-Frequency),,]
  
  # calculate the cummulative sum of the frequency to be able to say how many words
  # it takes to be at 90% description of the text or 95% description of text
  # Do not remove filler words like "and" and "the"
  counted[,PercentageTextDescribed := cumsum(Frequency),]
  
  # Return the computed data table
  return(counted)
}