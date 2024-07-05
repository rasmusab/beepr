#' Easily Play Notification Sounds on any Platform
#'
#' This package contains one function, beep(), with one purpose: To make it easy
#' to play notification sounds on whatever platform you are on. It is intended to
#' be useful, for example, if you are running a long analysis in the background
#' and want to know when it is ready.
#'
#' The package contains one main function \code{\link{beep}}, check it out to
#' see what it does. For sound on Windows and MacOS \pkg{beepr} depends on the
#' \pkg{audio} package. For sound on Linux \pkg{beepr} depends on that either
#' the paplay utility from the Pulse Audio system, the aplay utility from the
#' ALSA system, or VLC media player (http://www.videolan.org/vlc/index.html) is
#' installed and on the PATH. Chances are that you already have one of these.
#'
#' @examples
#' # Play a "ping" sound
#' beep()
#'
#' @name beepr
#' @encoding UTF-8
#' @author Rasmus Bååth < rasmus.baath@@gmail.com >
#' @import audio utils
"_PACKAGE"