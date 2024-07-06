#'Play a short sound
#'
#'\code{beep} plays a short sound which is useful if you want to get notified, 
#'for example, when a script has finished. As an added bonus there are a number 
#'of different sounds to choose from.
#'
#'If \code{beep} is not able to play the sound a warning is issued rather than 
#'an error. This is in order to not risk aborting or stopping the process that
#'you wanted to get notified about.
#'
#'@param sound character string or number specifying what sound to be played by 
#'  either specifying one of the built in sounds, specifying the path to a wav 
#'  file or specifying an url. The default is 1. Possible sounds are:
#'  \enumerate{ \item \code{"ping"} \item \code{"coin"} \item \code{"fanfare"}
#'  \item \code{"complete"} \item \code{"treasure"} \item \code{"ready"} \item
#'  \code{"shotgun"} \item \code{"mario"} \item \code{"wilhelm"} \item
#'  \code{"facebook"} \item \code{"sword"} } If \code{sound} does not match any
#'  of the sounds above, or is a valid path or url, a random sound will be
#'  played. If a negative number is given or the string "none" is given, no
#'  sound will be played.
#'@param expr An optional expression to be executed before the sound.
#'  
#'  
#'@return NULL
#'  
#' @examples
#' # Play a "ping" sound
#' beep()
#' 
#' \dontrun{
#' # Play a fanfare instead of a "ping".
#' beep("fanfare")
#' # or
#' beep(3)
#' 
#' # Play a random sound
#' beep(0)
#' 
#' # Update all packages and "ping" when it's ready
#' update.packages(ask=FALSE); beep()
#' }
#'@export
beep <- function(sound=1, expr=NULL) {
  expr
  sounds <- c(ping = "microwave_ping_mono.wav",
              coin = "smb_coin.wav",
              fanfare = "victory_fanfare_mono.wav",
              complete = "work_complete.wav",
              treasure = "new_item.wav",
              ready = "ready_master.wav",
              shotgun = "shotgun.wav",
              mario = "smb_stage_clear.wav",
              wilhelm = "wilhelm.wav",
              facebook = "facebook.wav",
              sword = "sword.wav")
  sound_path <- NULL
  if(sound < 0 || sound == "none") {
    # Play the sound of silence
    return(invisible())
  } else if(is.na(sounds[sound]) || length(sounds[sound]) != 1) {
    if(is.character(sound)) {
      # Trimming white space from the string defining the sound
      sound <- gsub("(^\\s+|\\s+$)", "", sound)
      if(file.exists(sound)) {
        sound_path <- sound
      } else if(grepl(pattern = "^http(s?)://", x = sound)) {
        temp_file <- tempfile(pattern="")
        if(download.file(sound, destfile = temp_file, mode = "wb", quiet = TRUE) == 0) { # The file was successfully downloaded
          sound_path <- temp_file
        } else {
          warning(paste("Tried but could not download", sound))
        }
      } else {
        warning(paste('"', sound, '" is not a valid sound nor path, playing a random sound instead.', sep = ""))
      }
    }
  } else {
    sound_path <- system.file(paste("sounds/", sounds[sound], sep=""), package="beepr")
  }
  
  if(is.null(sound_path)) { # play a random sound
    sound_path <- system.file(paste("sounds/", sample(sounds, size=1), sep=""), package="beepr")
  }
  
  tryCatch(play_file(sound_path), error = function(ex) {
    warning("beep() could not play the sound due to the following error:\n", ex)
  })
}

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
#'@return The value of \code{expr}, if no error occurs. If an error occurs then
#'\code{beep_on_error} will re-throw the error.
#'  
#'@examples
#' \dontrun{
#' # Play a "ping" sound if \code{expr} produces an error
#' beep_on_error(log("foo"))
#' 
#' # Stay silent if \code{expr} does not produce an error
#' beep_on_error(log(1))
#' 
#' 
#' # Play the Wilhelm scream instead of a ping on error.
#' beep_on_error(runif("bar"), "wilhelm")
#' }
#' 
#'@export
beep_on_error <- function(expr, sound = 1) {
  tryCatch(expr, error = function(e) {
    beep(sound)
    stop(e)
  })
}

is_wav_fname <- function(fname) {
  grepl(pattern = "\\.wav$", x = fname, ignore.case = TRUE)
}

escape_spaces <- function(s) {
  gsub(pattern = " ", replacement = "\\\\ ", x = s)
}

play_vlc <- function(fname) {
  fname <- escape_spaces(fname)
  system(paste0("vlc -Idummy --no-loop --no-repeat --playlist-autostart --no-media-library --play-and-exit ", fname), 
         ignore.stdout = TRUE, ignore.stderr=TRUE, wait = FALSE)
  invisible(NULL)
}

play_paplay <- function(fname) {
  fname <- escape_spaces(fname)
  system(paste0("paplay ", fname), ignore.stdout = TRUE, ignore.stderr=TRUE, wait = FALSE)
  invisible(NULL)
}

play_aplay <- function(fname) {
  fname <- escape_spaces(fname)
  system(paste0("aplay --buffer-time=48000 -N -q ", fname), ignore.stdout = TRUE, ignore.stderr=TRUE, wait = FALSE)
  invisible(NULL)
}

package_state <- new.env(parent = emptyenv())
play_audio <- function(fname) {
  if(!is.null(package_state$active_audio_instance)) {
    close(package_state$active_audio_instance)
  }
  sfx <- load.wave(fname)
  package_state$active_audio_instance <- play(sfx)
}

play_file <- function(fname) {
  if(Sys.info()["sysname"] == "Linux") {
    if(is_wav_fname(fname) && nchar(Sys.which("aplay")) >= 1) {
      play_aplay(fname)
    } else if(is_wav_fname(fname) && nchar(Sys.which("paplay")) >= 1) {
      play_paplay(fname)
    } else if(nchar(Sys.which("vlc")) >= 1) {
      play_vlc(fname)
    } else {
      play_audio(fname)
    }
  } else {
    play_audio(fname)
  }
}
