@echo off
SET script_dir=%~dp0
@set CURRENT_DIRECTORY=%CD%

REM Resolve path to miniforge3 and activate cc3d_env
SET "MINIFORGE_DIR=%script_dir%\miniforge3"
SET "condabin=%MINIFORGE_DIR%\condabin"
CALL "%condabin%\activate.bat" cc3d_env

