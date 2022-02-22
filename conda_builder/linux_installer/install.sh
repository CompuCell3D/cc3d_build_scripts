function printUsage() {
  echo -e "\033[1mUsage:\033[0m"
  echo "$0 [INSTALLATION_DIR] "
  echo
  echo -e "\033[1mOptions:\033[0m"
  echo "  -h (--help)"

}

#Argument validation
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  printUsage
  exit 1
fi
if [ -z "$1" ]; then
  echo "Please enter installation directory"
  echo
  printUsage
  exit 1
else
  echo "Installation directory : $1"
fi

INSTALLATION_DIR=$1

echo "Will install CC3D in ${INSTALLATION_DIR}"
# get current script dir
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
# install miniconda
${SCRIPT_DIR}/Miniconda3-py37_4.10.3-MacOSX-x86_64.sh -s -b -p ${SCRIPT_DIR}/miniconda3
#activate conda base environment
source ${SCRIPT_DIR}/miniconda3/bin/activate base

which python
# install cc3d
conda install -y -c compucell3d -c conda-forge compucell3d=4.3.0

#$SCRIPT_DIR/Miniconda3-py37_4.10.3-MacOSX-x86_64.sh -s -b -p $HOME/CC3D-4.3.0/miniconda3
#source $SCRIPT_DIR/conda_init.sh
#conda install -y -c compucell3d -c conda-forge compucell3d=4.3.0
