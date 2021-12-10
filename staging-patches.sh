#!/bin/bash
####################################
# DESC
####################################
# Clone wine-staging git repo and apply patches

####################################
# PARAMS
####################################
# https://example.com/wine-staging.git STAGING_GIT
#   # Url of wine git repo. Defaults to winehq master.
STAGING_GIT=${STAGING_GIT:="https://github.com/wine-staging/wine-staging.git"}
# tags/TAG||BRANCH WINE_TAG
#   # Tag or branch from the wine repo. Defaults to default branch (actually uses string 'notag')
STAGING_TAG=${STAGING_TAG:="notag"}
# -W patchsetName PATCH_EXCLUDES
#   # Staging patchsets that should be excluded. Each patchset requires -W to prefix it.
PATCH_EXCLUDES=${PATCH_EXCLUDES:-""}

####################################
# et al
####################################
# Clone repo
git clone "$STAGING_GIT" /builddir/wine-staging/.
# Checkout if wine_tag assigned
if [ "$STAGING_TAG" != "notag" ] ; then
    cd /builddir/wine-staging && git checkout "$STAGING_TAG"
fi

# Preparation? 
cd /builddir/wine && git reset --hard HEAD && git clean -xdf
cd /builddir/wine-staging && git reset --hard HEAD && git clean -xdf

command="/builddir/wine-staging/patches/patchinstall.sh DESTDIR=/builddir/wine --all ""$PATCH_EXCLUDES"
( ( $command ) )