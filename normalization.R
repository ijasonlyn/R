
normalization <- function(vec) {
  # convert the number in between 0 and 1
  # input: a vector
  # output: a vector
  
  mi <- min(vec)
  ma <- max(vec)
  
  if(mi == ma) return(rep(0.5, length(vec)))
  
  res <- (vec - mi)/ (ma -  mi)
  res <- round(res,4)
  
  return(res)
}