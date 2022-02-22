Building OSX/linux bundle
=========================

Note: Entry script to generated installer is decompress - this is where we shold add command line options

This recipe is based on the following article

https://www.supertechcrew.com/create-self-extracting-running-archive/

First, ``cd`` to ``mac/conda_installer/bundled_installer`` and create ``payload`` directory where you put
all the files that need to be copied to the target machine + the ``installer`` script. Note the name has to be exactly
``installer``. ``installer`` script will be executed after the archive is self-extrated, files are copied
into target place.

Step 1.

After you placed all the files in the payload do this

.. code-block:: console

    cd mac/conda_installer/bundled_installer
    ./build.sh

this will create ``cc3d-installer-osx.sh``

Step 2.

To install CC#D via self-extracting archive that installs miniconda and then installs CC#D run this

.. code-block:: console

    ./cc3d-installer-osx.sh <cc3d_installation_folder - compulsory arg> [cc3d version]

Exaample

.. code-block:: console

    ./cc3d-installer-osx.sh /Users/m/CC3D 4.3.0






