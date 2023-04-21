SET script_dir=%~dp0
echo %script_dir%

@set CURRENT_DIRECTORY=%CD%

REM activate miniconda
@CALL "%script_dir%\Miniconda3\condabin\activate.bat" "%script_dir%\Miniconda3"


@SET exit_code=0
python -m cc3d.player5 %* --currentDir="%CURRENT_DIRECTORY%"
@SET exit_code= %errorlevel%

goto simulationend

:simulationend
   echo "SIMULATION FINISHED"
   cd %CURRENT_DIRECTORY%

exit /b %exit_code%




