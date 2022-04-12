set version=%1
echo "WILL INSTALL COMPUCELL3D VERSION =" %version%
SET script_dir=%~dp0
@CALL %script_dir%\..\Miniconda3\condabin\activate.bat

REM unzipping demos
rem %script_dir%\..\Miniconda3\python -m zipfile -e %script_dir%\..\Demos.zip %script_dir%\..\Demos

rem installing actual compucell3d

rem conda install -y -c compucell3d -c conda-forge compucell3d=%version% >  %script_dir%\install.log & type install.log
conda install -y -c compucell3d -c conda-forge compucell3d=%version%
pause

