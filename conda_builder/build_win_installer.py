# """
# example command line:
# --version 4.4.0 --build-number 0 --source-dir d:\src\cc3d_build_scripts\conda_builder --target-dir d:\CC3D_FILES_SVN\binaries\ --nsis-exe "C:/Program Files (x86)/NSIS/makensis.exe" --certificate c:\Users\m\Documents\certificate_sectigo\my_sectigo_certificate_2023.pfx --json-config d:\src\cc3d_build_scripts\conda_builder\cc3d_conda_input_data_do_not_commit.json
#
# source dir would have win_prerequisites  and win_nsis subfolders
#
# """

import argparse
from pathlib import Path
import shutil
import os
import json


def main():
    args = parse_cml()
    version = args.version
    build_number = args.build_number
    source_dir = Path(args.source_dir)
    target_dir = Path(args.target_dir)
    #
    target_dir = target_dir.joinpath(f"{version}.{build_number}")

    nsis_exe = Path(args.nsis_exe)
    certificate = Path(args.certificate)

    json_dict = parse_input_json(json_path=args.json_config)
    demos_dir = Path(json_dict["demos"])
    prerequisites_dir = Path(json_dict["prerequisites_dir"])
    # bundled_installer_dir = Path(args.bundled_installer_dir)
    full_prereq_dir = prerequisites_dir.joinpath(f"{version}.{build_number}")

    prepare_prerequisites(source_dir=source_dir, full_prereq_dir=full_prereq_dir)

    compress_demos_folder(demos_dir=demos_dir, full_prereq_dir=full_prereq_dir)

    installer_path = get_installer_path(target_dir=target_dir, version=version, build_number=build_number)

    populate_target_dir(source_dir=source_dir, target_dir=target_dir)

    prep_nsis_template(target_dir=target_dir, version=version, build_number=build_number)

    run_nsis(nsis_exe=nsis_exe, target_dir=target_dir)
    # create dir for the installer
    target_dir.joinpath("windows").mkdir(exist_ok=True, parents=True)
    sign(certificate=certificate, installer_path=installer_path, version=version, build_number=build_number)


def parse_cml():
    parser = argparse.ArgumentParser()

    parser.add_argument("--json-config", type=str)
    parser.add_argument("--version", type=str)
    parser.add_argument("--build-number", type=str)
    parser.add_argument("--source-dir", type=str)
    parser.add_argument("--target-dir", type=str)
    parser.add_argument("--nsis-exe", type=str)
    parser.add_argument("--certificate", type=str)

    args = parser.parse_args()
    return args


def prepare_prerequisites(source_dir: Path, full_prereq_dir: Path):
    source_pre_req_folder = source_dir.joinpath("win_prerequisites")
    if full_prereq_dir.exists():
        shutil.rmtree(full_prereq_dir)
    shutil.copytree(source_pre_req_folder, full_prereq_dir)


def parse_input_json(json_path) -> dict:
    with open(json_path, "r") as json_in:
        json_dict = json.load(json_in)
        return json_dict


def compress_demos_folder(demos_dir: Path, full_prereq_dir: Path):
    demos_target_path = full_prereq_dir.joinpath("Demos")
    shutil.make_archive(demos_target_path, "zip", demos_dir)
    # cmd = f'zip -r {str(demos_target_path)} {str(demos_dir)}'
    # os.system(cmd)


def get_installer_path(target_dir: Path, version: str, build_number: str) -> Path:
    installer_full_path = target_dir.joinpath("windows", f"CompuCell3D-setup-{version}.{build_number}.exe")
    return installer_full_path


def populate_target_dir(source_dir: Path, target_dir: Path):
    if target_dir.exists():
        shutil.rmtree(target_dir)

    shutil.copytree(source_dir.joinpath("win_nsis"), target_dir)
    target_dir.joinpath("windows").mkdir(exist_ok=True, parents=True)


def prep_nsis_template(target_dir: Path, version: str, build_number: str):
    nsis_orig = target_dir.joinpath("CompuCell3D_installer.nsi")
    tmp_nsis = target_dir.joinpath("CompuCell3D_installer.nsi.tmp")
    tmp_nsis_header = target_dir.joinpath("CompuCell3D_installer.nsi.tmp.header")

    shutil.copy(nsis_orig, tmp_nsis)

    with open(tmp_nsis_header, "w") as out:
        out.write(f'!define CC3D_VERSION "{version}"\n')
        out.write(f'!define CC3D_BUILD_NUMBER "{build_number}"\n')

    concatenate_files(filenames=[tmp_nsis_header, tmp_nsis], out_fname=nsis_orig)
    # shutil.copy(out_meta_yaml_path, meta_yaml_path)
    os.remove(tmp_nsis)
    os.remove(tmp_nsis_header)


def concatenate_files(filenames, out_fname):
    with open(out_fname, "w") as outfile:
        for fname in filenames:
            with open(fname) as infile:
                outfile.write(infile.read())


def run_nsis(nsis_exe: Path, target_dir: Path):
    nsis_orig = target_dir.joinpath("CompuCell3D_installer.nsi")
    cmd = f'"{str(nsis_exe)}" /V4 {str(nsis_orig)}'
    print("Running command:")
    print(cmd)
    os.system(cmd)


def sign(certificate: Path, installer_path: Path, version: str, build_number: str):
    with open("do_not_commit.txt", "r") as infile:
        p = infile.readlines()[0]

    activate_visual_studio_shell = r'call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64'

    cmd = (
        f"signtool.exe sign /a /f {str(certificate)} /p {p} /t http://timestamp.comodoca.com/authenticode "
        f"/d CompuCell3D-{version}.{build_number} {str(installer_path)}"
    )

    full_cmd = rf"{activate_visual_studio_shell} & {cmd}"
    print("Sign command:")
    # print(full_cmd)
    os.system(full_cmd)


if __name__ == "__main__":
    main()
