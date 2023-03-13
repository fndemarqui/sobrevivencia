



tbfit <- function(formula, data, eps, iter.max, verbose=FALSE, ...){

  interv <- function(x,inf,sup) ifelse(x[1]>=inf & x[2]<=sup,1,0)

  cria.A <- function(resp, tau){
    tau12 <- cbind(tau[-length(tau)],tau[-1])
    interv <- function(x, inf, sup) ifelse(x[1] >= inf & x[2]<=sup, 1, 0)
    A <- apply(tau12, 1, interv,inf=resp$lower, sup=resp$upper)
    id.lin.zero <- which(apply(A==0, 1, all))
    if(length(id.lin.zero)>0) A <- A[-id.lin.zero, ]
    return(A)
  }

  mf <- stats::model.frame(formula=formula, data=data)
  resp <- as.data.frame(stats::model.response(mf))
  lower <- resp[,"lower"]
  upper <- resp[,"upper"]
  #tau <- sort(unique(c(lower, upper[is.finite(upper)])))
  tau <- sort(unique(c(lower, upper)))
  m <-length(tau)
  ekm <-survfit(Surv(tau[1:m-1], rep(1, m-1))~1)
  So <- c(1,ekm$surv)
  p <- -diff(So)
  tau12 <- cbind(tau[-length(tau)],tau[-1])
  A <- cria.A(resp, tau)
  n<-nrow(A)
  m<-ncol(A)
  Q<-matrix(1,m)
  iter <- 0
  repeat {
    iter <- iter + 1
    diff<- (Q-p)
    maxdiff<-max(abs(as.vector(diff)))
    if (verbose)
      print(maxdiff)
    if (maxdiff<eps | iter>=iter.max)
      break
    Q<-p
    C<-A%*%p
    p<-p*((t(A)%*%(1/C))/n)
  }
  cat("Iterations = ", iter,"\n")
  cat("Max difference = ", maxdiff,"\n")
  cat("Convergence criteria: Max difference < 1e-3","\n")
  dimnames(p)<-list(NULL,c("P Estimate"))
  surv<-round(c(1,1-cumsum(p)),digits=5)
  upper <- data$upper
  if(any(!(is.finite(upper)))){
    t <- max(upper[is.finite(upper)])
    return(data.frame(time=tau[tau<t],surv=surv[tau<t]))
  }
  else
    return(data.frame(time=tau,surv=surv))
}

#' Interval function
#' @aliases Inter
#' @export
#' @param lower lower bound of the interval
#' @param upper upper bound of the interval
#'
Inter <- function(lower, upper){
  n <- length(lower)
  resp <- cbind(lower, upper)
  colnames(resp) <- c("lower", "upper")
  return(resp)
}


#' Turnbull estimator for interval-censored survival data
#' @aliases turnbull
#' @export
#' @param formula an object of class "formula" (or one that can be coerced to that class): a symbolic description of the model to be fitted.
#' @param data an optional data frame, list or environment (or object coercible by as.data.frame to a data frame) containing the variables in the model. If not found in data, the variables are taken from environment(formula), typically the environment from which yppe is called.
#' @param eps eps
#' @param iter.max maximum number of iterations of the algorithm
#' @param verbose default = FALSE
#' @param ... further arguments passed to other methods
#' @return a data.frame with the estimated survivals
#'
#' @examples
#' \donttest{
#' library(sobrevivencia)
#' library(tidyverse)
#'
#' data(mama)
#' mama <- mama %>%
#'  mutate(
#'    direita = ifelse(is.na(direita), Inf, direita)
#'  )
#'
#'
#'tbe1 <- turnbull(Inter(esquerda, direita)~1, data = mama)
#'tbe2 <- turnbull(Inter(esquerda, direita)~terapia, data = mama)
#'
#'ggplot(tbe2, aes(x=time, y=survival, color = terapia)) +
#'  geom_step()
#'
#'ggplot(tbe1, aes(x=time, y=survival)) +
#'  geom_step()
#' }
turnbull <- function(formula, data, eps=1e-3, iter.max=200, verbose=FALSE, ...){

  interv <- function(x,inf,sup) ifelse(x[1]>=inf & x[2]<=sup,1,0)

  cria.A <- function(resp, tau){
    tau12 <- cbind(tau[-length(tau)],tau[-1])
    interv <- function(x, inf, sup) ifelse(x[1] >= inf & x[2]<=sup, 1, 0)
    A <- apply(tau12, 1, interv,inf=resp$lower, sup=resp$upper)
    id.lin.zero <- which(apply(A==0, 1, all))
    if(length(id.lin.zero)>0) A <- A[-id.lin.zero, ]
    return(A)
  }

  mf <- stats::model.frame(formula=formula, data=data)
  resp <- as.data.frame(stats::model.response(mf))
  lower <- resp[,"lower"]
  upper <- resp[,"upper"]
  if(ncol(mf)>1){
    group <- mf[, 2]
    groups <- unique(group)

    df <- data.frame(
      lower = lower,
      upper = upper,
      group = group
    )

    tbe <- data.frame()
    for(g in groups){
      mydata <- df %>%
        filter(group == g)
      fit <- tbfit(Inter(lower, upper) ~ 1, mydata, eps, iter.max, ...)
      fit$group <- g
      tbe <- bind_rows(tbe, fit)
    }

    df <- expand.grid(
      time = 0,
      surv = 1,
      group = unique(tbe$group)
    )

    tbe <- bind_rows(tbe, df) %>%
      arrange(group, time)
    names(tbe) <- c("time", "survival", names(mf)[2])

  }else{
    df <- data.frame(
      lower = lower,
      upper = upper
    )
    tbe <- tbfit(Inter(lower, upper) ~ 1, df, eps, iter.max, ...)
    names(tbe) <- c("time", "survival")
  }

  class(tbe) <- c("turnbull", "data.frame")
  return(tbe)
}




