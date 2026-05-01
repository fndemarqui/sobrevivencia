#' @importFrom broom augment
#' @export
broom::augment


# Internal helper: extract time and event indicator from a survstan model frame.
extract_surv <- function(mf) {
  resp <- model.extract(mf, "response")
  list(time = unname(resp[, 1]), event = unname(resp[, 2]))
}

# Internal helper: compute linear predictor and its standard error.
lp_se <- function(X, beta, Vb) {
  list(
    lp = as.vector(X %*% beta),
    se = sqrt(pmax(0, diag(X %*% Vb %*% t(X))))
  )
}


#' augment method for survstan models
#'
#' @importFrom broom augment
#' @export
#' @aliases augment.survstan
#' @param x a fitted model object of class `"survstan"`.
#' @param data a data frame to augment. Defaults to the model frame used
#'   during fitting (covariates only, response excluded). Ignored when
#'   `newdata` is supplied.
#' @param newdata an optional data frame of new observations. When provided,
#'   `.fitted` and `.se.fit` are computed from these data. Because observed
#'   outcomes are not available, `.time`, `.event`, and all residual columns
#'   are set to `NA`.
#' @param ... further arguments passed to or from other methods.
#' @return A [tibble::tibble()] with one row per observation. The first two
#'   columns are:
#'   \describe{
#'     \item{`.time`}{observed failure/censoring time;}
#'     \item{`.event`}{event indicator (1 = event, 0 = censored).}
#'   }
#'   Followed by the original covariate columns and:
#'   \describe{
#'     \item{`.fitted`}{linear predictor \eqn{X\hat{\beta}};}
#'     \item{`.se.fit`}{standard error of the linear predictor;}
#'     \item{`.resid.coxsnell`}{Cox-Snell residuals, or `NA` when `newdata`
#'       is supplied;}
#'     \item{`.resid.martingale`}{martingale residuals, or `NA` when `newdata`
#'       is supplied;}
#'     \item{`.resid.deviance`}{deviance residuals, or `NA` when `newdata`
#'       is supplied.}
#'   }
#' @examples
#' library(survival)
#' library(survstan)
#' fit <- phreg(Surv(futime, fustat) ~ age + rx, data = ovarian, dist = "weibull")
#'
#' # Augment training data (all three residual types returned)
#' augment(fit)
#'
#' # Predictions on new observations
#' augment(fit, newdata = data.frame(age = c(50, 60, 70), rx = c(1, 2, 1)))
augment.survstan <- function(x, data = NULL, newdata = NULL, ...) {
  beta <- utils::head(x$estimates, x$p)
  V <- vcov(x)

  if (!is.null(newdata)) {
    # delete.response() strips the Surv() LHS so model.matrix does not try
    # to evaluate it on newdata (which has no outcome columns).
    X_new <- model.matrix(stats::delete.response(x$terms), newdata)[, -1, drop = FALSE]
    pred <- lp_se(X_new, beta, V)

    tibble::as_tibble(newdata) |>
      dplyr::mutate(
        .time = NA_real_,
        .event = NA_real_,
        .fitted = pred$lp,
        .se.fit = pred$se,
        .resid.coxsnell = NA_real_,
        .resid.martingale = NA_real_,
        .resid.deviance = NA_real_
      ) |>
      dplyr::relocate(.time, .event)
  } else {
    mf <- x$mf
    if (is.null(data)) {
      data <- mf[, -1, drop = FALSE]
    }
    surv <- extract_surv(mf)
    X <- model.matrix(x$formula, mf)[, -1, drop = FALSE]
    pred <- lp_se(X, beta, V)

    tibble::as_tibble(data) |>
      dplyr::mutate(
        .time = surv$time,
        .event = surv$event,
        .fitted = pred$lp,
        .se.fit = pred$se,
        .resid.coxsnell = unname(residuals(x, type = "coxsnell")),
        .resid.martingale = unname(residuals(x, type = "martingale")),
        .resid.deviance = unname(residuals(x, type = "deviance"))
      ) |>
      dplyr::relocate(.time, .event)
  }
}


#' augment method for ypreg (Yang & Prentice) models
#'
#' @importFrom broom augment
#' @export
#' @aliases augment.ypreg
#' @param x a fitted model object of class `"ypreg"`.
#' @param data a data frame to augment. Defaults to the model frame used
#'   during fitting (covariates only, response excluded). Ignored when
#'   `newdata` is supplied.
#' @param newdata an optional data frame of new observations. When provided,
#'   both linear predictors and their standard errors are computed from these
#'   data. Because observed outcomes are not available, `.time`, `.event`, and
#'   all residual columns are set to `NA`.
#' @param ... further arguments passed to or from other methods.
#' @return A [tibble::tibble()] with one row per observation. The first two
#'   columns are:
#'   \describe{
#'     \item{`.time`}{observed failure/censoring time;}
#'     \item{`.event`}{event indicator (1 = event, 0 = censored).}
#'   }
#'   Followed by the original covariate columns and:
#'   \describe{
#'     \item{`.fitted.short`}{short-term linear predictor
#'       \eqn{X\hat{\beta}_{\text{short}}};}
#'     \item{`.se.fit.short`}{standard error of the short-term linear
#'       predictor;}
#'     \item{`.fitted.long`}{long-term linear predictor
#'       \eqn{X\hat{\beta}_{\text{long}}};}
#'     \item{`.se.fit.long`}{standard error of the long-term linear
#'       predictor;}
#'     \item{`.resid.coxsnell`}{Cox-Snell residuals, or `NA` when `newdata`
#'       is supplied;}
#'     \item{`.resid.martingale`}{martingale residuals, or `NA` when `newdata`
#'       is supplied;}
#'     \item{`.resid.deviance`}{deviance residuals, or `NA` when `newdata`
#'       is supplied.}
#'   }
#' @examples
#' library(survival)
#' library(survstan)
#' fit <- ypreg(Surv(futime, fustat) ~ age + rx, data = ovarian, dist = "weibull")
#'
#' # Augment training data
#' augment(fit)
#'
#' # Predictions on new observations
#' augment(fit, newdata = data.frame(age = c(50, 60, 70), rx = c(1, 2, 1)))
augment.ypreg <- function(x, data = NULL, newdata = NULL, ...) {
  p <- x$p
  V <- vcov(x)

  beta_short <- x$estimates[seq_len(p)]
  beta_long <- x$estimates[seq_len(p) + p]
  V_short <- V[seq_len(p), seq_len(p), drop = FALSE]
  V_long <- V[seq_len(p) + p, seq_len(p) + p, drop = FALSE]

  if (!is.null(newdata)) {
    X_new <- model.matrix(stats::delete.response(x$terms), newdata)[, -1, drop = FALSE]
    short <- lp_se(X_new, beta_short, V_short)
    long <- lp_se(X_new, beta_long, V_long)

    tibble::as_tibble(newdata) |>
      dplyr::mutate(
        .time = NA_real_,
        .event = NA_real_,
        .fitted.short = short$lp,
        .se.fit.short = short$se,
        .fitted.long = long$lp,
        .se.fit.long = long$se,
        .resid.coxsnell = NA_real_,
        .resid.martingale = NA_real_,
        .resid.deviance = NA_real_
      ) |>
      dplyr::relocate(.time, .event)
  } else {
    mf <- x$mf
    if (is.null(data)) {
      data <- mf[, -1, drop = FALSE]
    }
    surv <- extract_surv(mf)
    X <- model.matrix(x$formula, mf)[, -1, drop = FALSE]
    short <- lp_se(X, beta_short, V_short)
    long <- lp_se(X, beta_long, V_long)

    tibble::as_tibble(data) |>
      dplyr::mutate(
        .time = surv$time,
        .event = surv$event,
        .fitted.short = short$lp,
        .se.fit.short = short$se,
        .fitted.long = long$lp,
        .se.fit.long = long$se,
        .resid.coxsnell = unname(residuals(x, type = "coxsnell")),
        .resid.martingale = unname(residuals(x, type = "martingale")),
        .resid.deviance = unname(residuals(x, type = "deviance"))
      ) |>
      dplyr::relocate(.time, .event)
  }
}


#' augment method for ehreg (Extended Hazard) models
#'
#' @importFrom broom augment
#' @export
#' @aliases augment.ehreg
#' @param x a fitted model object of class `"ehreg"`.
#' @param data a data frame to augment. Defaults to the model frame used
#'   during fitting (covariates only, response excluded). Ignored when
#'   `newdata` is supplied.
#' @param newdata an optional data frame of new observations. When provided,
#'   both linear predictors and their standard errors are computed from these
#'   data. Because observed outcomes are not available, `.time`, `.event`, and
#'   all residual columns are set to `NA`.
#' @param ... further arguments passed to or from other methods.
#' @return A [tibble::tibble()] with one row per observation. The first two
#'   columns are:
#'   \describe{
#'     \item{`.time`}{observed failure/censoring time;}
#'     \item{`.event`}{event indicator (1 = event, 0 = censored).}
#'   }
#'   Followed by the original covariate columns and:
#'   \describe{
#'     \item{`.fitted.AF`}{accelerated failure linear predictor
#'       \eqn{X\hat{\beta}_{\text{AF}}};}
#'     \item{`.se.fit.AF`}{standard error of the AF linear predictor;}
#'     \item{`.fitted.RH`}{relative hazard linear predictor
#'       \eqn{X\hat{\beta}_{\text{RH}}};}
#'     \item{`.se.fit.RH`}{standard error of the RH linear predictor;}
#'     \item{`.resid.coxsnell`}{Cox-Snell residuals, or `NA` when `newdata`
#'       is supplied;}
#'     \item{`.resid.martingale`}{martingale residuals, or `NA` when `newdata`
#'       is supplied;}
#'     \item{`.resid.deviance`}{deviance residuals, or `NA` when `newdata`
#'       is supplied.}
#'   }
#' @examples
#' library(survival)
#' library(survstan)
#' fit <- ehreg(Surv(futime, fustat) ~ age + rx, data = ovarian, dist = "weibull")
#'
#' # Augment training data
#' augment(fit)
#'
#' # Predictions on new observations
#' augment(fit, newdata = data.frame(age = c(50, 60, 70), rx = c(1, 2, 1)))
augment.ehreg <- function(x, data = NULL, newdata = NULL, ...) {
  p <- x$p
  V <- vcov(x)

  beta_AF <- x$estimates[seq_len(p)]
  beta_RH <- x$estimates[seq_len(p) + p]
  V_AF <- V[seq_len(p), seq_len(p), drop = FALSE]
  V_RH <- V[seq_len(p) + p, seq_len(p) + p, drop = FALSE]

  if (!is.null(newdata)) {
    X_new <- model.matrix(stats::delete.response(x$terms), newdata)[, -1, drop = FALSE]
    AF <- lp_se(X_new, beta_AF, V_AF)
    RH <- lp_se(X_new, beta_RH, V_RH)

    tibble::as_tibble(newdata) |>
      dplyr::mutate(
        .time = NA_real_,
        .event = NA_real_,
        .fitted.AF = AF$lp,
        .se.fit.AF = AF$se,
        .fitted.RH = RH$lp,
        .se.fit.RH = RH$se,
        .resid.coxsnell = NA_real_,
        .resid.martingale = NA_real_,
        .resid.deviance = NA_real_
      ) |>
      dplyr::relocate(.time, .event)
  } else {
    mf <- x$mf
    if (is.null(data)) {
      data <- mf[, -1, drop = FALSE]
    }
    surv <- extract_surv(mf)
    X <- model.matrix(x$formula, mf)[, -1, drop = FALSE]
    AF <- lp_se(X, beta_AF, V_AF)
    RH <- lp_se(X, beta_RH, V_RH)

    tibble::as_tibble(data) |>
      dplyr::mutate(
        .time = surv$time,
        .event = surv$event,
        .fitted.AF = AF$lp,
        .se.fit.AF = AF$se,
        .fitted.RH = RH$lp,
        .se.fit.RH = RH$se,
        .resid.coxsnell = unname(residuals(x, type = "coxsnell")),
        .resid.martingale = unname(residuals(x, type = "martingale")),
        .resid.deviance = unname(residuals(x, type = "deviance"))
      ) |>
      dplyr::relocate(.time, .event)
  }
}
