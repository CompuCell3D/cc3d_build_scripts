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