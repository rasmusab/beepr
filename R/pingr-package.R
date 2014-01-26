#' pingr: The package that sounds as it is called.
#' 
#' This package contains one function, ping(), with one purpose: To go ping on
#' whatever platform you are on. Is intended to be useful, for example, if you
#' are running a long analysis in the background and want to know when it is
#' ready. Also useful if you want to irritate colleagues.
#' 
#' The package just contains one function \code{\link{ping}}, check it out to
#' see what it does. For sound on Windows and MacOS \pkg{pingr} depends on the
#' \pkg{audio} package. For sound on Linux \pkg{pingr} depends on that VLC media
#' player (http://www.videolan.org/vlc/index.html) is installed and on the PATH.
#' 
#' @examples
#' \dontrun{
#' # Update all packages and ping when it's ready
#' update.packages(ask=FALSE); ping()
#' }
#' 
#' @name pingr
#' @docType package
#' @author Rasmus Bååth < rasmus.baath@@gmail.com >
#' @import audio stringr
NULL