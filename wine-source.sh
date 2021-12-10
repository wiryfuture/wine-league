#!/bin/bash
####################################
# DESC
####################################
# Clone wine source git repo

####################################
# PARAMS
####################################
# git:// WINE_GIT
#   # Url of wine git repo. Defaults to winehq master.
WINE_GIT=${WINE_GIT:="git://source.winehq.org/git/wine"}
# tags/TAG||BRANCH WINE_TAG
#   # Tag or branch from the wine repo. Defaults to default branch (actually uses string 'notag')
WINE_TAG=${WINE_TAG:="notag"}

####################################
# et al
####################################
# Clone repo
git clone "$WINE_GIT" /builddir/wine/.
# Checkout if wine_tag assigned
if [ "$WINE_TAG" != "notag" ] ; then
    cd /builddir/wine && git checkout "$WINE_TAG"
fi