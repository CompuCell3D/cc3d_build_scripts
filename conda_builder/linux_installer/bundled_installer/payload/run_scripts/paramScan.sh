
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

conda_dir=${SCRIPT_DIR}/miniforge3
source ${conda_dir}/bin/activate cc3d_env
export PYTHON_EXEC=${conda_dir}/envs/cc3d_env/bin/python

export exit_code=0
${PYTHON_EXEC} -m cc3d.core.param_scan.parameter_scan_run $*
exit_code=$?

cd ${SCRIPT_DIR}
exit ${exit_code}