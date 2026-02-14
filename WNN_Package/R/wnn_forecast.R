#' Weighted Nearest Neighbours Forecast
#'
#' @param series Numeric time series
#' @param k Number of nearest neighbours
#' @param h Forecast horizon
#' @param l Embedding dimension
#' @return Numeric vector of forecasts
#' @export
wnn_forecast <- function(series, k = 5, h = 1, l = 5) {
  
  n <- length(series)
  
  if (n <= l) stop("Series too short")
  
  forecasts <- numeric(h)
  
  for (step in 1:h) {
    
    target_pattern <- series[(n - l + 1):n]
    
    distances <- numeric(n - l)
    
    for (i in 1:(n - l)) {
      pattern <- series[i:(i + l - 1)]
      distances[i] <- sqrt(sum((pattern - target_pattern)^2))
    }
    
    nearest_idx <- order(distances)[1:k]
    
    weights <- 1 / distances[nearest_idx]
    weights <- weights / sum(weights)
    
    next_values <- series[nearest_idx + l]
    
    forecasts[step] <- sum(weights * next_values)
    
    series <- c(series, forecasts[step])
    n <- length(series)
  }
  
  return(forecasts)
}
