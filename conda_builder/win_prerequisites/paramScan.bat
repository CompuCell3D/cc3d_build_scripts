SET script_dir=%~dp0
echo %script_dir%

@set CURRENT_DIRECTORY=%CD%

REM activate miniconda
SET condabin=%script_dir%Miniconda3\condabin
@CALL "%condabin%\conda.bat" activate base


@SET exit_code=0
python -m cc3d.core.param_scan.parameter_scan_run %* 
@SET exit_code= %errorlevel%

goto simulationend

:simulationend
   echo "SIMULATION FINISHED"
   cd %CURRENT_DIRECTORY%

exit /b %exit_code%




