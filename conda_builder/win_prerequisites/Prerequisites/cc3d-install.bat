@echo off
setlocal enabledelayedexpansion

REM Get CompuCell3D version from first argument
set "version=%1"
echo Installing CompuCell3D version: %version%

REM Resolve path to Miniconda3 relative to script location
set "BASE_DIR=%~dp0\.."  REM one level up from Prerequisites
pushd "%BASE_DIR%\Miniconda3"
set "MINICONDA_DIR=%CD%"
popd

set "CONDA_BAT=%MINICONDA_DIR%\condabin\conda.bat"
set "MAMBA_BAT=%MINICONDA_DIR%\condabin\mamba.bat"

echo Using Miniconda from: %MINICONDA_DIR%

REM Ensure conda.bat exists
if not exist "%CONDA_BAT%" (
    echo ERROR: conda.bat not found at %CONDA_BAT%
    exit /b 1
)

REM Activate base env
@REM call "%CONDA_BAT%" activate base
call %MINICONDA_DIR%\condabin\activate.bat activate %MINICONDA_DIR%

 echo Installing mamba locally... "%conda_bat%"
REM Install mamba into local Miniconda
call "%CONDA_BAT%" install -y -c conda-forge mamba

REM Ensure mamba installed
if not exist "%MAMBA_BAT%" (
    echo ERROR: mamba.bat not found at %MAMBA_BAT%
    exit /b 1
)

REM Install CompuCell3D using local mamba
call "%MAMBA_BAT%" install -y -c main -c compucell3d -c conda-forge compucell3d=%version%

endlocal

@REM @echo off
@REM @REM needed to avoid issues introduces by the new mamba - we can also execute this command: chcp 65001
@REM set PYTHONIOENCODING=utf-8
@REM
@REM set version=%1
@REM echo "WILL INSTALL COMPUCELL3D VERSION =" %version%
@REM SET script_dir=%~dp0
@REM
@REM @REM get absolute paths
@REM @REM using https://stackoverflow.com/questions/1645843/resolve-absolute-path-from-relative-path-and-or-file-name
@REM set condabin_dir=
@REM set condabin_dir_rel= %script_dir%\..\Miniconda3\condabin
@REM pushd %condabin_dir_rel%
@REM set condabin_dir=%CD%
@REM popd
@REM
@REM set conda_bat=%condabin_dir%\conda.bat
@REM set mamba_bat=%condabin_dir%\mamba.bat
@REM call %conda_bat% activate base
@REM
@REM call %conda_bat% install -y -c conda-forge mamba
@REM
@REM call %mamba_bat% install -y -c main -c compucell3d -c conda-forge compucell3d=%version%
@REM
@REM
