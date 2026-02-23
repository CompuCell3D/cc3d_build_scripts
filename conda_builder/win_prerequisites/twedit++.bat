@echo off
SET script_dir=%~dp0
@set CURRENT_DIRECTORY=%CD%

REM Resolve path to miniforge3 and activate cc3d_env
SET "MINIFORGE_DIR=%script_dir%\miniforge3"
SET "condabin=%MINIFORGE_DIR%\condabin"
CALL "%condabin%\activate.bat" cc3d_env

@SET exit_code=0
python -m cc3d.twedit5 %* @SET exit_code=%errorlevel%

goto simulationend

:simulationend
   echo "SIMULATION FINISHED"
   cd %CURRENT_DIRECTORY%

exit /b %exit_code%

@REM SET script_dir=%~dp0
@REM echo %script_dir%
@REM
@REM @set CURRENT_DIRECTORY=%CD%
@REM
@REM REM activate miniconda
@REM SET condabin=%script_dir%Miniconda3\condabin
@REM @REM @CALL "%condabin%\conda.bat" activate base
@REM @CALL "%condabin%\activate.bat"  %script_dir%Miniconda3
@REM
@REM @SET exit_code=0
@REM python -m cc3d.twedit5 %*
@REM @SET exit_code= %errorlevel%
@REM
@REM goto simulationend
@REM
@REM :simulationend
@REM    echo "SIMULATION FINISHED"
@REM    cd %CURRENT_DIRECTORY%
@REM
@REM exit /b %exit_code%




