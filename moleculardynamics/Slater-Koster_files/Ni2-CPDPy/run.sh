#!/bin/bash

export OMP_NUM_THREADS=1
#NCPU=`grep 'core id' /proc/cpuinfo | sort -u | wc -l`
#echo "Number of CPU: "${NCPU}
#MPI_PREFIX="mpirun -np ${NCPU}"
MPI_PREFIX="mpirun -np 8"

${MPI_PREFIX} dftb+ < dftb_in.hsd | tee dftb_out_scf.hsd
