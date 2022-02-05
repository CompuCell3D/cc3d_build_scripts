
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${SCRIPT_DIR}/miniconda3/bin/activate base

export PYTHON_EXEC=${SCRIPT_DIR}/miniconda3/bin/python

${PYTHON_EXEC} -m  cc3d.twedit5 $* 