SET script_dir=%~dp0
echo %script_dir%

@set CURRENT_DIRECTORY=%CD%

REM activate miniconda
@CALL "%script_dir%\Miniconda3\condabin\activate.bat"





