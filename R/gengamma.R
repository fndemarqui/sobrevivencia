
#' Generalized gamma distribution
#' @export
#' @param p vector of probabilities.
#' @param alpha scale parameter (alpha > 0).
#' @param gamma shape parameter (gamma > 0).
#' @param kappa shape parameter (kappa > 0).
#' @return A numeric vector of quantiles.
#'
qggamma <- function(p, alpha, gamma, kappa){
  q <- qgamma(p, shape = alpha/kappa, scale = 1)
  x <- gamma*(q^(1/kappa))
  return(x)
}


# qggamma2 <- function(p, nu, gamma, kappa){
#   q <- qgamma(p, shape = nu, scale = 1)
#   x <- gamma*(q^(1/kappa))
#   return(x)
# }


# qggamma3 <- function(p, nu, gamma, kappa){
#   q <- qgamma(p, shape = nu, scale = 1)
#   x <- gamma*(q^(1/kappa))
#   return(x)
# }

#' Generalized gamma distribution
#' @export
#' @param n number of observations.
#' @param alpha scale parameter (alpha > 0).
#' @param gamma shape parameter (gamma > 0).
#' @param kappa shape parameter (kappa > 0).
#' @return A numeric vector of random deviates.
#'
rggamma <- function(n, alpha, gamma, kappa){
  u <- runif(n)
  x <- qggamma(u, alpha, gamma, kappa)
  return(x)
}

#' Generalized gamma distribution
#' @export
#' @param x vector of quantiles.
#' @param alpha scale parameter (alpha > 0).
#' @param gamma shape parameter (gamma > 0).
#' @param kappa shape parameter (kappa > 0).
#' @param log logical; if TRUE, the log-density is returned. Default is FALSE.
#' @return A numeric vector of (log) density values.
#'
dggamma <- function(x, alpha, gamma, kappa, log = FALSE){
  lpdf <- log(kappa) - alpha*log(gamma) - lgamma(alpha/kappa) + (alpha-1)*log(x) - (x/gamma)^kappa
  if(isTRUE(log)){
    return(lpdf)
  }else{
    return(exp(lpdf))
  }
}

#' Generalized gamma distribution
#' @export
#' @param q vector of quantiles.
#' @param alpha scale parameter (alpha > 0).
#' @param gamma shape parameter (gamma > 0).
#' @param kappa shape parameter (kappa > 0).
#' @param log logical; if TRUE, probabilities are returned on the log scale. Default is FALSE.
#' @param lower.tail logical; if TRUE (default), probabilities are P(X <= x), otherwise P(X > x).
#' @return A numeric vector of (log) probabilities.
#'
pggamma <- function(q, alpha, gamma, kappa, log = FALSE, lower.tail = TRUE){
  x <- (q/gamma)^kappa
  p <- pgamma(x, shape = alpha/kappa, scale = 1)
  if(isTRUE(log)){
    if(isTRUE(lower.tail)){
      return(log(p))
    }else{
      return(log(1-p))
    }
  }else{
    if(isTRUE(lower.tail)){
      return(p)
    }else{
      return(1-p)
    }
  }
}

#' Generalized gamma distribution
#' @export
#' @param q vector of quantiles.
#' @param nu shape parameter (nu > 0).
#' @param gamma shape parameter (gamma > 0).
#' @param kappa shape parameter (kappa > 0).
#' @param log logical; if TRUE, probabilities are returned on the log scale. Default is FALSE.
#' @param lower.tail logical; if TRUE (default), probabilities are P(X <= x), otherwise P(X > x).
#' @return A numeric vector of (log) probabilities.
#'
pggamma2 <- function(q, nu, gamma, kappa, log = FALSE, lower.tail = TRUE){
  x <- (q/gamma)^kappa
  p <- pgamma(x, shape = nu, scale = 1)
  if(isTRUE(log)){
    if(isTRUE(lower.tail)){
      return(log(p))
    }else{
      return(log(1-p))
    }
  }else{
    if(isTRUE(lower.tail)){
      return(p)
    }else{
      return(1-p)
    }
  }
}

#' Generalized gamma distribution
#' @export
#' @param q vector of quantiles.
#' @param nu shape parameter (nu > 0).
#' @param lambda rate parameter (lambda > 0).
#' @param kappa shape parameter (kappa > 0).
#' @param log logical; if TRUE, probabilities are returned on the log scale. Default is FALSE.
#' @param lower.tail logical; if TRUE (default), probabilities are P(X <= x), otherwise P(X > x).
#' @return A numeric vector of (log) probabilities.
#'
pggamma3 <- function(q, nu, lambda, kappa, log = FALSE, lower.tail = TRUE){
  x <- lambda*(q^kappa)
  p <- pgamma(x, shape = nu, scale = 1)
  if(isTRUE(log)){
    if(isTRUE(lower.tail)){
      return(log(p))
    }else{
      return(log(1-p))
    }
  }else{
    if(isTRUE(lower.tail)){
      return(p)
    }else{
      return(1-p)
    }
  }
}

#' Generalized gamma distribution
#' @export
#' @param x vector of quantiles.
#' @param alpha scale parameter (alpha > 0).
#' @param gamma shape parameter (gamma > 0).
#' @param kappa shape parameter (kappa > 0).
#' @param log logical; if TRUE, the log-hazard is returned. Default is FALSE.
#' @return A numeric vector of (log) hazard values.
#'
hggamma <- function(x, alpha, gamma, kappa, log = FALSE){
  lpdf <- dggamma(x, alpha, gamma, kappa, log = TRUE)
  lccdf  <- pggamma(x, alpha, gamma, kappa, log = TRUE, lower.tail = FALSE)
  lhf <- lpdf - lccdf
  if(isTRUE(log)){
    return(lhf)
  }else{
    return(exp(lhf))
  }
}
