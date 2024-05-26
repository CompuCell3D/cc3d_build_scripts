#!/usr/bin/env bash

export py_version="3.10"

# we are using env vars defined here:

# https://docs.conda.io/projects/conda-build/en/latest/user-guide/environment-variables.html
# $SP_DIR points to target site_packages location

# Declare a string array with type
# OSX x86 - uncomment below
declare -a StringArray=("/Users/m/miniconda3/envs/rr_python${py_version}/lib/python${py_version}/site-packages/antimony" "/Users/m/miniconda3/envs/rr_python${py_version}/lib/python${py_version}/site-packages/roadrunner")
#config_yaml=conda_build_config_x86.yaml

## OSX ARM64- uncomment below
#declare -a StringArray=("/Users/m/miniconda3_arm64/envs/rr_python${py_version}/lib/python${py_version}/site-packages/antimony" "/Users/m/miniconda3_arm64/envs/rr_python${py_version}/lib/python${py_version}/site-packages/roadrunner")
#config_yaml=conda_build_config_arm64.yaml

#linux
#declare -a StringArray=("/home/m/miniconda3/envs/rr_python_${py_version}/lib/python${py_version}/site-packages/antimony" "/home/m/miniconda3/envs/rr_python_${py_version}/lib/python${py_version}/site-packages/roadrunner")


# Read the array values with space
for val in "${StringArray[@]}"; do
  cp -r $val ${SP_DIR}
done

#cp -R /Users/m/tbb/* "${PREFIX}"
##$PYTHON setup.py install --single-version-externally-managed --record=record.txt
