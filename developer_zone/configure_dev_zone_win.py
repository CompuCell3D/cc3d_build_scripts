# https://stackoverflow.com/questions/35071192/how-to-find-out-where-the-python-include-directory-is

import sys
import os
from pathlib import Path
import subprocess
import argparse
# import cc3d
from sysconfig import get_paths
import sysconfig
import site
from pprint import pprint


def main():
    print

    conda_exec = find_conda()
    print('conda_exec=', conda_exec)
    conda_env_name = find_current_conda_env(conda_exec=conda_exec)
    print('conda_env_name=', conda_env_name)
    conda_exec = Path(conda_exec)
    conda_shell_script = conda_exec.parent.parent.joinpath('etc', 'profile.d', 'conda.sh')
    activate_script = conda_exec.parent.joinpath('activate.bat')

    compucell3d_git_dir = Path('d:/CC3D_PY3_GIT')

    py_version_nodot = sysconfig.get_config_var('py_version_nodot')
    paths_dict = sysconfig.get_paths()
    stdlib = Path(paths_dict['stdlib'])
    bin_dir = stdlib.parent.joinpath('Library', 'bin')
    ld_library = stdlib.parent.joinpath('libs',f'python{py_version_nodot}.lib')

    result = subprocess.run(f"{activate_script} {conda_env_name} & where %CXX%", stdout=subprocess.PIPE)
    print(result.stdout.decode('utf-8'))

    sysconfig.get_config_var('LDLIBRARY')

    print(sysconfig.get_paths())


    developer_zone_source = compucell3d_git_dir.joinpath('CompuCell3D', 'DeveloperZone')
    compucell3d_full_source_path = compucell3d_git_dir.joinpath('CompuCell3D', 'core', 'CompuCell3D')



    stem_build_dir = compucell3d_git_dir.stem + '_developer_zone_build_test'
    stem_install_dir = compucell3d_git_dir.stem + '_developer_zone_install'
    build_dir = compucell3d_git_dir.parent.joinpath(stem_build_dir)
    build_dir.mkdir(exist_ok=True, parents=True)
    # install_dir = compucell3d_git_dir.parent.joinpath(stem_install_dir)





    # print(sysconfig.get_config_var('LDLIBRARY'))
    # print(sysconfig.get_config_var('LIBDIR'))
    # ld_library = Path(sysconfig.get_config_var('LDLIBRARY'))
    # lib_dir = Path(sysconfig.get_config_var('LIBDIR'))
    site_packages_dir = Path(paths_dict['platlib'])
    # ld_library_abs_path = lib_dir.joinpath(ld_library)
    # python_exec = sys.executable
    install_dir = site_packages_dir

    python_include_dir = paths_dict['include']


#-march=core2 -mtune=haswell -mssse3 -ftree-vectorize -fPIC -fPIE -fstack-protector-strong -O2 -pipe -stdlib=libc++ -fvisibility-inlines-hidden -std=c++14 -fmessage-length=0 -isystem /Users/m/miniconda3/envs/clang/include  -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermis


 #  -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64   -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64


    # py_include_dir= Path(sysconfig.get_config_var('INCLUDEPY'))
    # bin_dir = Path(sysconfig.get_config_var('BINDIR'))

    cmake_exec = bin_dir.joinpath('cmake.exe')

    # cmake_c_compiler = bin_dir.joinpath('clang')
    # cmake_cxx_compiler = bin_dir.joinpath('clang++')
    # swig_exec = bin_dir.joinpath('swig')

    cmake_generator_name = 'NMake Makefiles'
    print("TESTING WHICH")
    # os.system('which python')
    # os.system('which conda')

    # cmd_test = f'{cmake_exec} ' \
    #            '-DCMAKE_CXX_COMPILER:STRING=/Users/m/miniconda3/envs/cc3d_test/bin/clang++ ' \
    #            '-DCMAKE_C_COMPILER:STRING=/Users/m/miniconda3/envs/cc3d_test/bin/clang ' \
    #            f'-S /Users/m/CC3D_BUILD_SCRIPTS_GIT/openmp -B /Users/m/CC3D_BUILD_SCRIPTS_GIT/openmp_build_new_1'
    #
    # print(cmd_test)
    # # os.system(f'conda init; conda activate cc3d_test ; {cmd_test}')
    # # os.system(f'source /Users/m/miniconda3/etc/profile.d/conda.sh ; conda activate cc3d_test ; {cmd_test}')
    # os.system(f'source {conda_shell_script} ; conda activate {conda_env_name} ; {cmd_test}')

    # cmd_cmake_generate = f'{cmake_exec} -G "{cmake_generator_name}" -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo ' \
    #         f'-DCMAKE_INSTALL_PREFIX:PATH={install_dir} ' \
    #         f'-DCMAKE_CXX_COMPILER:STRING={cmake_cxx_compiler} ' \
    #         f'-DCMAKE_C_COMPILER:STRING={cmake_c_compiler} ' \
    #         f'-DCOMPUCELL3D_GIT_DIR:PATH={compucell3d_git_dir} ' \
    #         f'-DCOMPUCELL3D_INSTALL_PATH:PATH={install_dir} ' \
    #         f'-S {developer_zone_source} ' \
    #         f'-B {build_dir} ' \

    cmd_cmake_generate = f'{cmake_exec} -G "{cmake_generator_name}" -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo ' \
            f'-DCMAKE_INSTALL_PREFIX:PATH={install_dir} ' \
            f'-DCOMPUCELL3D_GIT_DIR:PATH={compucell3d_git_dir} ' \
            f'-DCOMPUCELL3D_INSTALL_PATH:PATH={install_dir} ' \
            f'-DPYTHON_INCLUDE_DIR:PATH={python_include_dir} ' \
            f'-DPYTHON_LIBRARY:PATH={ld_library} ' \
            f'-S {developer_zone_source} ' \
            f'-B {build_dir} ' \


    # os.system(f'source {conda_shell_script} ; conda activate {conda_env_name} ; {cmd_cmake_generate}')
    # os.system(f'conda activate {conda_env_name} & {cmd_cmake_generate}')
    os.system(f'conda activate {conda_env_name} & {cmd_cmake_generate}')


#          f'-DCOMPUCELL3D_FULL_SOURCE_PATH:PATH={compucell3d_full_source_path} ' \
    #
    # os.system(cmd_test)

#               f'-DCMAKE_CXX_COMPILER={cmake_cxx_compiler} ' \
#               f'-DCMAKE_C_COMPILER={cmake_c_compiler} ' \

#     cmd = f'{cmake_exec} -G "{cmake_generator_name}" -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo ' \
#           f'-DCMAKE_INSTALL_PREFIX:PATH={install_dir} ' \
#           f'-DCMAKE_CXX_COMPILER:STRING={cmake_cxx_compiler} ' \
#           f'-DCMAKE_C_COMPILER:STRING={cmake_c_compiler} ' \
#           f'-DSWIG_EXECUTABLE:PATH={swig_exec} ' \
#           f'-DCOMPUCELL3D_FULL_SOURCE_PATH:PATH={compucell3d_full_source_path} ' \
#           f'-DCOMPUCELL3D_INSTALL_PATH:PATH={install_dir} ' \
#           f'-S {developer_zone_source} ' \
#           f'-B {build_dir} ' \
#
# #          f'-DPython_EXECUTABLE:PATH={python_exec} ' \
# #          f'-DPython_INCLUDE_DIRS:PATH={py_include_dir} -DPython_LIBRARIES:PATH={ld_library_abs_path} ' \
# #          f'-DPython_LIBRARY_RELEASE:PATH={ld_library_abs_path} ' \
#
#
#     os.system(cmd)
    # python_info = get_paths()
    # pprint(python_info)

    # subprocess.call([CMAKE_PATH,'-G', CMAKE_GENERATOR_NAME,'-DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo','-DCMAKE_INSTALL_PREFIX:PATH='+INSTALL_PREFIX,'-DCOMPUCELL3D_A_MAJOR_VERSION:STRING='+str(MAJOR_VERSION),'-DCOMPUCELL3D_B_MINOR_VERSION:STRING='+str(MINOR_VERSION),'-DCOMPUCELL3D_C_BUILD_VERSION:STRING='+str(BUILD_VERSION),'-DWINDOWS_DEPENDENCIES:PATH='+WIN_DEPENDENCIES_ROOT, CC3D_SOURCE_PATH ])
    # # subprocess.call(['nmake'])
    # subprocess.call(['nmake','install'])


    return

    # print(cc3d.cc3d_py_dir)
    # print(cc3d.cc3d_cpp_bin_path)
    # conda_exec = find_conda()
    # print('conda_exec=', conda_exec)
    # conda_env_name = find_current_conda_env(conda_exec=conda_exec)
    # print('conda_env_name=', conda_env_name)
    # conda_exec= Path(conda_exec)
    # conda_env_dir = conda_exec.parent.parent.joinpath('envs', conda_env_name)
    # print('conda_env_dir=', conda_env_dir)
    # if sys.platform.startswith('win'):
    #     print('add code here')
    # else:
    #     cmake_exec = conda_env_dir.joinpath('bin', 'cmake')
    #     if cmake_exec.exists():
    #         os.system(f'{cmake_exec}')
    #     else:
    #         raise RuntimeError(f'Could not locate cmake : Checked the following location: {cmake_exec}')





def find_current_conda_env(conda_exec):
    if conda_exec is None:
        return None

    envs = subprocess.check_output(f'{conda_exec} env list', shell=True).splitlines()
    active_env = list(filter(lambda s: '*' in str(s), envs))[0]
    env_name = active_env.decode("utf-8").split()[0]
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
    main()

