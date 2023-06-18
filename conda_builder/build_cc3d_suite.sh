# if needed you may redirect all to the file and still display everything on the screen using this command invocation:
# ./build_cc3d_suite.sh 2>&1 | tee >(cat >&2) > build_cc3d_suite_output.txt

repo_prefix=/home/m/src/conda-build-repos
if [ "$(uname)" == "Darwin" ]; then
  repo_prefix=/Users/m/src/conda-build-repos
fi

if [ $# -eq 0 ]; then
    # If not, assign a default value
    PYTHON_VERSION=3.7
else
    # If yes, use the passed value
    PYTHON_VERSION="$1"
fi


cc3d_repo_dir=${repo_prefix}/CompuCell3D/
player_repo_dir=${repo_prefix}/cc3d-player5/
twedit_repo_dir=${repo_prefix}/cc3d-twedit5/
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# SCRIPT_DIR=$(dirname "$0")

echo "${SCRIPT_DIR}"

function build_conda_package () {
  local conda_recipe_dir=$1
  local py_version=$2
  cd "${conda_recipe_dir}" || exit
  mv versions.yaml versions.yaml.bak
  cp  "${SCRIPT_DIR}/versions.yaml" versions.yaml
  ./run_conda_build.sh "${py_version}"
  mv versions.yaml.bak versions.yaml
}


build_conda_package "${cc3d_repo_dir}/conda-recipes" "${PYTHON_VERSION}"
build_conda_package "${player_repo_dir}/conda-recipes" "${PYTHON_VERSION}"
build_conda_package "${twedit_repo_dir}/conda-recipes" "${PYTHON_VERSION}"
build_conda_package "${cc3d_repo_dir}/conda-recipes-compucell3d" "${PYTHON_VERSION}"
