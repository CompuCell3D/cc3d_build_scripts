# """
# example command line:
#
# build_win_installer.py --version 4.3.2 --build-number 2 --source-dir d:\CC3D_BUILD_SCRIPTS_GIT\conda_builder
# --target-dir d:\CC3D_FILES_SVN\binaries\ --nsis-exe "C:/Program Files (x86)/NSIS/makensis.exe"
# --certificate c:\Users\m\Documents\certificate_sectigo\my_sectigo_certificate.pfx
#
# source dir would have win_prerequisites  and win_nsis subfolders
#
# """
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
    source_dir = Path(args.source_dir)
    target_dir = Path(args.target_dir)
    #
    target_dir = target_dir.joinpath(f'{version}')

    nsis_exe = Path(args.nsis_exe)
    certificate = Path(args.certificate)

    installer_path = get_installer_path(target_dir=target_dir, version=version, build_number=build_number)

    populate_target_dir(source_dir=source_dir, target_dir=target_dir)
    prep_nsis_template(target_dir=target_dir, version=version, build_number=build_number)
    run_nsis(nsis_exe=nsis_exe, target_dir=target_dir)
    sign(certificate=certificate, installer_path=installer_path, version=version, build_number=build_number)


def parse_cml():
    parser = argparse.ArgumentParser()

    parser.add_argument('--json-config', type=str)
    parser.add_argument('--version', type=str)
    parser.add_argument('--build-number', type=str)
    parser.add_argument('--source-dir', type=str)
    parser.add_argument('--target-dir',  type=str)
    parser.add_argument('--nsis-exe', type=str)
    parser.add_argument('--certificate', type=str)

    args = parser.parse_args()
    return args


def get_installer_path(target_dir: Path, version: str, build_number: str) -> Path:

    installer_full_path = target_dir.joinpath('windows', f'CompuCell3D-setup-{version}.{build_number}.exe')
    return installer_full_path


def populate_target_dir(source_dir: Path, target_dir: Path):
    if target_dir.exists():
        shutil.rmtree(target_dir)

    shutil.copytree(source_dir.joinpath('win_nsis'), target_dir)


def prep_nsis_template(target_dir: Path, version: str, build_number: str):
    nsis_orig = target_dir.joinpath('CompuCell3D_installer.nsi')
    tmp_nsis = target_dir.joinpath('CompuCell3D_installer.nsi.tmp')
    tmp_nsis_header = target_dir.joinpath('CompuCell3D_installer.nsi.tmp.header')

    shutil.copy(nsis_orig, tmp_nsis)

    with open(tmp_nsis_header, 'w') as out:
        out.write(f'!define CC3D_VERSION "{version}"\n')
        out.write(f'!define CC3D_BUILD_NUMBER "{build_number}"\n')

    concatenate_files(filenames=[tmp_nsis_header, tmp_nsis], out_fname=nsis_orig)
    # shutil.copy(out_meta_yaml_path, meta_yaml_path)
    os.remove(tmp_nsis)
    os.remove(tmp_nsis_header)


def concatenate_files(filenames, out_fname):
    with open(out_fname, 'w') as outfile:
        for fname in filenames:
            with open(fname) as infile:
                outfile.write(infile.read())


def run_nsis(nsis_exe: Path, target_dir: Path):
    nsis_orig = target_dir.joinpath('CompuCell3D_installer.nsi')
    cmd = f'"{str(nsis_exe)}" /V2 {str(nsis_orig)}'
    print("Running command:")
    print(cmd)
    os.system(cmd)


def sign(certificate: Path, installer_path: Path, version: str, build_number:str):
    with open('do_not_commit.txt', 'r') as infile:
        p = infile.readlines()[0]

    activate_visual_studio_shell = r'call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64'

    cmd = f'signtool.exe sign /a /f {str(certificate)} /p {p} /t http://timestamp.comodoca.com/authenticode ' \
            f'/d CompuCell3D-{version}.{build_number} {str(installer_path)}'

    full_cmd = rf'{activate_visual_studio_shell} & {cmd}'
    print('Sign command:')
    # print(full_cmd)
    os.system(full_cmd)


if __name__ == '__main__':
    main()