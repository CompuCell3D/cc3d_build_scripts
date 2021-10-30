Preparing Windows Compilation
=============================

The preparation of windows dependencies can be as simple as downloading a zipped directory from
our download site - https://sourceforge.net/projects/cc3d/files/compile_dependencies/

However, if you are interested in exact steps that are required to prepare those dependencies we present them in
details below

Opening Cmake
-------------

it is best to open CMAKE directly from conda terminal. this way all the paths will be set up properly and
we can avoid errors that say that e.g. numpy cannot be found (because numpy-dependent library paths cannot be located
if the lookup paths are not set properly). Opening cmake gui from conda solves this issue. + picking swig installation
from conda is another bonus - we will avoid issues with missing .i or .swg files

Preparing dependencies
----------------------

Most of windows dependencies can be easily installed using conda
the list of installed packages is stored in ``conda_2020.txt``.

To build this list of exact packages in my conda repository I used the following command

.. code-block:: console

    conda list --explicit > conda_2020.txt

You may use ``conda_2020.txt`` to restore exact packages we installed using the following command

.. code-block:: console

    conda create --name conda_2020 --file conda_2020.txt

This command is not always guaranteed to succeed because conda dependencies are often removed from servers making
this method of freezing dependencies unreliable.

More information about conda can be found on

https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html

However if you install the following packages in your newly created conda environment you should be fine

.. code-block:: console

    conda install -c conda-forge vtk=8.2 scipy numpy=1.15 pandas jinja2 pyqt qscintilla2 webcolors pyqtgraph deprecated pywin32 chardet

    conda install -c compucell3d tbb_full_dev

The vkt library you install via conda is also used as a dependency for CC3D c++ modules. However, this conda
vtk compilation depends on 3rd party library tbb (Intel's thread building blocks library). Unfortunately this
library is not installed along with vtk so we need to do some minor patching as described below

To install dependencies

Adding TBB to conda environment - 3.7 - manual approach
-------------------------------

TBB is s C library so all we need to do is to grab binaries for windows from

https://github.com/intel/tbb/blob/master/download.md

For our purposes we used this direct link to grab pre-build windows tbb libraries

https://www.threadingbuildingblocks.org/sites/default/files/software_releases/windows/tbb43_20150611oss_win.zip

Assuming we are building 64-bit application we copy
**IMPORTANT** for 32-bit conda tbb seems to be included so below instructions apply to 64-bit only conda

first we copy ``include/tbb`` directory of the tbb binaries into ``c:/Miniconda3/envs/cc3d_2021_3.7/Library/include``
We need to also copy tbb libraries

We grab all files (*.lib extensions) from ``lib/intel64/vc12`` and place them in
``c:/Miniconda3/envs/cc3d_2021_3.7/Library/lib`` or altrnatively we grab them from
``CC3D_BUILD_SCRIPTS/windows/4.0.0/tbb/tbb_64bit_dist/lib`` - same applies to includes.


Alternative Adding TBB to conda environment - 2021 - new approach for python 3.7+ distributions
-----------------------------------------------------

To handle issue with missing developer files for tbb library that conda's vtk 8.2 depends on if you want to
link against those vtk library , we need can use ``tbb_full_dev`` package from ``compucell3d``
anaconda channel. to do so after you install all conda packages given earlier you would run

.. code-block:: console

    conda install -c compucell3d tbb_full_dev

One thing to be aware of is that binaries for tbb in this package have been compiled using
VS 2013 and you need to make sure that you install Visual C++ Redistributable Packages for Visual Studio 2013
64 bit. you can find them on microsoft site: https://www.microsoft.com/en-us/download/details.aspx?id=40784

For the binary installer that we prepare for CC3D we have added ``vc_redist_2013.x64.exe`` to the prerequisites
folder of the installer and this package will be automatically installed when we install CC3D.

We have added the following lines to the NSIS installer template to ensure that VS 2013 Redistributable gets
automaticaLL INSTALLED

.. code-block:: console

Section -Prerequisites

  SetOutPath $INSTDIR\Prerequisites
    File "${INSTALLATION_SOURCE_DIR}\Prerequisites\vc_redist_2015.x64.exe"
    ; ExecWait "$INSTDIR\Prerequisites\vcredist_x86.exe /q:a /c:$\"VCREDI~1.EXE /q:a /c:$\"$\"msiexec /i vcredist.msi /qb!$\"$\" $\""
    ExecWait "$INSTDIR\Prerequisites\vc_redist_2015.x64.exe /q /norestart"
    ; ExecWait "$INSTDIR\Prerequisites\vc_redist_2015.x64.exe /norestart"
    File "${INSTALLATION_SOURCE_DIR}\Prerequisites\vc_redist_2013.x64.exe"
    ExecWait "$INSTDIR\Prerequisites\vc_redist_2013.x64.exe  /install /quiet /norestart"

    Goto vs2008Libs
  vs2008Libs:

SectionEnd


This not optimal and alternative approaches could involve compiling tbb in VS2015 and including
developer files in the new tbb_full_dev package

Finding Missing libraries
-------------------------

One of the best ways to find missing libraries is to use ``Dependencies`` package

https://github.com/lucasg/Dependencies

a brief description how to use it efficiently is found here:
https://vxlabs.com/2017/12/06/how-to-debug-pyinstaller-dll-pyd-load-failed-issues-on-windows/

Simply put if you see failed dll load message you need to keep looking into dependencies of
various libraries that Dependencies opens as tabs and you will likely find a problematic entry

Adding TBB to conda environment - old way - used with python 3.6 - a bit more manual approach
-------------------------------

TBB is s C library so all we need to do is to grab binaries for windows from

https://github.com/intel/tbb/blob/master/download.md

For our purposes we used this direct link to grab pre-build windows tbb libraries

https://www.threadingbuildingblocks.org/sites/default/files/software_releases/windows/tbb43_20150611oss_win.zip

Assuming we are building 64-bit application we copy
**IMPORTANT** for 32-bit conda tbb seems to be included so below instructions apply to 64-bit only conda

``include/tbb`` directory of the tbb binaries into ``c:/Miniconda3/envs/cc3d_2020/Library/include/vtk-8.1`` .


In your case the exact location of conda environment you are creating might be different . The important part is to go
from the root of the environment - in my case ``c:/Miniconda3/envs/cc3d_2020`` to ``Library/include/vtk-8.1``.

Next we copy  tbb libraries

We grab all files (*.lib extensions) from ``lib/intel64/vc12`` and place them in
``c:/Miniconda3/envs/cc3d_2020/Library/lib``

The procedure for patching 32 bit conda is similar except we would copy all files (*.lib extensions)
from ``lib/ia32/vc12`` and place them inside ``Library/lib`` subfolder of your respective conda root

**Important** We also need to patch ``<python_root>/Python36/Library/lib/cmake/vtk-8.1/VTKTargets.cmake``

replace line

.. code-block:: python

    INTERFACE_LINK_LIBRARIES "\$<\$<NOT:\$<CONFIG:DEBUG>>:C:/Miniconda3/envs/cc3d_2020/Library/lib/tbb.lib>;\$<\$<CONFIG:DEBUG>:C:/Miniconda3/envs/cc3d_2020/Library/lib/tbb.lib>"

with

.. code-block:: python

    INTERFACE_LINK_LIBRARIES "${_IMPORT_PREFIX}/lib/tbb.lib"

This fix is necessary because during installation of vtk on your machine the installing script hard-codes path to
tbb library which is bad (conda issue)

So here we are replacing hardcoded path with a simple statement based on anchor directory cmake variable ${_IMPORT_PREFIX}

This os much better and is guaranteed to work on any machine

Adding libroadrunner and antimony
----------------------------------

After you activate your conda environment you also need to install libroadrunner
The best way is to use ``pip`` command by typing

.. code-block:: console

    pip install libroadrunner
    pip install antimony

If for some reason (usually incompatibility with your installed numpy version) importing roadrunner fails

you may try different versions of roadrunner. To get a list of available versions available via pip, type:

.. code-block:: console

    pip install libroadrunner==

This  is a bit of a hack but you will get list of libroadrunner versions in the following form

`` Could not find a version that satisfies the requirement libroadrunner== (from versions: 1.4.18, 1.4.23, 1.4.24, 1.5.1, 1.5.2, 1.5.3)
No matching distribution found for libroadrunner==``

Now you can try any particular version by typing for example

.. code-block:: console

    pip install libroadrunner==1.5.1

Updating qt.conf
----------------
In order for qt installation to functionproperly on any system where we distrivuter Python36 we need to
update ``<conda_env>/qt.conf`` as follows

.. code-block:: console

    [Paths]
    Prefix = ./Library
    Binaries = ./Library/bin
    Libraries = ./Library/lib
    Headers = ./Library/include/qt


and ``<conda_env>/Library/bin/qt.conf`` :

.. code-block:: console

    [Paths]
    Prefix = ../
    Binaries = ../bin
    Libraries = ../lib
    Headers = ../include/qt

Updating plugin/platforms - 32bit only
--------------------------------------

For 32bit prerequisites we also need to make sure that ``<conda_env>/Library/plugins/platforms/qwindows.dll``
ends up in  ``<cc3d_install_folder>/bin/platrofms``
so the best way is tro create prerequisites folder ``<prerequisites_folder>/bin/platrofms`` and copy there
the ``qwindows.dll``

Copy icons for NSIS
-------------------

Copy all icons from ``nsis_icons`` to ``c:/Program Files (x86)/NSIS/Contrib/Graphics/Icons/``


Patching pyqtgraph - no longer necessary
----------------------------------------

**Note:** this procedure is no longer necessary . We are including it as a reference of what was required in previous
versions of CC3D and just in case anybody encounters pyqtgraph import issues

In previous versions we had to modify  <conda_env_root>\Lib\site-packages\pyqtgraph\widgets\GraphicsView.py
by replacing

.. code-block:: python

        from .. import _connectCleanup
        _connectCleanup()

with

.. code-block:: python

        from pyqtgraph import _connectCleanup
        _connectCleanup()

        # from .. import _connectCleanup
        # _connectCleanup()

We are not doing it anymore

