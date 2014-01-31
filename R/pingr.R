#'Play a short sound
#'
#'\code{ping} plays a short sound which is useful if you want to get notified, 
#'for example, when a script has finished. As an added bonus there are a number 
#'of different sounds to choose from.
#'
#'
#'@param sound character string or number specifying what sound to be played.
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
#' } Any string or number not matching the above sounds will reslut in a random
#' sound being played.
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
#' #Play a fanfare instead of a ping.
#' ping("fanfare")
#' #or
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
  sound_fname <- sounds[sound]
  if(is.na(sound_fname) || length(sound_fname) != 1) {
    sound_fname <- sample(sounds, size=1)
  }
  sound_path <- system.file(paste("sounds/", sound_fname, sep=""), package="pingr")
  play_file(sound_path)
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
    if(nchar(Sys.which("vlc")) >= 1) {
      play_vlc(fname)
    } else if(nchar(Sys.which("paplay")) >= 1) {
      play_paplay(fname)
    } else if(nchar(Sys.which("aplay")) >= 1) {
      play_aplay(fname)
    } else {
      play_audio(fname)
    }
  } else {
    play_audio(fname)
  }
}


# play_vlc_pid <- function(fname) {
#   system(paste("vlc -Idummy --play-and-exit", fname), 
#          ignore.stdout = TRUE, ignore.stderr=TRUE,wait = FALSE)
#   ps_out <- system("ps -eo pid,comm,etime| grep vlc", intern=TRUE)
#   
#   # Find the pid
#   pid_df <- read.table(textConnection(paste(ps_out, collapse="\n")), header=FALSE, 
#                        stringsAsFactors=FALSE, col.names= c("pid", "command", "time"))
#   vlc_pid <- pid_df$pid[ # Find the pid that is connected to a vlc
#     str_detect(pid_df$time, "00:0\\d") & # that is less that 10 seconds old and
#       which.min(as.numeric(str_extract(pid_df$time, "[0-9]+$"))) # youngest old.
#     ]
#   vlc_pid
# }