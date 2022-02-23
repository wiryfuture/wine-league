#!/bin/bash
# Get wine source
scripts/buildme/wine-source.sh
# Apply staging patches
scripts/buildme/staging-patches.sh
# Apply league specific patches
scripts/buildme/league-patches.sh
# Build wine and create packages
scripts/buildme/build.sh
