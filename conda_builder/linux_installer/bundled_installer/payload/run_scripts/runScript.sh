
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

conda_dir=${SCRIPT_DIR}/miniforge3
source ${conda_dir}/bin/activate cc3d_env


export exit_code=0
python -m cc3d.run_script $* --current-dir=${SCRIPT_DIR}
exit_code=$?

cd ${SCRIPT_DIR}
exit ${exit_code}