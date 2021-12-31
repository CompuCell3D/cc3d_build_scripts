set version=%1
echo "WILL INSTALL COMPUCELL3D VERSION =" %version%
SET script_dir=%~dp0
@CALL %script_dir%\..\Miniconda3\condabin\activate.bat
conda install -y -c compucell3d -c conda-forge compucell3d=%version%
pause

