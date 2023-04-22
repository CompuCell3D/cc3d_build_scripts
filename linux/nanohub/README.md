# Compiling CC3D Manually - Target Deployment Nanohub

This set of instructions targets CC3D 4.4.0 with Python 3.7. 

Note: the easies was to install CompuCell3D is to use binary installers or install CompuCell3D
as a conda package. If thisi s not an option for your system setup below we present a set of manual steps that will help you to compile CC3D on your system. If for some reason you eencounter difficulties
or issues during compilation or deployment of CompuCell3D please contact us.

we have testd the procedure outlined in this writeup on Ubuntu 20.04

## Repositories:

CompuCell3D: https://github.com/CompuCell3D/CompuCell3D
cc3d-player: https://github.com/CompuCell3D/cc3d-player5
cc3d-twedit5: https://github.com/CompuCell3D/cc3d-twedit5

## PRerequisites

CC3D has has few compile dependencies:

- python=3.7
- vtk=9.2
- swig=4
- eigen
- cmake=3.21 (but earlier versions e.g. 3.16 shoould work as well)
- numpy=1.21
- boost=1.78 (only if your vtk installation requires it)
- tbb (only if your vtk installation requires it)
- gcc and g++ compoilers - standard gcc and g++ bundled with ubuntu20.04 will work just fine
- deprecated - a python package

in my case I have used conda python distribution to install thodde prerequisites. If you do not use conda you will have to install those dependencies using differnt methods (e.g. pip install, or manual compilation)  


```commandline

conda create -n cc3d_linux_manual_37 python=3.7
conda activate cc3d_linux_manual_37

conda install -c conda-forge numpy=1.21 vtk=9.2 boost=1.78 tbb-devel=2021 swig=4 cmake=3.21 deprecated   
```

Once you have installed the dependencies you are ready to compile cc3d. To do so you would modify 
`run_cmake_manual.sh` script to set paths to the compile dependencies

Here is the entire script (note the actual content may vary so please check the latest version of the file in the git repository)

```bash
# CC3D repo gets cloned to /home/m/src/CompuCel3D
# but we go one dir deeper to /home/m/src/CompuCel3D/CompuCell3D
# so that CC3D_SRC_DIR points to the "top level" dir that has CmakeLIsts.txt  
CC3D_GIT=/home/m/src/CompuCell3D
CC3D_SRC_DIR=$CC3D_GIT/CompuCell3D
# this is where we want cc3d to be installed
PREFIX=/home/m/install_projects/cc3d
# path to python executable
PYTHON=/home/m/miniconda3/envs/cc3d_linux_manual_37/bin/python
# this is where temporary build files will get stored
BUILD_DIR=/home/m/install_projects/cc3d_build
# we are indicating here that we want cmake to generate makefiles - note you may use different cmake generators
CMAKE_GENERATOR="Unix Makefiles"

SWIG_EXECUTABLE=/home/m/miniconda3/envs/cc3d_linux_manual_37/bin/swig
VTK_DIR=/home/m/miniconda3/envs/cc3d_linux_manual_37/lib/cmake/vtk-9.2

mkdir -p $BUILD_DIR
cd $BUILD_DIR

cmake -G "${CMAKE_GENERATOR}" \
      -DCMAKE_BUILD_TYPE:STRING=Release \
      -DCMAKE_PREFIX_PATH:PATH=${PREFIX} \
      -DCMAKE_FIND_ROOT_PATH:PATH=${PREFIX} \
      -DCMAKE_INSTALL_PREFIX:PATH=${PREFIX} \
      -DCMAKE_INSTALL_RPATH:PATH=${PREFIX}/lib \
      -DBUILD_SHARED_LIBS:BOOL=ON \
      -DNO_OPENCL:BOOLEAN=ON \
      -DBUILD_STANDALONE:BOOLEAN=ON \
      -DPython3_EXECUTABLE:PATH=${PYTHON} \
      -DSWIG_EXECUTABLE=${SWIG_EXECUTABLE} \
      -DVTK_DIR:PATH=${VTK_DIR} \
      "${CC3D_SRC_DIR}"

make -j 4
make install
```

It is a relatively simple script that runs cmake configuration and then compiles the package. 
It will not be uncommon to see errors during cmake configuration especially if your setup differs from miine but in most cases the erros indicate misconfigured path or missing package. If you are stuck let us know and we will help you debug your issue. 

Now, at the top of script there are few variables defined - they point to where various dependencies are installed. Most likely you will need to change those paths following comments included in the script
Here are the variables that you will likely need to adjust:

- CC3D_GIT - path to hwere you cloned COmpuCell3D git repository
- PREFIX - path where you woudl like CC3D to be installed
- BUILD_DIR - path where all Makefiles, compilation output will go to 
- PYTHON - path to the python interpreter
- SWIG_EXECUTABLE -  path pointing to swig 4.x executable\
- VTK_DIR - path pointing to a directory where vtk-config.cmake file resides

Once you do those adjustments you are ready to build CC3D:

simply make this script executable:

```comandline
chmod +x run_cmake_manual.sh
```

and run it:

```
./run_cmake_manual.sh
```


Once the compilation finishes you woudl need to copy few files into your python distribution. 

1. You would copy the content of `$PREFIX/lib/site-packages` (in my case `/home/m/install_projects/cc3d/lib/site-packages/cc3d`) to `site-packages` directory of your python (in my case to `/home/m/miniconda3/envs/cc3d_linux_manual_37/lib/python3.7/site-packages`)

```commandline
cp -R /home/m/install_projects/cc3d/lib/site-packages/cc3d /home/m/miniconda3/envs/cc3d_linux_manual_37/lib/python3.7/site-packages
```

2. Copy all shared libraries -  `.so` files from `$PREFIX/lib` into `lib` folder of your python distribution (in my case `/home/m/miniconda3/envs/cc3d_linux_manual_37/lib`) 


```commandline
cp /home/m/install_projects/cc3d/lib/*.so /home/m/miniconda3/envs/cc3d_linux_manual_37/lib
```

3. edit `run_scripts/runScript.sh` (file in the repository) so that all the hardcoded paths correspond to your setup: PYTHON_EXEC, PYTHONPATH and LD_LIBRARY_PATH will need to be adjusted


Once you do it you should be able to run CC3D in the  gui-less mode:

```
./runScript.sh -i /home/m/install_projects/cc3d/Demos/Models/bacterium_macrophage/bacterium_macrophage.cc3d --log-level INFORMATION
```

Note, you will need to adjust psth to Demos folder from `/home/m/install_projects/cc3d/Demos` to $PREFIX/Demos  

## Installing CompuCell3D Player and Twedit++

Compiling CC3D was the hard part. Now if you want to manually install CC3D PLayer and Twedit all you need to do is to make sure that all python dependencies for those two packages are installed and then 
the actual installation of Player and Twedit will involve just simple directory copy.

Let's install Python dependencies int our Python environment what we need are the following packages:

- qscintilla2
- webcolors
- requests
- pyqt=5
- pyqtgraph
- chardet
- pyqtwebkit
- sphinx

This is how you can install them using conda:

```commandline
conda install -c conda-forge qscintilla2 webcolors requests pyqt=5 pyqtgraph chardet pyqtwebkit sphinx

```

The next step is simple directory copy. First lets copy player5 directory form cc3d-player repository dir to the location where we copied cc3d package when we installed CC3D

```commandline
 cp -R /home/m//src/conda-build-repos/cc3d-player5/cc3d/player5/  /home/m/miniconda3/envs/cc3d_linux_manual_37/lib/python3.7/site-packages/cc3d/

```

note, in my case cc3d player repository was cloned to `/home/m//src/conda-build-repos/cc3d-player5`

We do exactly the same for twedit5:

```commandline
cp -R /home/m//src/conda-build-repos/cc3d-twedit5/cc3d/twedit5/  /home/m/miniconda3/envs/cc3d_linux_manual_37/lib/python3.7/site-packages/cc3d/
```

Finally you will need to edit `compucell3d.sh` and `twedit++.sh` scripts to provide paths appropriate for your setup - see examples in [Run Scripts](./run_scripts)








