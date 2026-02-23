@echo off
setlocal enabledelayedexpansion

REM Get CompuCell3D version from first argument
set "version=%1"
if "%version%"=="" (
    echo ERROR: No version specified. Usage: cc3d-install.bat 4.5.0
    exit /b 1
)

echo Installing CompuCell3D version: %version%

REM Resolve path to miniforge3 relative to script location
REM Assuming script is in a 'Prerequisites' folder, and miniforge3 is next to it.
set "BASE_DIR=%~dp0\.."
pushd "%BASE_DIR%\miniforge3"
set "MINIFORGE_DIR=%CD%"
popd

set "CONDA_BAT=%MINIFORGE_DIR%\condabin\conda.bat"
set "MAMBA_EXE=%MINIFORGE_DIR%\condabin\mamba.bat"

echo Using Miniforge from: %MINIFORGE_DIR%

REM Ensure conda.bat exists
if not exist "%CONDA_BAT%" (
    echo ERROR: conda.bat not found at %CONDA_BAT%
    exit /b 1
)

REM 1. Activate the base environment to access mamba/conda
call "%MINIFORGE_DIR%\condabin\activate.bat"

REM 2. Create a dedicated environment for CC3D with Python 3.12
REM We use mamba because it is built into Miniforge and is much faster.
echo Creating cc3d_env with Python 3.12...
call "%MAMBA_EXE%" create -y -n cc3d_env python=3.12 -c conda-forge

REM 3. Install CompuCell3D into the NEW environment
echo Installing CompuCell3D into cc3d_env...
call "%MAMBA_EXE%" install -y -n cc3d_env -c compucell3d -c conda-forge compucell3d=%version%

echo Installation complete. 
echo To use CC3D, activate the environment: conda activate cc3d_env

endlocal


@REM @echo off
@REM setlocal enabledelayedexpansion
@REM 
@REM REM Get CompuCell3D version from first argument
@REM set "version=%1"
@REM echo Installing CompuCell3D version: %version%
@REM 
@REM REM Resolve path to Miniconda3 relative to script location
@REM set "BASE_DIR=%~dp0\.."  REM one level up from Prerequisites
@REM pushd "%BASE_DIR%\Miniconda3"
@REM set "MINICONDA_DIR=%CD%"
@REM popd
@REM 
@REM set "CONDA_BAT=%MINICONDA_DIR%\condabin\conda.bat"
@REM set "MAMBA_BAT=%MINICONDA_DIR%\condabin\mamba.bat"
@REM 
@REM echo Using Miniconda from: %MINICONDA_DIR%
@REM 
@REM REM Ensure conda.bat exists
@REM if not exist "%CONDA_BAT%" (
@REM     echo ERROR: conda.bat not found at %CONDA_BAT%
@REM     exit /b 1
@REM )
@REM 
@REM REM Activate base env
@REM @REM call "%CONDA_BAT%" activate base
@REM call %MINICONDA_DIR%\condabin\activate.bat activate %MINICONDA_DIR%
@REM 
@REM  echo Installing mamba locally... "%conda_bat%"
@REM REM Install mamba into local Miniconda
@REM call "%CONDA_BAT%" install -y -c conda-forge mamba=2.1.1 python=3.12
@REM 
@REM REM Ensure mamba installed
@REM if not exist "%MAMBA_BAT%" (
@REM     echo ERROR: mamba.bat not found at %MAMBA_BAT%
@REM     exit /b 1
@REM )
@REM 
@REM REM Install CompuCell3D using local mamba
@REM call "%MAMBA_BAT%" install -y -c main -c compucell3d -c conda-forge compucell3d=%version%
@REM 
@REM endlocal
@REM 
