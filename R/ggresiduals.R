


#---------------------------------------------
#' Generic S3 method ggresiduals
#' @aliases ggresiduals
#' @export
#' @param object a fitted model object.
#' @details Generic method to plot residuals of survival models.
#' @param ... further arguments passed to or from other methods.
#' @return the desired residual plot.
#'
ggresiduals <- function(object, ...) UseMethod("ggresiduals")


#' ggresiduals method for survreg models
#' @aliases ggresiduals.survreg
#' @export
#' @param object a fitted model object of the class survreg.
#' @details This function produces residuals plots of Cox-Snell residuals, martingale residuals and deviance residuals.
#' @param type type of residuals used in the plot: coxsnell (default), martingale and deviance.
#' @param ... further arguments passed to or from other methods.
#' @return the desired residual plot.
#'
ggresiduals.survreg <- function(object, type = c("coxsnell", "martingale", "deviance"), ...){

  type <- tolower(type)
  type <- match.arg(type)
  dist <- object$dist
  mf <- model.frame(object)
  time <- model.extract(mf, "response")[,1]
  event <- model.extract(mf, "response")[,2]
  lp <- object$linear.predictors
  scale <- object$scale
  y = log(time)
  epsilon <- (y - lp)/scale
  nu <- exp(epsilon)
  rcs <- switch(dist,
                exponential = -pexp(nu, rate = 1, lower.tail=FALSE, log.p = TRUE),
                weibull = -pexp(nu, rate = 1, lower.tail=FALSE, log.p = TRUE),
                lognormal = -plnorm(nu, meanlog = 0, sdlog = 1, lower.tail=FALSE, log.p = TRUE),
                loglogistic = -actuar::pllogis(nu, shape = 1, scale = 1, lower.tail = FALSE, log.p = TRUE)
  )


  if(type == "coxsnell"){
    ekm <- survfit(Surv(rcs, event)~1)
    tb <- tibble::tibble(
      time = ekm$time,
      ekm = ekm$surv,
      surv = exp(-time)
    )

    ggplot(data = tb, aes(x=ekm, y=surv)) +
      geom_point() +
      geom_abline(intercept = 0, slope = 1, color = "blue") +
      labs(x = "Kaplan-Meier", y = dist) +
      xlim(0, 1) +
      ylim(0, 1)

  }else if(type == "martingale"){
    X <- stats::model.matrix(object)[, -1, drop = FALSE]
    p <- ncol(X)
    mf <- stats::model.frame(object)
    time <- stats::model.response(mf)[, 1]
    martingale <- event - rcs
    if(p==0){
      message("Martingale residuals plots available only for models with at least one covariate!")
    }else{
      labels <- names(mf)[-1]
      tb <- mf %>%
        select(labels)
      labels <- names(tb)
      q <- ncol(tb)

      plots <- list()
      for(j in 1:q){
        df <- data.frame(
          x = tb[,j],
          martingale = martingale
        )
        if(is.factor(df$x)){
          plots[[j]] <- ggplot(data = df, aes(x = x, y = martingale)) +
            geom_jitter(position=position_jitter(0.1))
          xlab(labels[j])
        }else{
          plots[[j]] <- ggplot(data = df, aes(x = x, y = martingale)) +
            geom_point() +
            geom_smooth(se = FALSE) +
            xlab(labels[j])
        }
      }
      if(q==1){
        gridExtra::grid.arrange(grobs = plots)
      }else{
        gridExtra::grid.arrange(grobs = plots, ncol = 2)
      }
    }
  }else{
    mf <- stats::model.frame(object)
    time <- stats::model.response(mf)[, 1]
    martingale <- event - rcs
    df <- data.frame(
      obs = 1:length(time),
      deviance = sign(martingale)*sqrt((-2*(martingale + event*log(event - martingale))))
    )

    ggplot(data = df, aes(x = obs, y = deviance)) +
      geom_point() +
      geom_abline(intercept = 0, slope = 0 , color = "blue")

  }
}


#' ggresiduals method for coxph models
#' @aliases ggresiduals.coxph
#' @export
#' @param object a fitted model object of the class coxph.
#' @details This function produces residuals plots of Cox-Snell residuals, martingale residuals and deviance residuals.
#' @param type type of residuals used in the plot: coxsnell (default), martingale and deviance.
#' @param ... further arguments passed to or from other methods.
#' @return the desired residual plot.
#'
ggresiduals.coxph <- function(object, type = c("coxsnell", "martingale", "deviance"), ...){

  type <- tolower(type)
  type <- match.arg(type)
  p <- length(coef(object))
  mf <- model.frame(object)
  time <- model.extract(mf, "response")[,1]
  event <- model.extract(mf, "response")[,2]
  lp <- object$linear.predictors

  martingale <- residuals(object, type = "martingale")
  rcs <- event - martingale
  deviance <- residuals(object, type = "deviance")


  if(type == "coxsnell"){
    ekm <- survfit(Surv(rcs, event)~1)
    tb <- tibble::tibble(
      time = ekm$time,
      ekm = ekm$surv,
      surv = exp(-time)
    )

    ggplot(data = tb, aes(x=ekm, y=surv)) +
      geom_point() +
      geom_abline(intercept = 0, slope = 1, color = "blue") +
      labs(x = "Kaplan-Meier", y = "Cox model") +
      xlim(0, 1) +
      ylim(0, 1)

  }else if(type == "martingale"){
    if(p==0){
      message("Martingale residuals plots available only for models with at least one covariate!")
    }else{
      labels <- names(mf)[-1]
      tb <- mf[, labels]
      labels <- names(tb)
      q <- ncol(tb)

      plots <- list()
      for(j in 1:q){
        df <- data.frame(
          x = tb[,j],
          martingale = martingale
        )
        if(is.factor(df$x)){
          plots[[j]] <- ggplot(data = df, aes(x = x, y = martingale)) +
            geom_jitter(position=position_jitter(0.1))
          xlab(labels[j])
        }else{
          plots[[j]] <- ggplot(data = df, aes(x = x, y = martingale)) +
            geom_point() +
            geom_smooth(se = FALSE) +
            xlab(labels[j])
        }
      }
      if(q==1){
        gridExtra::grid.arrange(grobs = plots)
      }else{
        gridExtra::grid.arrange(grobs = plots, ncol = 2)
      }
    }
  }else{
    mf <- stats::model.frame(object)
    time <- stats::model.response(mf)[, 1]
    martingale <- event - rcs
    df <- data.frame(
      obs = 1:length(time),
      deviance = sign(martingale)*sqrt((-2*(martingale + event*log(event - martingale))))
    )

    ggplot(data = df, aes(x = obs, y = deviance)) +
      geom_point() +
      geom_abline(intercept = 0, slope = 0 , color = "blue")

  }
}
