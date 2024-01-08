# st version
VERSION = 0.9

# Customize below to fit your system

# paths
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

PKG_CONFIG = pkg-config

# includes and libs
INCS = -I$(X11INC) \
       `$(PKG_CONFIG) --cflags fontconfig` \
       `$(PKG_CONFIG) --cflags freetype2`
LIBS = -L$(X11LIB) -lm -lrt -lX11 -lutil -lXft \
       `$(PKG_CONFIG) --libs fontconfig` \
       `$(PKG_CONFIG) --libs freetype2`

# flags
STCPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600
STCFLAGS = $(INCS) $(STCPPFLAGS) $(CPPFLAGS) $(CFLAGS)
STLDFLAGS = $(LIBS) $(LDFLAGS)

X64SUPPORT = -march=x86-64 -mtune=generic
SELFFLAGS  = -march=native -mtune=native
STRIPFLAGS = -Wl,--strip-all -s
DEBUGFLAGS = -ggdb -g -pg 
WARNINGFLAGS = -pedantic -Wall -Wextra -Wno-deprecated-declarations -Wshadow -Wmaybe-uninitialized 
SIZEFLAGS  = -ffunction-sections -fdata-sections -finline-functions

CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_POSIX_C_SOURCE=200809L -DVERSION=\"${VERSION}\" ${XINERAMAFLAGS}
cFLAGS   = -std=c99 ${WARNINGFLAGS} ${INCS} ${CPPFLAGS} ${X64SUPPORT} 
#-flto saves a couple instructions in certain functions; 
RELEASEFLAGS = ${cFLAGS} ${STRIPFLAGS} -flto

DEBUG 	= ${cFLAGS} ${DEBUGFLAGS} -O0
SIZE  	= ${RELEASEFLAGS} -Os
SIZEONLY= ${RELEASEFLAGS} ${SIZEFLAGS} -Oz

#Release Stable (-O2)
RELEASE = ${RELEASEFLAGS} -ftree-vectorize -O2
#Release Speed (-O3)
RELEASES= ${RELEASEFLAGS} -O3

#Build using cpu specific instruction set for more performance (Optional)
BUILDSELF = ${RELEASEFLAGS} ${SELFFLAGS} -O2

#Set your options or presets (see above) ex: ${PRESETNAME}
CFLAGS = ${BUILDSELF}

# Solaris
#CFLAGS  = -fast ${INCS} -DVERSION=\"${VERSION}\"

LDFLAGS  = ${LIBS}

# OpenBSD:
#CPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600 -D_BSD_SOURCE
#LIBS = -L$(X11LIB) -lm -lX11 -lutil -lXft \
#       `$(PKG_CONFIG) --libs fontconfig` \
#       `$(PKG_CONFIG) --libs freetype2`
#MANPREFIX = ${PREFIX}/man

# compiler and linker
CC = c99
