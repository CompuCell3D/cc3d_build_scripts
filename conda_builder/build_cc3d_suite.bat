@echo off
set cc3d_repo_dir=d:\src\conda-build-repos\CompuCell3D\
set player_repo_dir=d:\src\conda-build-repos\cc3d-player5\
set twedit_repo_dir=d:\src\conda-build-repos\cc3d-twedit5\
set SCRIPT_DIR=%~dp0

echo %SCRIPT_DIR%
@REM build cc3d

@REM cd %cc3d_repo_dir%\conda-recipes
@REM move %cc3d_repo_dir%\conda-recipes\versions.yaml versions.yaml.bak
@REM copy  %SCRIPT_DIR%\versions.yaml %cc3d_repo_dir%\conda-recipes\versions.yaml
@REM move %cc3d_repo_dir%\conda-recipes\versions.yaml.bak versions.yaml
@REM cd %SCRIPT_DIR%

@REM call :build_conda_package %cc3d_repo_dir%\conda-recipes
call :build_conda_package %player_repo_dir%\conda-recipes
call :build_conda_package %twedit_repo_dir%\conda-recipes
call :build_conda_package %cc3d_repo_dir%\conda-recipes-compucell3d

exit /b

:build_conda_package
set conda_recipe_dir=%1
cd %conda_recipe_dir%
move versions.yaml versions.yaml.bak
copy  %SCRIPT_DIR%\versions.yaml versions.yaml
call run_conda_build.bat
move versions.yaml.bak versions.yaml
cd %SCRIPT_DIR% 


goto :eof