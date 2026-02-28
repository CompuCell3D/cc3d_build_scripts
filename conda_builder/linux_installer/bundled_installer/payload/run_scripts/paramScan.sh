
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

conda_dir=${SCRIPT_DIR}/miniforge3
source ${conda_dir}/bin/activate cc3d_env

export exit_code=0
python -m cc3d.core.param_scan.parameter_scan_run $* 
exit_code=$?

cd ${SCRIPT_DIR}
exit ${exit_code}