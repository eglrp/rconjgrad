#' rconjgrad: A package for conjugate gradient minimization with different
#' line search methods.
#'
#' @section Optimization:
#' Optimization is carried out via the \code{\link{conj_grad}} function. See its
#' documentation for details. There is nothing terribly special about its
#' implementation of conjugate gradient optimization. It is a translation of
#' Matlab code originally written by
#' \href{http://learning.eng.cam.ac.uk/carl/code/minimize/}{Carl Edward Rasmussen},
#' with some minor modifications to allow for different convergence criteria,
#' and to reset to steepest descent under more conditions if desired, e.g.
#' based on orthogonality tests or if the 'beta' update parameter becomes
#' negative.
#' However, unlike most other optimization packages, it is possible
#' to provide a user-defined line search routine. Two implementations are
#' currently available: the original Rasmussen code, and a modified version of
#' the More'-Thuente method, originally implemented in MINPACK and translated
#' into Matlab by Dianne O'Leary.
#'
#' @section Line Search:
#' A user-defined line search function can be passed to the \code{line_search}
#' parameter of the \code{conj_grad} function (normally it takes a string
#' argument indicating whether Rasmussen or More'-Thuente is to be used).
#'
#' The line search function should have the following signature:
#'
#' \code{function(phi, step0, alpha)}
#'
#' where:
#'
#' \itemize{
#'  \item \code{phi} The 1D line function, evaluated at each candidate step
#'  length and returning function and gradient values. See the 'Line Function
#'  (Phi)' section for details.
#'  \item \code{step0} Line search information for a step of size 0, i.e. the
#'  function information at the start point of the line search. See the 'Line
#'  Search Information (Step)' section below.
#'  \item \code{alpha} The value of the initial step size.
#' }
#'
#' The return value of the line search function should be a list containing:
#'
#' \itemize{
#'  \item \code{step} The step information about the best step size found. See
#'  the 'Line Search Information (Step)' section below.
#'  \item \code{nfn} Number of function evaluations that took place during the
#'  line search. See the 'Line Function (Phi)' section for details.
#'  \item \code{ngr} Number of gradient evaluations that took place during the
#'  line search. See the 'Line Function (Phi)' section for details.
#' }
#'
#' The \code{\link{rasmussen}} and \code{\link{more_thuente}} factory functions
#' both return suitable line search functions that meet these interface
#' requirements when invoked with suitable parameters to do with Wolfe
#' conditions and extrapolation and interpolation checks.
#'
#' @section Line Function (Phi):
#' The line function, \code{phi} is a 1D function with the following signature:
#'
#' \code{function(alpha)}
#'
#' where \code{alpha} is the step size. The return value is a list containing
#' information about the function evaluated at that step size. See the
#' 'Line Search Information (Step)' section for details.
#'
#' @section Line Search Information (Step):
#' The \code{step} list contains information about the function value at a
#' specific step length alone the line search. It consists of:
#' \itemize{
#'  \item \code{alpha} Step length the function was evaluated at.
#'  \item \code{par} Parameter vector at \code{alpha}.
#'  \item \code{f} The value of the function \code{fn} at \code{alpha}.
#'  \item \code{df} The value of the gradient function \code{gr} at
#'    \code{alpha}.
#'  \item \code{d} The value of the directional derivative at
#'  (the gradient of the line function) at \code{alpha}.
#' }
#'
#' @docType package
#' @name rconjgrad
NULL
