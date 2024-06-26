import sys
import os
from pathlib import Path
import subprocess


def find_current_conda_env(conda_exec):
    if conda_exec is None:
        return None

    envs = subprocess.check_output(f'{conda_exec} env list', shell=True).splitlines()
    active_env = list(filter(lambda s: '*' in str(s), envs))[0]
    env_name = active_env.decode("utf-8") .split()[0]
    return env_name


def find_conda():
    conda_exec = None
    python_exec = Path(sys.executable)
    python_exec_dir = python_exec.parent
    print('python_exec_dir=', python_exec_dir)

    if sys.platform.startswith('darwin') or sys.platform.startswith('linux'):

        conda_exec_candidates = [
            # if using other env
            Path().joinpath(*python_exec_dir.parts[:-3]).joinpath('bin', 'conda'),
            # if using python.app or similar from env
            Path().joinpath(*python_exec_dir.parts[:-5]).joinpath('bin', 'conda'),
            # if using base conda env
            python_exec_dir.joinpath('conda'),
        ]

        for candidate in conda_exec_candidates:
            if candidate.exists() and os.access(str(candidate), os.X_OK):
                conda_exec = candidate
                break

        print('conda_exec=', conda_exec)
        os.system(str(conda_exec))
    elif sys.platform.startswith('win'):

        conda_exec_candidates = [
            # if using other env
            Path().joinpath(*python_exec_dir.parts[:-2]).joinpath('condabin', 'conda.bat'),
            # if using python.app or similar from env

            # if using base conda env
            python_exec_dir.joinpath('condabin', 'conda.bat'),
        ]

        for candidate in conda_exec_candidates:
            if candidate.exists():
                conda_exec = candidate
                break

    return conda_exec


if __name__ == '__main__':
    conda_exec = find_conda()
    conda_env_name = find_current_conda_env(conda_exec=conda_exec)
    print ('conda_env_name=', str(conda_env_name))

    # if sys.platform.startswith('darwin') or sys.platform.startswith('linux'):
    #     python_exec = Path(sys.executable)
    #     python_exec_dir = python_exec.parent
    #     print('python_exec_dir=', python_exec_dir)
    #     conda_exec_candidates = [
    #         Path().joinpath(*python_exec_dir.parts[:-3]).joinpath('bin', 'conda'),
    #         Path().joinpath(*python_exec_dir.parts[:-5]).joinpath('bin', 'conda'),
    #         # python_exec_dir.parent.parent.parent.joinpath('bin', 'conda'),   # if using other conda env
    #         python_exec_dir.joinpath('conda'),  # if using base conda env
    #     ]
    #     conda_exec = None
    #     for candidate in conda_exec_candidates:
    #         if candidate.exists() and os.access(str(candidate), os.X_OK):
    #             conda_exec = candidate
    #             break
    #     print('conda_exec=', conda_exec)
    #     os.system(str(conda_exec))