#' Graphical Test of Proportional Hazards with ggplot2
#'
#' @description
#' Generic function to produce ggplot2-based diagnostic plots of the
#' proportional hazards assumption. Scaled Schoenfeld residuals are plotted
#' against time for each covariate, with a B-spline smoother superimposed.
#' A roughly horizontal smooth suggests that the proportional hazards
#' assumption holds; a systematic trend indicates a violation.
#'
#' @param object an object for which a method exists. Currently supported
#'   classes are \code{cox.zph} (returned by \code{\link[survival]{cox.zph}})
#'   and \code{coxph} (returned by \code{\link[survival]{coxph}}).
#' @param df degrees of freedom for the B-spline smoother fitted to the
#'   scaled Schoenfeld residuals. Default is \code{4}.
#' @param ... further arguments passed to specific methods.
#'
#' @return a \code{patchwork} object combining one panel per covariate.
#'
#' @export
ggcoxzph <- function(object, df = 4, ...) {
  UseMethod("ggcoxzph")
}


#' @rdname ggcoxzph
#'
#' @details
#' For objects of class \code{cox.zph}, the scaled Schoenfeld residuals and
#' the associated time vector are extracted directly from the object, and a
#' panel is produced for each covariate.
#'
#' @export
ggcoxzph.cox.zph <- function(object, df = 4, ...) {
  labels <- colnames(object$y)
  dat <- data.frame(time = object$x, object$y)
  plots <- list()
  for (label in labels) {
    p <- ggplot(dat, aes(x = time, y = .data[[label]])) +
      geom_point() +
      geom_smooth(
        method = lm, formula = y ~ splines2::bsp(x, df = df)
      ) +
      labs(x = "Time", y = label)
    plots <- c(plots, list(p))
  }
  names(plots) <- labels
  patchwork::wrap_plots(plots)
}


#' @rdname ggcoxzph
#'
#' @details
#' For objects of class \code{coxph}, \code{\link[survival]{cox.zph}} is
#' called first (any extra arguments in \code{...} are forwarded to it), and
#' then the resulting \code{cox.zph} object is passed to
#' \code{ggcoxzph.cox.zph}.
#'
#' @export
ggcoxzph.coxph <- function(object, df = 4, ...) {
  test <- survival::cox.zph(object, ...)
  ggcoxzph.cox.zph(test, df = df)
}
