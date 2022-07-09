set version=%1
echo "WILL INSTALL COMPUCELL3D VERSION =" %version%
SET script_dir=%~dp0
@CALL %script_dir%\..\Miniconda3\condabin\activate.bat

rem this requires that we bundle tee command (tee.exe) with the installer
set PATH= %script_dir%\..\Prerequisites;%PATH%
conda install -y -c compucell3d -c conda-forge compucell3d=%version% |tee install.log 2>&1


