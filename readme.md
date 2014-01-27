`pingr`: The Package that Sounds as it is Called.
========================================================

`pingr` is an R package that contains one function, `ping()`, with one purpose: To go *ping* on whatever platform you are on. Is intended to be useful, for example, if you are running a long analysis in the background and want to know when it is ready. Also useful if you want to irritate colleagues.

Installation
---------------

Grab Hadley Wickham's `devtools` and install `pingr` directly from github by entering this into an R console:

```
install.packages("devtools")
library(devtools)
install_github("pingr", "rasmusab")
```

If you're on Linux `pingr` relies on you having the [vlc media player](http://www.videolan.org/vlc/index.html) installed and on the PATH. If you are on Debian/Ubuntu you can get vlc by running the following in a terminal:

```
sudo apt-get install vlc
```

Details
------------

`ping()` plays a short sound which is useful if you want to get notified, for example, when a script has finished. As an added bonus there are a number of different sounds to choose from.

### Usage

`ping(sound = 1, expr = NULL)`

### Arguments

`sound`  character string or number specifying what sound to be played. The default is 1. Possible sounds are:

1. "ping"
2. "coin"
3. "fanfare"
4. "complete"
5. "treasure"
6. "ready"
7. "shotgun"
8. "mario"
9. "wilhelm"

Any string or number not matching the above sounds will result in a random sound being played.

`expr`	An optional expression to be executed before the sound.

###Examples

```
# Update all packages and ping when it's ready
update.packages(ask=FALSE); ping()

#Play a fanfare instead of a ping.
ping("fanfare")
#or
ping(3)

# Play a random sound
ping(0)
```