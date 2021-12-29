from pathlib import Path
import subprocess


def main():
    CC3D_CORE_SRC = Path('/Users/m/CC3D_PY3_GIT')
    CC3D_PLAYER_SRC = Path('/Users/m/cc3d-player5')
    CC3D_TWEDIT_SRC = Path('/Users/m/cc3d-twedit5')

    # build conda pkg for core cc3d
    subprocess.call(['conda ', 'build', str(CC3D_CORE_SRC.joinpath('conda-recipes')) ])

    # build conda pkg for cc3d player5
    subprocess.call(['conda ', 'build', str(CC3D_PLAYER_SRC.joinpath('conda-recipes')) ])

    # build conda pkg for cc3d twedit5
    subprocess.call(['conda ', 'build', str(CC3D_TWEDIT_SRC.joinpath('conda-recipes')) ])

    # build conda pkg for compucell3d suite
    subprocess.call(['conda ', 'build', str(CC3D_CORE_SRC.joinpath('conda-recipes-compucell3d')) ])


if __name__ == '__main__':
    main()
