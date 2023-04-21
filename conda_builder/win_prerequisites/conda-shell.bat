SET script_dir=%~dp0
echo %script_dir%

@set CURRENT_DIRECTORY=%CD%

REM activate miniconda
SET condabin=%script_dir%Miniconda3\condabin
@CALL "%condabin%\activate.bat" activate "%script_dir%\Miniconda3"





