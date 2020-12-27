import subprocess
import os
import contextlib
from pathlib import Path


@contextlib.contextmanager
def remember_cwd():
    curdir = os.getcwd()
    try:
        yield
    finally:
        os.chdir(curdir)


def get_git_sha(git_repo, git_exe=None):
    """
    Fetches git sha label from git
    :param git_repo:
    :param git_exe:
    :return:
    """

    if git_exe is None:
        git_exe = 'git'

    with remember_cwd():
        os.chdir(git_repo)
        try:
            sha_label = subprocess.check_output([git_exe, "describe", '--always']).strip()
        except FileNotFoundError:
            sha_label = ''

    if isinstance(sha_label, bytes):
        sha_label = sha_label.decode('utf-8')

    return sha_label



def create_comit_tag_py(sha_label, target_path):

    with Path(target_path).open('w') as sha_out:
        sha_out.write(f"sha_label = '{sha_label}'\n")


# def create_sha_label_py(git_repo, git_exe=None):
#     sha_label = get_git_sha(git_repo=git_repo, git_exe=git_exe)
#
#     with Path(git_repo).joinpath('sha_label.py').open('w') as sha_out:
#         sha_out.write(f"sha_label = '{sha_label}'\n")



# git_exe = r'c:\Program Files\Git\bin\git.exe'
#
# git_repo = 'D:/CC3D_PY3_GIT/cc3d'
#
# print(get_git_sha(git_exe=git_exe, git_repo=git_repo))
#
# create_comit_tag_py(git_exe=git_exe, git_repo=git_repo)

#
# # cwd = os.getcwd()
# #
# # os.chdir(git_repo)
# #
# #
# # label = subprocess.check_output([git_exe, "describe", '--always']).strip()
# #
# # os.chdir(cwd)
# #
# # print(os.getcwd())
# #
# # print(label)
# #
