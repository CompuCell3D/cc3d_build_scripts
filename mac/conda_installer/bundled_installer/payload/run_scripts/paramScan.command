
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${SCRIPT_DIR}/miniconda3/bin/activate base

export exit_code=0
python -m cc3d.core.param_scan.parameter_scan_run $* 
exit_code=$?

cd ${SCRIPT_DIR}
exit ${exit_code}