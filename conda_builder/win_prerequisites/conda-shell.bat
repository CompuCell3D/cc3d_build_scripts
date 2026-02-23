@echo off
SET script_dir=%~dp0
@set CURRENT_DIRECTORY=%CD%

REM Resolve path to miniforge3 and activate cc3d_env
SET "MINIFORGE_DIR=%script_dir%\miniforge3"
SET "condabin=%MINIFORGE_DIR%\condabin"
CALL "%condabin%\activate.bat" cc3d_env

@REM SET script_dir=%~dp0
@REM echo %script_dir%
@REM
@REM @set CURRENT_DIRECTORY=%CD%
@REM
@REM REM activate miniconda
@REM SET condabin=%script_dir%Miniconda3\condabin
@REM @CALL "%condabin%\activate.bat" activate "%script_dir%\Miniconda3"





