FROM fedora:latest as bootstrap
####################################
# Desc
####################################
# Fedora container for building WINE using league patches. Should be easy to Modify.

####################################
# ENVs
####################################
# ccache
# # PATH CCACHE_DIR
# # # Directory of ccache cache
ENV CCACHE_DIR=/ccache

####################################
# et al
####################################
WORKDIR /builddir
COPY scripts/bootstrap.sh scripts/.
#RUN --mount=type=cache,target=/ccache/

# Prepare environment with tools/deps
RUN scripts/bootstrap.sh

COPY scripts/execute.sh scripts/.
COPY scripts/buildme scripts/buildme
COPY patches/. /builddir/patches/
RUN chmod -R +x scripts/* scripts/*/*

# # git:// WINE_GIT
# # # Wine repository url
# ARG WINE_GIT
# # tags/TAG||BRANCH WINE_TAG
# # # Wine branch or tag to checkout to. Tags must be prefixed by "tags/"
# ARG WINE_TAG

# # https://example.com/wine-staging.git STAGING_GIT
# # # Wine-STAGING repository url
# ARG STAGING_GIT
# # tags/TAG||BRANCH STAGING_TAG
# # # Wine-STAGING branch or tag to checkout to. Tags must be prefixed by "tags/"
# ARG STAGING_TAG
# # "-W patchsetName -W otherpatchssetName" PATCH_EXCLUDES
# # # Staging patchsets that should be excluded. Each patchset requires -W to prefix it.
# # # You can find the patchset names here https://github.com/wine-staging/wine-staging/blob/master/patches/patchinstall.sh
# ARG PATCH_EXCLUDES

# # int THREADS
# # # How many threads make will use to compile. Defaults to all available.
# ARG THREADS
# # STRING PKGTYPE
# # # What packages do we want? Defaults to R for RPM
# # # Can have "-D" for Debian, "-R" for RPM and "-S" for slackware (who uses that again?)
# ARG PKGTYPE

#  Run build scripts
CMD scripts/execute.sh && chmod -R 777 /exports

# Building this WILL take a while
# If you mount a dir at /ccache, you will benefit from build caching
# mount dir at /exports to get your packages
# remember, container needs perms for both these dirs
#
# build commands:
#   # docker build . -t wiryfuture/wine-league
#   # buildah bud --layers=true -t wiryfuture/wine-league .
# final command:
#   # docker run -v /folder/for/wine:/exports --env WINE_TAG=tags/wine-7.0 --env STAGING_TAG=tags/v7.0 wiryfuture/wine-league
#   # podman run -v /folder/for/wine:/exports --env WINE_TAG=tags/wine-7.0 --env STAGING_TAG=tags/v7.0 localhost/wiryfuture/wine-league
#
#   # podman run -v /folder/for/wine:/exports -v /folder/for/ccache:/ccache --env WINE_TAG=tags/wine-7.0 --env STAGING_TAG=tags/v7.0 localhost/wiryfuture/wine-league
#
# Effective debugging command
# WINEPREFIX=~/Games/league-of-legends WINEARCH=win32 WINEDEBUG=warn+all,+server ./wine "/home/philip/Games/league-of-legends/drive_c/Riot Games/Riot Client/RiotClientServices.exe"  --launch-patchline=live --launch-product=league_of_legends
