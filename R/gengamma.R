
#' Generalized gamma distribution
#' @export
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
#'
rggamma <- function(n, alpha, gamma, kappa){
  u <- runif(n)
  x <- qggamma(u, alpha, gamma, kappa)
  return(x)
}

#' Generalized gamma distribution
#' @export
#'
dggamma <- function(x, alpha, gamma, kappa, log = FALSE){
  lpdf <- log(kappa) - alpha*log(gamma) - lgamma(alpha/kappa) + (alpha-1)*log(x) - (x/gamma)^kappa
  if(isTRUE(log)){
    return(lpdf)
  }else{
    return(exp(lpdf))
  }
}

#' @export
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
