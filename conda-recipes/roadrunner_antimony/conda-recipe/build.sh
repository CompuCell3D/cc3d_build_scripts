#!/usr/bin/env bash

# we are using env vars defined here:

# https://docs.conda.io/projects/conda-build/en/latest/user-guide/environment-variables.html
# $SP_DIR points to target site_packages location

# Declare a string array with type
# OSX - uncomment below
declare -a StringArray=("/Users/m/miniconda3/envs/rr/lib/python3.7/site-packages/antimony" "/Users/m/miniconda3/envs/rr/lib/python3.7/site-packages/roadrunner")

#linux
#declare -a StringArray=("/home/m/miniconda3/envs/rr/lib/python3.7/site-packages/antimony" "/home/m/miniconda3/envs/rr/lib/python3.7/site-packages/roadrunner")


# Read the array values with space
for val in "${StringArray[@]}"; do
  cp -r $val ${SP_DIR}
done

#cp -R /Users/m/tbb/* "${PREFIX}"
##$PYTHON setup.py install --single-version-externally-managed --record=record.txt
