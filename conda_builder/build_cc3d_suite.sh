
cc3d_repo_dir=/home/m/src/conda-build-repos/CompuCell3D/
player_repo_dir=/home/m/src/conda-build-repos/cc3d-player5/
twedit_repo_dir=/home/m/src/conda-build-repos/cc3d-twedit5/
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# SCRIPT_DIR=$(dirname "$0")

echo "${SCRIPT_DIR}"


function build_conda_package () {
  local conda_recipe_dir=$1

  cd "${conda_recipe_dir}" || exit
  mv versions.yaml versions.yaml.bak
  cp  "${SCRIPT_DIR}/versions.yaml" versions.yaml
  ./run_conda_build.sh
  mv versions.yaml.bak versions.yaml
}


build_conda_package "${cc3d_repo_dir}/conda-recipes"
build_conda_package "${player_repo_dir}/conda-recipes"
build_conda_package "${twedit_repo_dir}/conda-recipes"
build_conda_package "${cc3d_repo_dir}/conda-recipes-compucell3d"
