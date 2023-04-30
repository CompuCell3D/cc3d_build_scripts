
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"


export PYTHON_EXEC=/home/m/miniconda3/envs/cc3d_linux_manual_37/bin/python
export PYTHONPATH=/home/m/miniconda3/envs/cc3d_linux_manual_37/lib/python3.7/site-packages
export LD_LIBRARY_PATH=/home/m/miniconda3/envs/cc3d_linux_manual_37/lib:$LD_LIBRARY_PATH

export exit_code=0
${PYTHON_EXEC} -m cc3d.run_script $* --current-dir=${SCRIPT_DIR}
exit_code=$?

cd ${SCRIPT_DIR}
exit ${exit_code}