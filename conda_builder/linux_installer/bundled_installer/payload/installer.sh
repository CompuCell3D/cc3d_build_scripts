#

COMPUCELL3D_PKG=compucell3d
INSTALLATION_DIR=$HOME/CompuCell3D
VERSION=''
MINICONDA_INSTALLER=Miniforge3-26.1.0-0-Linux-x86_64.sh
conda_dir_name=miniforge3

function print_usage {
  echo
  echo "installer.sh: "
  echo
  echo "Options:"
  echo
  echo "[-i] installation_dir  [-v] version  [-h] help"
  echo
  echo "Examples:"
  echo "========"
  echo
  echo "./installer.sh  (in this case latest version will be installed in the default install dir \$HOME/CompuCell3D)"
  echo "./installer.sh -i /home/m/CompuCell3D (in this case the latest version of CC3D will be installed)"
  echo "./installer.sh -i /home/m/m/CompuCell3D -v 4.8.0"
  echo "./installer.sh -h (print_usage)"
}

while getopts i:v:h option
do
    case "${option}"
        in
        i)INSTALLATION_DIR=${OPTARG};;
        v)VERSION=${OPTARG};;
        h)print_usage;;
        \? )print_usage;;
    esac
done

echo "INSTALLATION_DIR : $INSTALLATION_DIR"
echo "VERSION   : $VERSION"

if test -z "$VERSION"
then
      COMPUCELL3D_PKG=compucell3d
else
      COMPUCELL3D_PKG="${COMPUCELL3D_PKG}=${VERSION}"
fi

echo "Installing ${COMPUCELL3D_PKG}"

# get current script dir
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

mkdir -p ${INSTALLATION_DIR}
echo "INSTALLING Miniconda 3"
${SCRIPT_DIR}/${MINICONDA_INSTALLER} -s -b -p ${INSTALLATION_DIR}/${conda_dir_name} |tee ${INSTALLATION_DIR}/install.log 2>&1

source ${INSTALLATION_DIR}/${conda_dir_name}/bin/activate base

cp ${SCRIPT_DIR}/run_scripts/* ${INSTALLATION_DIR}

CONDA_ROOT="${INSTALLATION_DIR}/${conda_dir_name}"
MAMBA_BINARY=${CONDA_ROOT}/bin/mamba
ENV_PREFIX="${CONDA_ROOT}/envs/cc3d_env"
# forcing separate package repository
export CONDA_PKGS_DIRS="${CONDA_ROOT}/pkgs"

which python

echo "Installing CompuCell3D conda package into cc3d_env conda environment"
${MAMBA_BINARY} create -y -p ${ENV_PREFIX} python=3.12 -c conda-forge
${MAMBA_BINARY} install -y -p ${ENV_PREFIX} -c compucell3d -c conda-forge ${COMPUCELL3D_PKG}| tee -a ${INSTALLATION_DIR}/install.log 2>&1


# copying demos
echo "Installing Demos"
cp ${SCRIPT_DIR}/Demos.zip ${INSTALLATION_DIR}

unzip ${INSTALLATION_DIR}/Demos.zip -d ${INSTALLATION_DIR} | tee -a ${INSTALLATION_DIR}/install.log 2>&1
rm ${INSTALLATION_DIR}/Demos.zip

# removing bulky conda packages that were pulled during installation process
${MAMBA_BINARY} clean --all --yes