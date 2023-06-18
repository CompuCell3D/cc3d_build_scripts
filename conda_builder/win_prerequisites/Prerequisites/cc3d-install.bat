@echo off
set version=%1
echo "WILL INSTALL COMPUCELL3D VERSION =" %version%
SET script_dir=%~dp0

@REM get absolute paths
@REM using https://stackoverflow.com/questions/1645843/resolve-absolute-path-from-relative-path-and-or-file-name
set condabin_dir=
set condabin_dir_rel= %script_dir%\..\Miniconda3\condabin
pushd %condabin_dir_rel%
set condabin_dir=%CD%
popd

set conda_bat=%condabin_dir%\conda.bat
set mamba_bat=%condabin_dir%\mamba.bat
call %conda_bat% activate base

call %conda_bat% install -y -c conda-forge mamba
rem call %conda_bat% create -y -n cc3d python=3.7
rem call %conda_bat% activate cc3d
call %mamba_bat% install -y -c compucell3d -c conda-forge compucell3d=%version%|%script_dir%\tee %script_dir%\install.log 2>&1
call %conda_bat% deactivate cc3d
