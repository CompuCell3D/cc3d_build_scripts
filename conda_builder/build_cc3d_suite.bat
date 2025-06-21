@echo off
set cc3d_repo_dir=d:\src\conda-build-repos\CompuCell3D\
set player_repo_dir=d:\src\conda-build-repos\cc3d-player5\
set twedit_repo_dir=d:\src\conda-build-repos\cc3d-twedit5\
set SCRIPT_DIR=%~dp0

IF "%1"=="" (
    SET PYTHON_VERSION=3.10
) ELSE (
    SET PYTHON_VERSION=%1
)


echo %PYTHON_VERSION%

@REM call :build_conda_package %cc3d_repo_dir%\conda-recipes %PYTHON_VERSION%
@REM call :build_conda_package %player_repo_dir%\conda-recipes %PYTHON_VERSION%
@REM call :build_conda_package %twedit_repo_dir%\conda-recipes %PYTHON_VERSION%
call :build_conda_package %cc3d_repo_dir%\conda-recipes-compucell3d %PYTHON_VESION%

exit /b

:build_conda_package
set conda_recipe_dir=%1
set py_version=%2
echo "working inside %conda_recipe_dir%"
cd %conda_recipe_dir%
move versions.yaml versions.yaml.bak
copy  %SCRIPT_DIR%\versions.yaml versions.yaml
call run_conda_build.bat %py_version%
move versions.yaml.bak versions.yaml
cd %SCRIPT_DIR% 


goto :eof