SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('${SCRIPT_DIR}/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${SCRIPT_DIR}/miniconda3/etc/profile.d/conda.sh" ]; then
        . "${SCRIPT_DIR}/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="${SCRIPT_DIR}/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


