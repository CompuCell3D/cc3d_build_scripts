
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${SCRIPT_DIR}/miniconda3/bin/activate base

export TWEDIT_PYTHON_APP=${SCRIPT_DIR}/miniconda3/twedit++.app/Contents/MacOS/python

if [ -e ${CC3D_PYTHON_APP} ]
then
    echo "Using app"
    export PYTHON_EXEC_FILE=${TWEDIT_PYTHON_APP}
    export PYTHON_EXEC=${TWEDIT_PYTHON_APP}
else
    echo "Using script"

    export PYTHON_EXEC=python
fi

${PYTHON_EXEC} -m  cc3d.twedit5 $* 