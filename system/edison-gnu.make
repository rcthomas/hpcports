
# use this prefix (set from the command line) to update the 
# live hpcports install used by many people
#
#export HPCP_PREFIX=/project/projectdirs/cmb/modules/edison/hpcports_gnu

# OS environment version
#
# For edison, bump the major version when upgrading compilers and bump
# the minor version when upgrading MPI or vendor libs.  Document configuration
# here:
#
# 1.0 :  gnu 4.7.2, cray-mpich2 5.6.1, cray-libsci 12.0.00, fftw 3.3.0.1, python 2.7.3
# 2.0 :  gnu 4.7.2, cray-mpich 6.0.0, mkl-13.0.1, fftw-3.3.0.3, python-2.7.3
# 3.0 :  gnu 4.8.1, cray-mpich 6.0.2, mkl-13.0.1, python-2.7.3
#

HPCP_ENV = 3.0

# suffix, to avoid name collisions with nersc modules

HPCP_MOD_SUFFIX = -hpcp

# software download location

HPCP_POOL = /project/projectdirs/cmb/modules/hpcports_pool

# toolchain (gnu, darwin, intel, ibm)

TOOLCHAIN = gnu
BUILD_DYNAMIC = FALSE

# UNIX tools

SHELL = /bin/bash
MAKE = make -s

# permissions on installed files

INST_GRP = cmb
INST_PERM = g+rwX,o+rX

# serial compilers

CC = cc
CXX = CC
F77 = ftn
FC = ftn

# MPI compilers

openmpi_OVERRIDE = TRUE
openmpi_VERSION = cray.mpich2
MPICC = cc
MPICXX = CC
MPIF77 = ftn
MPIFC = ftn
MPILIB = mpich

# compile flags

CFLAGS = -O3 -static -fPIC -DNDEBUG
CXXFLAGS = -O3 -static -fPIC -DNDEBUG
FFLAGS = -O3 -static -fPIC -DNDEBUG
FCFLAGS = -O3 -static -fPIC -DNDEBUG

# OpenMP flags

OMPFLAGS = -fopenmp

# Fortran mixing
FLIBS = /opt/gcc/4.7.2/snos/lib64/libgfortran.a
FCLIBS = /opt/gcc/4.7.2/snos/lib64/libgfortran.a
MPIFCLIBS =

# Linking

LIBS = -lm
LDFLAGS =
LIBTOOLFLAGS = --preserve-dup-deps

# vendor math libraries

VENDOR = intel
INTEL_PREFIX = /opt/intel/composer_xe_2013.1.117
INTEL_INCLUDE = $(INTEL_PREFIX)/mkl/include
INTEL_LIBDIR = $(INTEL_PREFIX)/mkl/lib/intel64
INTEL_LIBS_CC = $(INTEL_LIBDIR)/libmkl_intel_lp64.a $(INTEL_LIBDIR)/libmkl_gnu_thread.a $(INTEL_LIBDIR)/libmkl_core.a $(INTEL_LIBDIR)/libmkl_intel_lp64.a $(INTEL_LIBDIR)/libmkl_gnu_thread.a $(INTEL_LIBDIR)/libmkl_core.a $(INTEL_LIBDIR)/libmkl_intel_lp64.a $(INTEL_LIBDIR)/libmkl_gnu_thread.a $(INTEL_LIBDIR)/libmkl_core.a -ldl -lpthread -lm
INTEL_LIBS_CXX = $(INTEL_LIBS_CC)
INTEL_LIBS_F77 = $(INTEL_LIBS_CC)
INTEL_LIBS_FC = $(INTEL_LIBS_CC)

# package overrides

termcap_OVERRIDE = TRUE
termcap_VERSION = 2.0.8

readline_OVERRIDE = TRUE
readline_VERSION = 5.2

gzip_OVERRIDE = TRUE
gzip_VERSON = 1.3.12

gettext_OVERRIDE = TRUE
gettext_VERSION = 0.17.0

gitgit_OVERRIDE = TRUE
gitgit_VERSION = 1.8.1.1

# module load zlib/1.2.7

zlib_OVERRIDE = TRUE
zlib_VERSION = 1.2.7

# module load bzip2/1.0.6

bzip2_OVERRIDE = TRUE
bzip2_VERSION = 1.0.6

openssl_OVERRIDE = TRUE
openssl_VERSION = 0.9.8

# module load curl/7.28.1

curl_OVERRIDE = TRUE
curl_VERSION = 7.28.1

# module load python/2.7.3

python_OVERRIDE = TRUE
python_SITE = python2.7
python_VERSION = 2.7.3

cmake_OVERRIDE = TRUE
cmake_VERSION = 2.8.10.2

nose_OVERRIDE = TRUE
nose_VERSION = 1.1.2

numpy_OVERRIDE = TRUE
numpy_VERSION = 1.6.2

scipy_OVERRIDE = TRUE
scipy_VERSION = 0.11.0

pyfits_OVERRIDE = TRUE
pyfits_VERSION = NA

# module load ipython/0.13.1

ipython_OVERRIDE = TRUE
ipython_VERSION = 0.13.1

matplotlib_OVERRIDE = TRUE
matplotlib_VERSION = 1.1.0

# module load mpi4py/1.3

mpi4py_OVERRIDE = TRUE
mpi4py_VERSION = 1.3

pyslalib_OVERRIDE = TRUE
pyslalib_VERSION = NA

scientific_OVERRIDE = TRUE
scientific_VERSION = NA

healpy_OVERRIDE = TRUE
healpy_VERSION = NA

numexpr_OVERRIDE = TRUE
numexpr_VERSION = NA

# we get BLAS and Lapack from MKL

blas_OVERRIDE = TRUE
blas_VERSION = 13.0.1
blas_LIBS_CC = $(INTEL_LIBS_CC)
blas_LIBS_CXX = $(INTEL_LIBS_CXX)
blas_LIBS_F77 = $(INTEL_LIBS_F77)
blas_LIBS_FC = $(INTEL_LIBS_FC)

lapack_OVERRIDE = TRUE
lapack_VERSION = 13.0.1
lapack_LIBS_CC = $(MKL_LIBDIR)/libmkl_lapack95_lp64.a
lapack_LIBS_CXX = $(MKL_LIBDIR)/libmkl_lapack95_lp64.a
lapack_LIBS_F77 = $(MKL_LIBDIR)/libmkl_lapack95_lp64.a
lapack_LIBS_FC = $(MKL_LIBDIR)/libmkl_lapack95_lp64.a

