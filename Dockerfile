FROM fedora:latest as builder
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
RUN --mount=type=cache,target=/ccache/

# # bool BUILD64BIT
# # # Build 64bit wine or not. Defaults to true.
ARG BUILD64BIT
# Prepare environment with tools/deps
COPY bootstrap.sh ./.
RUN ./bootstrap.sh

# # git:// WINE_GIT
# # # Wine repository url 
ARG WINE_GIT
# # tags/TAG||BRANCH WINE_TAG
# # # Wine branch or tag to checkout to. Tags must be prefixed by "tags/"
ARG WINE_TAG
# Clone wine source
COPY wine-source.sh ./.
RUN ./wine-source.sh

# # https://example.com/wine-staging.git STAGING_GIT
# # # Wine-STAGING repository url 
ARG STAGING_GIT
# # tags/TAG||BRANCH STAGING_TAG
# # # Wine-STAGING branch or tag to checkout to. Tags must be prefixed by "tags/"
ARG STAGING_TAG
# # "-W patchsetName -W otherpatchssetName" PATCH_EXCLUDES
# # # Staging patchsets that should be excluded. Each patchset requires -W to prefix it.
# # # You can find the patchset names here https://github.com/wine-staging/wine-staging/blob/master/patches/patchinstall.sh
ARG PATCH_EXCLUDES
# Apply wine staging patches
COPY staging-patches.sh ./.
RUN ./staging-patches.sh

# Apply league specific patches
COPY league-patches.sh ./.
COPY patches/. /builddir/patches/
RUN ./league-patches.sh

# # int THREADS
# # # How many threads make will use to compile. Defaults to all available.
ARG THREADS
# Build wine
COPY build.sh ./.
RUN ./build.sh

# Copy to one folder
RUN mkdir -p /builddir/build && cp -r /builddir/out32 /builddir/build/. && cp -r /builddir/out64 /builddir/build/. && cp -r /builddir/wine /builddir/build/. 
# Copy our builds to the export folder
CMD cp -r /builddir/build/* /exports/. && chmod -R 777 /exports

# If you switch to experimental mode like in this answer, you actually get a working ccache https://stackoverflow.com/a/56833198
# building this WILL take a while
# build commands: 
#   # docker build . -t wiryfuture/wine-league --build-arg WINE_TAG=tags/wine-6.16 --build-arg STAGING_TAG=tags/v6.16
#   # buildah bud --build-arg WINE_TAG=tags/wine-6.16 --build-arg STAGING_TAG=tags/v6.16 -t wiryfuture/wine-league .
# final command: docker run -v /folder/for/wine:/exports wiryfuture/wine-league