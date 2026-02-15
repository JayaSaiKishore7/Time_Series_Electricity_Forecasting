# Helper: create embedding matrix
create_embedding <- function(series, lag) {
  n <- length(series)
  if (n <= lag) stop("Series length must be greater than lag")
  
  rows <- n - lag
  X <- matrix(NA, nrow = rows, ncol = lag)
  y <- numeric(rows)
  
  for (i in 1:rows) {
    X[i, ] <- series[i:(i + lag - 1)]
    y[i] <- series[i + lag]
  }
  
  list(X = X, y = y)
}

#' Train Weighted Nearest Neighbours model
#'
#' @param series Numeric time series
#' @param lag Embedding dimension
#' @param k Number of nearest neighbours
#' @export
wnn_fit <- function(series, lag = 96, k = 10) {
  emb <- create_embedding(series, lag)
  model <- list(X = emb$X, y = emb$y, lag = lag, k = k)
  class(model) <- "wnn_model"
  model
}

euclidean_distance <- function(a, b) sqrt(sum((a - b)^2))

predict_next <- function(window, model) {
  dists <- apply(model$X, 1, function(row) euclidean_distance(row, window))
  idx <- order(dists)[1:model$k]
  weights <- 1/(dists[idx] + 1e-8)
  weights <- weights / sum(weights)
  sum(weights * model$y[idx])
}

#' Forecast using WNN model
#'
#' @param model Model created by wnn_fit
#' @param h Forecast horizon
#' @export
wnn_forecast <- function(model, h = 96) {
  window <- model$X[nrow(model$X), ]
  preds <- numeric(h)
  
  for (i in 1:h) {
    next_val <- predict_next(window, model)
    preds[i] <- next_val
    window <- c(window[-1], next_val)
  }
  
  preds
}
