\name{ping}
\alias{ping}
\title{Play a short sound}
\usage{
ping(sound = "ping", expr = NULL)
}
\arguments{
  \item{sound}{character string or number of specifying
  what sound to be played. The default is \code{"ping"}.
  Possible sounds are: \enumerate{ \item \code{"ping"}
  \item \code{"coin"} \item \code{"fanfare"} \item
  \code{"complete"} \item \code{"treasure"} \item
  \code{"ready"} \item \code{"shotgun"} \item
  \code{"mario"} \item \code{"wilhelm"} } Any string or
  number not matching the above sounds will reslut in a
  random sound being played.}

  \item{expr}{An optional expression to be excecuted before
  the sound.}
}
\description{
\code{ping} plays a short sound which is useful if you want
to get notified, for example, when a script has finished.
As an added bonus there are a number of different sounds to
choose from.
}
\examples{
cat("Countdown: ")
for(i in 10:0) {
  Sys.sleep(0.5)
  cat(i, " ")
}
ping()

# Play a random sound
ping(0)
}

