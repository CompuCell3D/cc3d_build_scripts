

COMPUCELL3D_PKG=compucell3d

if [ -z "$1" ]; then
  INSTALLATION_DIR=$HOME/CC3D
  echo "Will use default location for installation of CC3D: ${INSTALLATION_DIR}"

else
  INSTALLATION_DIR=$1
  echo "Installation directory : $1"
fi

if [ -z "$2" ]; then
  echo "Will use default (latest) version of CC3D"
else
  VERSION=$2
  COMPUCELL3D_PKG="${COMPUCELL3D_PKG}=${VERSION}"
  echo "Installation directory : $1"
fi

echo "Installing ${COMPUCELL3D_PKG}"

# get current script dir
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

echo "INSTALLING Miniconda 3"
${SCRIPT_DIR}/Miniconda3-py37_4.10.3-MacOSX-x86_64.sh -s -b -p ${INSTALLATION_DIR}/miniconda3

source ${INSTALLATION_DIR}/miniconda3/bin/activate base

# copying compucell3d.app and twedit++.app

cp -R ${SCRIPT_DIR}/compucell3d.app ${INSTALLATION_DIR}/miniconda3
cp -R ${SCRIPT_DIR}/twedit++.app ${INSTALLATION_DIR}/miniconda3

cp ${SCRIPT_DIR}/run_scripts/* ${INSTALLATION_DIR}

which python

echo "Installing CompuCell3D conda package"
conda install -y -c compucell3d -c conda-forge ${COMPUCELL3D_PKG}

# copying demos
echo "Installing Demos"
cp ${SCRIPT_DIR}/Demos.zip ${INSTALLATION_DIR}

unzip ${INSTALLATION_DIR}/Demos.zip -d ${INSTALLATION_DIR}
rm ${INSTALLATION_DIR}/Demos.zip