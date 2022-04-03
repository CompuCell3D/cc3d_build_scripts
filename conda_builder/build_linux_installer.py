"""
example command line:

build_linux_installer.py
--json-config /home/m/cc3d_build_scripts/conda_builder/cc3d_conda_input_data_linux.json
--version 4.3.2 --build-number 2
--bundled-installer-dir /home/m/cc3d_build_scripts/conda_builder/linux_installer/bundled_installer
--target-dir /home/m/ibinaries

"""



import argparse
from pathlib import Path
import shutil
import json
import contextlib
import os


def main():
    args = parse_cml()
    version = args.version
    build_number = args.build_number
    json_path = args.json_config

    json_dict = parse_input_json(json_path=json_path)
    demos_dir = Path(json_dict['demos'])
    bundled_installer_dir = Path(args.bundled_installer_dir)
    target_dir = Path(args.target_dir)

    compress_demos_folder(demos_dir=demos_dir, bundled_installer_dir=bundled_installer_dir)

    build_installer(bundled_installer_dir=bundled_installer_dir, target_dir=target_dir, version=version,
                    build_number=build_number)


def parse_cml():
    parser = argparse.ArgumentParser()

    parser.add_argument('--json-config', type=str)
    parser.add_argument('--version', type=str)
    parser.add_argument('--build-number', type=str)
    parser.add_argument('--bundled-installer-dir', type=str)
    parser.add_argument('--target-dir', type=str)

    args = parser.parse_args()
    return args


def parse_input_json(json_path)->dict:

    with open(json_path, 'r') as json_in:
        json_dict = json.load(json_in)
        return json_dict


def compress_demos_folder(demos_dir: Path, bundled_installer_dir: Path):

    demos_target_path = bundled_installer_dir.joinpath('payload', 'Demos.zip')
    # cmd = f'zip -r {str(demos_target_path)} {str(demos_dir)}'

    with cd(demos_dir.parent):
        demos_target_path.unlink()
        print('demos_dir.parent=', demos_dir.parent)
        print('demos_target_path=', demos_target_path)
        cmd = f'zip -r {str(demos_target_path)} Demos'
        print(cmd)
        os. system(cmd)


def get_installer_path(target_dir: Path, version: str, build_number: str) -> Path:
    installer_full_path = target_dir.joinpath(f'{version}.{build_number}', 'cc3d-installer-linux.sh')
    return installer_full_path


def build_installer(bundled_installer_dir: Path, target_dir: Path, version: str, build_number: str):
    """

    :param bundled_installer_dir:
    :return:
    """
    cmd_build = f'./build.sh {version}'
    installer_target_path = get_installer_path(target_dir=target_dir, version=version, build_number=build_number)
    installer_target_path.parent.mkdir(exist_ok=True, parents=True)
    # this will be created after we run cmd_build
    source_installer_path = bundled_installer_dir.joinpath('cc3d-installer-linux.sh')

    with cd(bundled_installer_dir):
        os.system('pwd')
        os.system('ls -la')
        os.system(cmd_build)
        shutil.copy(source_installer_path, installer_target_path)


@contextlib.contextmanager
def cd(path):
    old_path = os.getcwd()
    os.chdir(path)
    try:
        yield
    finally:
        os.chdir(old_path)


if __name__ == '__main__':
    main()
