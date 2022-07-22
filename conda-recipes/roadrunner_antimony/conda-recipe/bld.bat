
REM we are using env vars defined here:

REM https://docs.conda.io/projects/conda-build/en/latest/user-guide/environment-variables.html
REM %SP_DIR% points to target site_packages location


set source_site_packages=c:\Miniconda3\envs\rr\Lib\site-packages
echo "INSIDE BUILD SCRIPT"
rem robocopy %source_site_packages%\antimony  %SP_DIR%\antimony /s /e
xcopy /e /k /h /i %source_site_packages%\antimony  %SP_DIR%\antimony
xcopy /e /k /h /i %source_site_packages%\roadrunner  %SP_DIR%\roadrunner


