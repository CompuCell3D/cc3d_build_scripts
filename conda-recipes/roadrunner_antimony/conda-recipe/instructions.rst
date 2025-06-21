Note that for OSX cc3d-networks (for x86 OSX ) need to be build on actual x86 OSX machine.
Otherwise you may get this error:

.. code-block:: console


        self._handle = _dlopen(self._name, mode)
    OSError: dlopen(/Users/m/CompuCell3D/miniconda3/compucell3d.app/Contents/lib/python3.10/site-packages/antimony/libantimony.dylib, 6): Symbol not found: __ZNKSt3__115basic_stringbufIcNS_11char_traitsIcEENS_9allocatorIcEEE3strEv
      Referenced from: /Users/m/CompuCell3D/miniconda3/compucell3d.app/Contents/lib/python3.10/site-packages/antimony/libantimony.dylib (which was built for Mac OS X 12.0)
      Expected in: /usr/lib/libc++.1.dylib


Before building yu need to install conda env , call it rr (see .bat or.sh scripts)
install numpy that cc3d is using (e.g. numpy=1.21 or 1.24 for python >=3.8) for compilation, pip install roadrunner
and antimony


mamba install -c conda-forge numpy=2.2.6

or you can create the env directly


conda create -n rr_python3.12 -c conda-forge python=3.12 numpy=2.2.6

then add libroadrunner and antimony

pip install  libroadrunner antimony


you may suppress dependencies if you want but with numpy installed beforehand it is not necessary

pip install --no-deps libroadrunner antimony


For OSX on x86 it might be useful to set SDKROOT=/opt/MacOSX10.10.sdk prior to pip install

on linux you may need to copy libncurses.so.5 libform.so.5 libtinfo.so.5 to site-packages/roadrunner

change python version in meta.yaml and in build.sh/build.bat

and then run install




To build a conda package to the following (make sure you are in a base environment!):

.. code-block:: console

    cd <dir_containing_conda_recipe>

From base conda environment run:

NOTE: you may actually change version of python in the meta.yaml file also adjust python version in build.sh or build.bat

for x86
.. code-block:: console

    conda mambabuild  . -c conda-forge -c local -c compucell3d --python 3.10 -e conda_build_config_x86.yaml

    or

    conda build  . -c conda-forge -c local -c compucell3d --python 3.10 -e conda_build_config_x86.yaml

for arm64
.. code-block:: console

    conda mambabuild  . -c conda-forge -c local -c compucell3d --python 3.10 -e conda_build_config_arm64.yaml

    or

    conda build  . -c conda-forge -c local -c compucell3d --python 3.10 -e conda_build_config_arm64.yaml


Your package will be built in ``<conda_installation_dir>/conda-bld/noarch``

Then repeat with

.. code-block:: console

    conda-build  . --python=3.7

and so on for all python versions you plan on supporting

To install just-built conda package create conda environment (or use existing one) and run:

.. code-block:: console

    conda install <your package name> -c local


To clean up after multiple installs go to ``<conda_installation_dir>/conda-bld`` and remove
all directories that begin with ``pipeline_common_xxxxx`` where ``xxxx`` denotes stamp that conda
gives to each work directory it creates or run

.. code-block:: console

    conda build purge-all

Remarks
-------

When your build does not include platform specific code - think SWIG C/C++ extensions dll, so etc
then putting

.. code-block:: python

    build:
      noarch: generic

In the ``meta.yaml`` is a good strategy.

Otherwise comment ``noarch:generic`` line and build platform-specific package

Useful documentation:
https://docs.conda.io/projects/conda-build/en/latest/user-guide/tutorials/building-conda-packages.html#building-with-a-python-version-different-from-your-miniconda-installation

https://conda.io/projects/conda-build/en/latest/resources/commands/index.html



