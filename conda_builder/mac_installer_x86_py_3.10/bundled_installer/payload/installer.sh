#

COMPUCELL3D_PKG=compucell3d
INSTALLATION_DIR=$HOME/CompuCell3D
VERSION=''

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
  echo "./installer.sh  (in this case latest version will be installed in the default install dir \$HOME/CC3D)"
  echo "./installer.sh -i /Users/m/CompuCell3D (in this case the latest version of CC3D will be installed)"
  echo "./installer.sh -i /Users/m/CompuCell3D -v 4.4.1"
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
${SCRIPT_DIR}/Miniconda3-py310_23.3.1-0-MacOSX-x86_64.sh -s -b -p ${INSTALLATION_DIR}/miniconda3 | tee ${INSTALLATION_DIR}/install.log 2>&1

source ${INSTALLATION_DIR}/miniconda3/bin/activate base

# copying compucell3d.app and twedit++.app

cp -R ${SCRIPT_DIR}/compucell3d.app ${INSTALLATION_DIR}/miniconda3
cp -R ${SCRIPT_DIR}/twedit++.app ${INSTALLATION_DIR}/miniconda3

cp ${SCRIPT_DIR}/run_scripts/* ${INSTALLATION_DIR}

which python

echo "Installing mamba package"
conda install -y -c conda-forge mamba
echo "Installing CompuCell3D package"
mamba install -y -c compucell3d -c conda-forge ${COMPUCELL3D_PKG} | tee -a ${INSTALLATION_DIR}/install.log 2>&1

# installing roadrunner and antimony directly using pip. Turns out that on older Macs there are issues with the SDK that
# was linked to antimony when we built cc3d-networks-solver. THe SDK was newer than the one that is found on older Macs
pip install antimony==2.13.2 | tee -a ${INSTALLATION_DIR}/install.log 2>&1
pip install libroadrunner==2.3.1 | tee -a ${INSTALLATION_DIR}/install.log 2>&1

# copying demos
echo "Installing Demos"
cp ${SCRIPT_DIR}/Demos.zip ${INSTALLATION_DIR}

unzip ${INSTALLATION_DIR}/Demos.zip -d ${INSTALLATION_DIR}  > ${INSTALLATION_DIR}/install.log 2>&1
rm ${INSTALLATION_DIR}/Demos.zip