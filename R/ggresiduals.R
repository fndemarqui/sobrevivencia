
# criando a função generica ggresiduals

#' @export
ggresiduals <- function(object, ...) UseMethod("ggresiduals")


#' @export
ggresiduals.survreg <- function(object, type = c("I", "II")){
  type <- match.arg(type)
  dist <- object$dist
  mf <- model.frame(object)
  time <- model.extract(mf, "response")[,1]
  status <- model.extract(mf, "response")[,2]
  epsilon <- with(object, (log(time)-linear.predictors)/scale)
  nu <- exp(epsilon)
  ekm <- survfit(Surv(nu, status)~1)
  surv <- switch(dist,
                 exponential = pexp(ekm$time, lower=FALSE,),
                 weibull = pexp(ekm$time, lower=FALSE),
                 lognormal = plnorm(ekm$time, lower=FALSE),
                 loglogistic = 1/(1+ekm$time)
  )


  df <- data.frame(time = ekm$time, surv1 = ekm$surv, surv2 = surv)
  if(type == "I"){
    p <- ggplot(df, aes(x = time)) +
      geom_step(aes(y = surv1)) +
      geom_line(aes(y = surv2), color = "blue") +
      ylim(0, 1) +
      xlab("exp(standardized residuals)") +
      ylab("Survival") +
      ggtitle(object$dist)
    p
  }else{
    n <- nrow(df)
    p <- ggplot(df, aes(x = surv1, y = surv2)) +
      geom_point() +
      geom_line(aes(x = seq(0, 1, length.out = n), y = seq(0, 1, length.out = n)), color = "blue") +
      xlab("Kaplan-Meyer") +
      ylab(object$dist)
    p
  }

}



