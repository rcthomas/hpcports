loaded=`${MODULESHOME}/bin/modulecmd sh -t list 2>&1 | grep PrgEnv-gnu`
if [ "x${loaded}" = x ]; then
    module swap PrgEnv-intel PrgEnv-gnu
    module unload cray-shmem
    module swap gcc gcc/4.7.2
    module swap craype craype/1.05
    module swap cray-mpich cray-mpich/6.0.0
    module load mkl/13.0.1
    module load git/1.8.1.1
    module load python/2.7.3
    module load zlib/1.2.7
    module load curl/7.28.1
    module load mpi4py/1.3
    module load cmake/2.8.10.2
    module load bzip2/1.0.6
fi
