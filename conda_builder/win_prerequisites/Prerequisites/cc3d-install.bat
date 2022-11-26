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

call %condabin_dir%\conda.bat install -y -c conda-forge mamba
Call %condabin_dir%\mamba.bat install -y -c compucell3d -c conda-forge compucell3d=%version%|%script_dir%\tee %script_dir%\install.log 2>&1

