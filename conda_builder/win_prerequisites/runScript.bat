@echo off
SET script_dir=%~dp0
@set CURRENT_DIRECTORY=%CD%

REM Resolve path to miniforge3 and activate cc3d_env
SET "MINIFORGE_DIR=%script_dir%\miniforge3"
SET "condabin=%MINIFORGE_DIR%\Scripts"
CALL "%condabin%\activate.bat" %MINIFORGE_DIR%\envs\cc3d_env

@SET exit_code=0
python -m cc3d.run_script %* --current-dir="%CURRENT_DIRECTORY%"
@SET exit_code=%errorlevel%

goto simulationend

:simulationend
   echo "SIMULATION FINISHED"
   cd %CURRENT_DIRECTORY%

exit /b %exit_code%
