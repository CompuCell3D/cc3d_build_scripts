Git Hubflow Workflow on Windows
===============================

Hotfix
------
.. code-block:: console

    git flow hotfix start 4.2.4.1


make edits

.. code-block:: console

    git flow hotfix finish 4.2.4.1

on the popup screen update tag (you are in the vi editor then)

then to be safe

.. code-block:: console

    git push origin --tags

and do not forget to push branches to origin (both develop and master  may need to be pushed)

.. code-block:: console

    git checkout master
    git push

.. code-block:: console

    git checkout develop
    git push