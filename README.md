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

**Also,** export the environment variable `ACCESS`, which Exodus uses
internally:

```bash
export ACCESS=$(pwd)/seacas
```

# Running the Python example

## Four Polygon Test

```bash
cd four-polygon-test
python2.7 ../py-lib/meshing_ats.py -n 10 -d 1 ./four_polygon.vtk
```
This will read in the 2D mesh `four_polygon.vtk` and extrude and write to
`four_polygon.exo`.

## Basic Example

```bash
python2.7 meshing_ats_example.py
```

This will use Numpy to generate a simple mesh in `meshing_ats_example.exo`.