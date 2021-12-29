%SystemDrive%

start /wait "" Miniconda3-latest-Windows-x86_64.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%SystemDrive%/CompuCell3D

# to get anaconda prompt
%windir%\System32\cmd.exe "/K" C:\Miniconda3\Scripts\activate.bat C:\Miniconda3

conda install -y -c compucell3d -c conda-forge compucell3d=4.3.0