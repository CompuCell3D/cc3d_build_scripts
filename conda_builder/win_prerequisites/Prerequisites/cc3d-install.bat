@echo off
@REM needed to avoid issues introduces by the new mamba - we can also execute this command: chcp 65001
set PYTHONIOENCODING=utf-8

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

call %mamba_bat% install -y -c main -c compucell3d -c conda-forge compucell3d=%version%

@REM |%script_dir%\tee %script_dir%\install.log 2>&1

