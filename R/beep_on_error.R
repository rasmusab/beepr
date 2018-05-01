#'Play a short sound if there is an error 
#'
#'\code{beep_on_error} wraps an expression and plays a short sound only if an 
#' error occurs. 
#'
#'If \code{beep} is not able to play the sound a warning is issued rather than 
#'an error. This is in order to not risk aborting or stopping the process that
#'you wanted to get notified about.
#'
#'@param expr An expression to be evaluated for errors.
#' 
#'@param sound character string or number specifying what sound to be played by 
#'  either specifying one of the built in sounds, specifying the path to a wav 
#'  file or specifying an url. The default is 1. Possible sounds are:
#'  \enumerate{ \item \code{"ping"} \item \code{"coin"} \item \code{"fanfare"}
#'  \item \code{"complete"} \item \code{"treasure"} \item \code{"ready"} \item
#'  \code{"shotgun"} \item \code{"mario"} \item \code{"wilhelm"} \item
#'  \code{"facebook"} \item \code{"sword"} } If \code{sound} does not match any
#'  of the sounds above, or is a valid path or url, a random sound will be
#'  played. Currently \code{beep} can only handle http urls, https is not
#'  supported.
#'  
#'  
#'@return NULL
#'  
#'@examples
#' # Play a "ping" sound if \code{expr} produces an error
#' beep_on_error(log("foo"))
#' 
#' # Stay silent if \code{expr} does not produce an error
#' beep_on_error(log(1))
#' 
#' \dontrun{
#' # Play the Wilhelm scream instead of a ping on error.
#' beep_on_error(runif("bar"), "wilhelm")
#' }
#' 
#'@export

beep_on_error <- function(expr, sound = 1) {
  q_expr <- substitute(expr)
  
  msg <- paste0("An error occurred in ", deparse(q_expr))
  e <- simpleError(msg)
  
  tryCatch(expr, error = function(e) {
    message(paste0(msg, ": ", e$message))
    beep(sound)
  })
}