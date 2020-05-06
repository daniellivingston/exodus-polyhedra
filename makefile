#================================================================#
#  Exodus Makefile
# -------------------------------------------------------------- #
#  
#  Targets:
#    - exodus : build the Exodus library
#    - test : run the LaGriT test suite
#    - help : show a help screen
#    - header : build src/lagrit.h header file
#    - clean : remove all object and mod files
#    - clobber : remove all object and mod files *and* library
#
#  Variables:
#    CC (default: gcc) : C source compiler
#    FC (default: gfortran) : Fortran source compiler
#    FC90 (default: gfortran) : Fortran90 source compiler
#    EXO_LIB_DIR (default: LAGRIT_ROOT_DIR/seacas/lib) : ExodusII library location
#    EXO_CMAKE_FLAGS (default: none) : Add custom CMake flags to pass to cmake-exodus
#================================================================#

CC := gcc
CXX := g++
FC := gfortran
FC90 := $(FC)

EXO_BUILD_DIR := $(shell pwd)
EXO_LIB_DIR := $(shell pwd)/seacas/lib
EXO_CMAKE_FLAGS := 

.PHONY: exodus

exodus :
	set -e; \
	export CGNS=OFF; \
	export MATIO=OFF; \
	export SHARED=NO; \
	export LG_DIR=`pwd`; \
	export NEEDS_ZLIB=YES; \
	export GNU_PARALLEL=OFF; \
	export BUILD=YES; \
	export CC=$(CC); export CXX=$(CXX); \
	git clone --depth 1 https://github.com/gsjaardema/seacas.git $(EXO_BUILD_DIR)/seacas || true; \
	cd $(EXO_BUILD_DIR)/seacas; \
	export ACCESS=`pwd`; \
	if [[ `uname -s` == *"CYGWIN"* ]]; then \
		BUILD=NO ./install-tpl.sh; \
		sed -i 's/defined(_WIN32) || defined(__CYGWIN__)/defined(_WIN32)/g' `ls -t -d TPL/zlib-* | head -1`/gzguts.h; \
		export DOWNLOAD=NO; \
	fi; \
	./install-tpl.sh; \
	cd TPL; \
	../cmake-exodus $(EXO_CMAKE_FLAGS); \
	make && make install; \
	cd $(LG_DIR); \
	echo "Exodus successfully built!"; \
	echo "Build directory:"; \
	echo "   $(EXO_BUILD_DIR)/seacas/"