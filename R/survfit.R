
#' survfit method for survreg models
#'
#' @aliases survfit.survreg
#' @description Computes the predicted survivor function for a phpe model.
#' @importFrom survival survfit
#' @export
#' @param formula an object of the class survreg
#' @param newdata a data frame containing the set of explanatory variables; if NULL, a data.frame with the observed failure times and their corresponding estimated baseline survivals is returned.
#' @param ... further arguments passed to or from other methods.
#' @return  a data.frame containing the estimated survival probabilities.

survfit.survreg <- function(formula, newdata = NULL, ...){
  object <- formula
  dist <- object$dist
  mf <- stats::model.frame(object)
  Terms <- stats::delete.response(object$terms)
  labels <- names(mf)[-1]
  time <- c(0, sort( stats::model.response(mf)[,1]))

  null <- FALSE
  if(is.null(newdata)){
    null <- TRUE
    newdata <- data.frame(
      id = 1
    )
  }

  newdata$lp <-  stats::predict(object, newdata = newdata, type = "lp")
  df <- data.frame(
    time = time
  ) %>%
    dplyr::cross_join(newdata)

  N <- nrow(df)
  n <- length(time)
  J <- nrow(newdata)

  sigma <- object$scale
  y <- with(df, (log(time) - lp)/sigma)
  nu = exp(y)

  surv <- switch(dist,
                 exponential = pexp(nu, rate = 1, lower.tail=FALSE),
                 weibull = pexp(nu, rate = 1, lower.tail=FALSE),
                 lognormal = plnorm(nu, meanlog = 0, sdlog = 1, lower.tail=FALSE),
                 loglogistic = actuar::pllogis(nu, shape = 1, scale = 1, lower.tail = FALSE)
  )

  surv <- df %>%
    dplyr::mutate(
      id = as.factor(rep(1:J, n)),
      surv  = surv
    ) %>%
    dplyr::relocate(.data$id, .before = time) %>%
    dplyr::select(-.data$lp)

  if(isTRUE(null)){
    surv <- surv %>%
      select(-.data$id)
  }

  return(surv)

}
