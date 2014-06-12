#'Play a short sound
#'
#'\code{ping} plays a short sound which is useful if you want to get notified, 
#'for example, when a script has finished. As an added bonus there are a number 
#'of different sounds to choose from.
#'
#'
#'@param sound character string or number specifying what sound to be played by either
#' specifying one of the built in sounds or specifying the path to a wav file.
#'  The default is 1. Possible sounds are: \enumerate{
#'   \item \code{"ping"}
#'   \item \code{"coin"}
#'   \item \code{"fanfare"}
#'   \item \code{"complete"}
#'   \item \code{"treasure"}
#'   \item \code{"ready"}
#'   \item \code{"shotgun"}
#'   \item \code{"mario"}
#'   \item \code{"wilhelm"}
#'   \item \code{"facebook"}
#' } If \code{sound} does not match any of the sounds above, or is a valid path, a random
#' sound will be played.
#' @param expr An optional expression to be excecuted before the sound.
#'   
#'   
#' @return NULL
#'   
#' @examples
#' \dontrun{
#' 
#' # Update all packages and ping when it's ready
#' update.packages(ask=FALSE); ping()
#' 
#' # Play a fanfare instead of a ping.
#' ping("fanfare")
#' # or
#' ping(3)
#' 
#' # Play a random sound
#' ping(0)
#' 
#' }
#' @export
ping <- function(sound=1, expr=NULL) {
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
              facebook = "facebook.wav")
  if(is.na(sounds[sound]) || length(sounds[sound]) != 1) {
    if(is.character(sound) && file.exists(sound)) {
      sound_path <- sound
    } else{
      sound_path <- system.file(paste("sounds/", sample(sounds, size=1), sep=""), package="pingr")
    }
  } else {
    sound_path <- system.file(paste("sounds/", sounds[sound], sep=""), package="pingr")
  }
  play_file(sound_path)
}


is_wav_fname <- function(fname) {
  str_detect(fname, ignore.case("\\.wav$"))
}

play_vlc <- function(fname) {
  system(paste("vlc -Idummy --no-loop --no-repeat --playlist-autostart --no-media-library --play-and-exit", fname), 
         ignore.stdout = TRUE, ignore.stderr=TRUE,wait = FALSE)
  invisible(NULL)
}

play_paplay <- function(fname) {
  system(paste("paplay ", fname), ignore.stdout = TRUE, ignore.stderr=TRUE,wait = FALSE)
  invisible(NULL)
}

play_aplay <- function(fname) {
  system(paste("aplay --buffer-time=48000 -N -q", fname), ignore.stdout = TRUE, ignore.stderr=TRUE,wait = FALSE)
  invisible(NULL)
}

play_audio <- function(fname) {
  sfx <- load.wave(fname)
  play(sfx)
}

play_file <- function(fname) {
  if(Sys.info()["sysname"] == "Linux") {
     if(is_wav_fname(fname) && nchar(Sys.which("paplay")) >= 1) {
      play_paplay(fname)
    } else if(is_wav_fname(fname) && nchar(Sys.which("aplay")) >= 1) {
      play_aplay(fname)
    } else if(nchar(Sys.which("vlc")) >= 1) {
      play_vlc(fname)
    } else {
      play_audio(fname)
    }
  } else {
    play_audio(fname)
  }
}