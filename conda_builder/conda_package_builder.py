"""
example command line:

conda_package_builder.py --version 4.3.2 --build-number 2
--json-config D:\CC3D_BUILD_SCRIPTS_GIT\conda_builder\cc3d_conda_input_data_do_not_commit.json
--build-installer

example command line with specified packages


conda_package_builder.py --version 4.3.2 --build-number 2
--json-config D:\CC3D_BUILD_SCRIPTS_GIT\conda_builder\cc3d_conda_input_data_do_not_commit.json --packages  cc3d cc3d_player5
--build-installer

--skip-conda-build - skips building of the conda packages and allows users to build only installer

allowed packages cc3d cc3d_player5, cc3d_twedit5 compucell3d. Build order matters

# linux example:
conda_package_builder.py --version 4.3.2 --build-number 2
--json-config /home/m/cc3d_build_scripts/conda_builder/cc3d_conda_input_data_linux.json


"""
import json
import argparse
from pathlib import Path
import shutil
from contextlib import contextmanager
import os
import sys
from jinja2 import Environment, FileSystemLoader


def main():

    args = parse_cml()
    version = args.version
    build_number = args.build_number
    json_path = args.json_config
    packages = args.packages
    build_installer = args.build_installer
    skip_conda_build = args.skip_conda_build

    json_dict = parse_input_json(json_path=json_path)
    conda_dirs_data_list = json_dict['conda_dirs']

    all_configured_packages = []
    # in this case we build all packages as specified in json
    for package_data in conda_dirs_data_list:
        all_configured_packages.append(next(iter(package_data.keys())))

    configured_packages = all_configured_packages
    if packages is not None and len(packages):
        configured_packages = packages

    # building package after package
    if not skip_conda_build:
        for package_data in conda_dirs_data_list:
            package_name = next(iter(package_data.keys()))
            conda_recipe_dir = next(iter(package_data.values()))

            if package_name in configured_packages:
                build_conda_package(conda_build_dir=conda_recipe_dir, version=version, build_number=build_number)

    if build_installer:
        if sys.platform.startswith('win'):
            build_installer_win(json_dict=json_dict, version=version, build_number=build_number)
        elif sys.platform.startswith('darwin'):
            build_installer_mac(json_config_path=json_path, version=version, build_number=build_number)
        elif sys.platform.startswith('linux'):
            build_installer_linux(json_config_path=json_path, version=version, build_number=build_number)
        else:
            raise RuntimeError(f"Unsupported OS : ${sys.platform}")


def parse_cml():
    parser = argparse.ArgumentParser()

    parser.add_argument('--json-config', type=str)
    parser.add_argument('--version', type=str)
    parser.add_argument('--build-number', type=str)
    parser.add_argument('--packages',  nargs='*', action='store', type=str)
    parser.add_argument('--build-installer',  action='store_true', default=False)
    parser.add_argument('--skip-conda-build', action='store_true', default=False)
    parser.add_argument('--installer-target-dir', type=str, default='')

    args = parser.parse_args()
    return args


@contextmanager
def conda_build_handler(source_conda_dir) -> Path:
    tmp_conda_dir = Path(str(source_conda_dir)+"-tmp")
    # tmp_conda_dir.mkdir(parents=True, exist_ok=True)
    shutil.copytree(source_conda_dir, tmp_conda_dir)
    yield tmp_conda_dir

    shutil.rmtree(tmp_conda_dir)


def prepare_conda_meta(version, build_number, meta_yaml_path: Path):
    header_meta_yaml_path = Path(str(meta_yaml_path) + '.header')
    out_meta_yaml_path = Path(str(meta_yaml_path) + '.tmp')

    with open(header_meta_yaml_path , 'w') as out:
        out.write("{%" + f'  set version = "{version}" ' + '%}\n')
        out.write("{%" + f'  set build_number = "{build_number}" ' + '%}\n')

    concatenate_files(filenames=[header_meta_yaml_path, meta_yaml_path], out_fname=out_meta_yaml_path)
    shutil.copy(out_meta_yaml_path, meta_yaml_path)
    os.remove(out_meta_yaml_path)
    os.remove(header_meta_yaml_path)


def render_jinja_template(jinja_template_path: Path, output_path: Path, **kwargs):
    jinja_template_dir = jinja_template_path.parent
    env = Environment(loader=FileSystemLoader(str(jinja_template_dir)))

    template = env.get_template('meta.yaml.jinja')
    # template = env.get_template(str(jinja_template_path))
    output_from_parsed_template = template.render(**kwargs)

    # to save the results
    output_path.parent.mkdir(parents=True, exist_ok=True)
    with open(output_path, "w") as fh:
        fh.write(output_from_parsed_template)


def build_conda_package(conda_build_dir, version, build_number):

    command_join_char = ';'
    if sys.platform.startswith('win'):
        command_join_char = '&'

    with conda_build_handler(source_conda_dir=conda_build_dir) as conda_build_workdir:
        meta_yaml_path = conda_build_workdir.joinpath('meta.yaml')
        prepare_conda_meta(version=version, build_number=build_number, meta_yaml_path=meta_yaml_path)

        command_build = f"cd {str(conda_build_workdir)} {command_join_char} conda activate base " \
                        f"{command_join_char} conda build . -c conda-forge -c compucell3d -c local"

        print ('building conda package using command: ')
        print(command_build)

        os.system(command_build)


def concatenate_files(filenames, out_fname):
    with open(out_fname, 'w') as outfile:
        for fname in filenames:
            with open(fname) as infile:
                outfile.write(infile.read())


def build_installer_win(json_dict: dict, version: str, build_number: str):
    current_script_dir = Path(__file__).parent
    source_dir = current_script_dir
    installer_builder_script = current_script_dir.joinpath('build_win_installer.py')
    python_exe = sys.executable

    certificate = json_dict['certificate']
    nsis_exe = json_dict['nsis_exe']

    installer_target_dir = json_dict['installer_target_dir']

    cmd = f'{python_exe} {installer_builder_script} --version {version} --build-number {build_number} ' \
          f'--source-dir {source_dir} --target-dir {installer_target_dir} --nsis-exe "{nsis_exe}" ' \
          f'--certificate {certificate}'

    print('Installer building command:')
    print(cmd)

    os.system(cmd)


def build_installer_mac(json_config_path: Path, version: str, build_number: str):

    json_dict = parse_input_json(json_path=json_config_path)
    installer_target_dir = json_dict['installer_target_dir']

    current_script_dir = Path(__file__).parent
    installer_builder_script = current_script_dir.joinpath('build_mac_installer.py')
    bundled_installer_dir = current_script_dir.joinpath('mac_bundled_installer')
    python_exe = sys.executable

    cmd = f'{python_exe} {installer_builder_script} --version {version} --build-number {build_number} ' \
          f'--json-config {str(json_config_path)} --bundled-installer-dir {bundled_installer_dir} ' \
          f'--target-dir {installer_target_dir}'

    print('Installer building command:')
    print(cmd)

    os.system(cmd)


def build_installer_linux(json_config_path: Path, version: str, build_number: str):

    json_dict = parse_input_json(json_path=json_config_path)
    installer_target_dir = json_dict['installer_target_dir']

    current_script_dir = Path(__file__).parent
    installer_builder_script = current_script_dir.joinpath('build_linux_installer.py')
    bundled_installer_dir = current_script_dir.joinpath('linux_installer', 'bundled_installer')
    python_exe = sys.executable

    cmd = f'{python_exe} {installer_builder_script} --version {version} --build-number {build_number} ' \
          f'--json-config {str(json_config_path)} --bundled-installer-dir {bundled_installer_dir} ' \
          f'--target-dir {installer_target_dir}'

    print('Installer building command:')
    print(cmd)

    os.system(cmd)


def parse_input_json(json_path)->dict:

    with open(json_path, 'r') as json_in:
        json_dict = json.load(json_in)
        return json_dict


if __name__ == '__main__':
    main()
