#!/usr/bin/env bash

# we are using env vars defined here:

# https://docs.conda.io/projects/conda-build/en/latest/user-guide/environment-variables.html
# $SP_DIR points to target site_packages location

# Declare a string array with type
# OSX - uncomment below
#declare -a StringArray=("/Users/m/miniconda3/envs/rr/lib/python3.7/site-packages/antimony" "/Users/m/miniconda3/envs/rr/lib/python3.7/site-packages/roadrunner")

export python_version=python3.7

#linux
declare -a StringArray=("/home/m/miniconda3/envs/rr_${python_version}/lib/${python_version}/site-packages/antimony" "/home/m/miniconda3/envs/rr_${python_version}/lib/${python_version}/site-packages/roadrunner")


# Read the array values with space
for val in "${StringArray[@]}"; do
  cp -r $val ${SP_DIR}
done

# setting up links for linux distros - commend for mac
ls -s /home/m/miniconda3/envs/rr_${python_version}/lib/libncurses.so /home/m/miniconda3/envs/rr_${python_version}/lib/${python_version}/site-packages/roadrunner/libncurses.so.5
ls -s /home/m/miniconda3/envs/rr_${python_version}/lib/libtinfo.so /home/m/miniconda3/envs/rr_${python_version}/lib/${python_version}/site-packages/roadrunner/libtinfo.so.5
ls -s /home/m/miniconda3/envs/rr_${python_version}/lib/libform.so /home/m/miniconda3/envs/rr_${python_version}/lib/${python_version}/site-packages/roadrunner/libform.so.5
#cp -R /Users/m/tbb/* "${PREFIX}"
##$PYTHON setup.py install --single-version-externally-managed --record=record.txt
