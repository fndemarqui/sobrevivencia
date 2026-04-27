
#' The 'sobrevivencia' package.
#'
#' @description Random generation of survival data based on different survival regression models available in the literature, including Accelerated Failure Time (AFT) model, Proportional Hazard (PH) model, Proportional Odds (PO) model and the Yang & Prentice (YP) model.
#'
#' _PACKAGE
#' @name sobrevivencia-package
#' @aliases sobrevivencia
#' @import survival
#' @importFrom Rdpack reprompt
#' @importFrom stats coef model.extract model.frame model.matrix model.response
#'   pexp pgamma plnorm qgamma residuals runif lm
#' @importFrom ggplot2 ggplot aes geom_point geom_abline geom_jitter geom_smooth
#'   geom_step position_jitter xlab labs xlim ylim
#' @importFrom dplyr filter bind_rows arrange select mutate relocate cross_join
#' @importFrom rlang .data
#'
#' @references
#'
#' \insertRef{bookEnrico}{sobrevivencia}
#'
#' \insertRef{bookFiocruz}{sobrevivencia}
#'
#' \insertRef{bookMarta}{sobrevivencia}
#'
#' \insertRef{2006Sun}{sobrevivencia}
#'
NULL

utils::globalVariables(c("surv", "x", "obs", "deviance", "time", ".data"))
