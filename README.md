# Building Exodus

A Makefile is provided to ease to process of building Exodus. Just run:

    make exodus

and it will be downloaded to `./seacas/` and built. You will need CMake 3.10+,
gcc and g++.

# Configuring the Python example

A Python script is included in this directory (`meshing_ats.py`) which takes 
a general 2D mesh and extrudes it into 3D, writing out an Exodus file.

This script was written by Ethan Coon as part of the Amanzi/ATS project and can 
originally be found [here](https://github.com/amanzi/ats/tree/master/tools/meshing_ats/meshing_ats).

## Configuring `python-exodus`

This script uses the Exodus Python library to make calls to the compiled
C library. 

To get Python to find the `exodus-python` package, either append the SEACAS 
library path to your `PYTHONPATH`:

```bash
export PYTHONPATH=$PYTHONPATH:$(pwd)/seacas/lib
```

Or set the `SEACAS_DIR` environment variable:

```bash
export SEACAS_DIR=$(pwd)/seacas
```

## Adding 

# Running the Python example

