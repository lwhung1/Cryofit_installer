# bash configuration file for Gromacs
# First we remove old gromacs stuff from the paths
# by selecting everything else.
# This is not 100% necessary, but very useful when we
# repeatedly switch between gmx versions in a shell.

# First remove gromacs part of ld_library_path
tmppath=""
for i in `echo $LD_LIBRARY_PATH | sed "s/:/ /g"`; do
  if test "$i" != "$GMXLDLIB"; then
    tmppath="${tmppath}${tmppath:+:}${i}"
  fi
done
LD_LIBRARY_PATH=$tmppath

# remove gromacs part of PKG_CONFIG_PATH
tmppath=""
for i in `echo $PKG_CONFIG_PATH | sed "s/:/ /g"`; do
  if test "$i" != "$GMXLDLIB/pkgconfig"; then
    tmppath="${tmppath}${tmppath:+:}${i}"
  fi
done
PKG_CONFIG_PATH=$tmppath

# remove gromacs part of path
tmppath=""
for i in `echo $PATH | sed "s/:/ /g"`; do
  if test "$i" != "$GMXBIN"; then
    tmppath="${tmppath}${tmppath:+:}${i}"
  fi
done
PATH=$tmppath

# and remove the gmx part of manpath
tmppath=""
for i in `echo $MANPATH | sed "s/:/ /g"`; do
  if test "$i" != "$GMXMAN"; then
    tmppath="${tmppath}${tmppath:+:}${i}"
  fi
done
MANPATH=$tmppath

##########################################################
# This is the real configuration part. We save the Gromacs
# things in separate vars, so we can remove them later.
# If you move gromacs, change the next four line.
##########################################################
GMXBIN=GMXROOT/bin
GMXLDLIB=GMXROOT/lib
GMXMAN=GMXROOT/share/man
GMXDATA=GMXROOT/share
	
LD_LIBRARY_PATH=${GMXLDLIB}${LD_LIBRARY_PATH:+:}${LD_LIBRARY_PATH}
PKG_CONFIG_PATH=${GMXLDLIB}/pkgconfig${PKG_CONFIG_PATH:+:}${PKG_CONFIG_PATH}
PATH=${GMXBIN}${PATH:+:}${PATH}
#debian/ubuntu needs a : at the end
MANPATH=${GMXMAN}:${MANPATH}

# export should be separate, so /bin/sh understands it
export GMXBIN GMXLDLIB GMXMAN GMXDATA LD_LIBRARY_PATH PATH MANPATH PKG_CONFIG_PATH

# read bash completions if understand how to use them
# and this shell supports extended globbing
if (complete) > /dev/null 2>&1; then
  if (shopt -s extglob) > /dev/null 2>&1; then
    if [ -f $GMXBIN/completion.bash ]; then
      source $GMXBIN/completion.bash; 
    fi
  fi
fi


