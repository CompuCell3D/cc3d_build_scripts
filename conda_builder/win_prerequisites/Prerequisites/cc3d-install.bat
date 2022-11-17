set version=%1
echo "WILL INSTALL COMPUCELL3D VERSION =" %version%
SET script_dir=%~dp0

rem get absolute paths
rem using https://stackoverflow.com/questions/1645843/resolve-absolute-path-from-relative-path-and-or-file-name
set condabin_dir=
set condabin_dir_rel= %script_dir%\..\Miniconda3\condabin
pushd %condabin_dir_rel%
set condabin_dir=%CD%
popd

rem %condabin_dir%\conda.bat install -y  -c conda-forge mamba |tee install.log 2>&1

rem %condabin_dir%\mamba.bat install -y -c compucell3d -c conda-forge compucell3d=%version% |tee -a install.log 2>&1





