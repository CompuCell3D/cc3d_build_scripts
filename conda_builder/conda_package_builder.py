import json
import argparse
from pathlib import Path
import shutil
from contextlib import contextmanager
import time
import os
import sys
import jinja2

from jinja2 import Environment, FileSystemLoader
# env = Environment(loader=FileSystemLoader('templates'))
# template = env.get_template('test.html')
# output_from_parsed_template = template.render(foo='Hello World!')
# print(output_from_parsed_template)
#
# # to save the results
# with open("my_new_file.html", "w") as fh:
#     fh.write(output_from_parsed_template)


def main():

    version = "4.3.2"
    build_number = "1"

    json_path = r'D:\CC3D_BUILD_SCRIPTS_GIT\conda_builder\cc3d_conda_input_data.json'
    json_dict = parse_input_json(json_path=json_path)

    # cc3d
    cc3d_core_conda_recipes = Path(json_dict['cc3d']).joinpath()

    jinja_pth = Path(r'D:\CC3D_BUILD_SCRIPTS_GIT\conda_builder\meta.yaml.jinja')

    meta_yaml_path = Path(r'D:\CC3D_BUILD_SCRIPTS_GIT\conda_builder\meta.yaml')
    build_conda_package(conda_build_dir=cc3d_core_conda_recipes, version=version, build_number=build_number)

    # prepare_conda_meta(version=version, build_number=build_number, meta_yaml_path=meta_yaml_path)
    # # render_jinja_template(jinja_template_path=jinja_pth, output_path=Path('rendered_template.yaml'),
    # #                       version=version, build_number=build_number)
    #
    #
    # build_conda_package(conda_build_dir=cc3d_core_conda_recipes, version=version, build_number=build_number)
    #
    print


def parse_input_json(json_path):

    with open(json_path, 'r') as json_in:
        json_dict = json.load(json_in)
        return json_dict


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






# def create_conda_dir_work_folder_copy(source_conda_dir: Path):
#
#     tmp_conda_dir = Path(str(source_conda_dir)+"-tmp")
#     tmp_conda_dir.mkdir(parents=True, exist_ok=True)
#     shutil.copytree(source_conda_dir, tmp_conda_dir)
#
#


def build_conda_package(conda_build_dir, version, build_number):

    command_join_char = ';'
    if sys.platform.startswith('win'):
        command_join_char = '&'

    with conda_build_handler(source_conda_dir=conda_build_dir) as conda_build_workdir:
        meta_yaml_path = conda_build_workdir.joinpath('meta.yaml')
        prepare_conda_meta(version=version, build_number=build_number, meta_yaml_path=meta_yaml_path)

        command_build = f"cd {str(conda_build_dir)} {command_join_char} conda activate base " \
                        f"{command_join_char} conda build ."

        print ('building conda package using command: ')
        print(command_build)

        # os.system(command_build)


        # time.sleep(10)
    # create_conda_dir_work_folder_copy(source_conda_dir=conda_build_dir)


def concatenate_files(filenames, out_fname):
    with open(out_fname, 'w') as outfile:
        for fname in filenames:
            with open(fname) as infile:
                outfile.write(infile.read())






if __name__ == '__main__':
    main()
