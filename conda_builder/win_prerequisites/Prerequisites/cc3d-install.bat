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
set "ENV_PREFIX=%MINIFORGE_DIR%\envs\cc3d_env"

REM --- ISOLATION SETTINGS ---
REM 1. Force package cache to stay inside the local Miniforge folder
set "CONDA_PKGS_DIRS=%MINIFORGE_DIR%\pkgs"
REM 2. Point to a local (temporary or blank) config to ignore global ~/.condarc
set "CONDARC=%MINIFORGE_DIR%\.condarc"
if not exist "%CONDARC%" type nul > "%CONDARC%"
REM --------------------------

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
call "%MAMBA_EXE%" create -y -p "%ENV_PREFIX%" python=3.12 -c conda-forge

REM 3. Install CompuCell3D into the NEW environment
echo Installing CompuCell3D into cc3d_env...
call "%MAMBA_EXE%" install -y -p "%ENV_PREFIX%" -c compucell3d -c conda-forge compucell3d=%version%

@REM removing bulky conda packages that were pulled during installation process
"%MAMBA_EXE%" clean --all --yes

echo Installation complete. 
echo To use CC3D, activate the environment: conda activate cc3d_env
echo call "%MINIFORGE_DIR%\condabin\activate.bat" "%ENV_PREFIX%"

endlocal


