#!/bin/bash

# Usage
# chmod +x run.sh
# ./run.sh 300.0 10
# command temp #cycles

#--------------------------------------------------------------------------

if [ ! "$1" == "" ]; then
  Temp=$1
else
  echo "------------------"
  echo "Auto set 300 K"
  Temp=300.0 # [K]
fi
# Boltzmann constant = 8.617333262e-5 [eV/K] (check: about 1/40 [eV] at 300 [K])
kbT=`echo ${Temp} | awk '{printf "%f",(8.6173e-5*$1)}'`
echo "kbT = "${kbT}" [eV]"

if [ ! "$2" == "" ]; then
  Ncycles=$2
else
  echo "------------------"
  echo "Auto set 10 cycles"
  Ncycles=10
  echo "------------------"
fi

mopac=/usr/local/bin/mopac
export OMP_NUM_THREADS=8
NCPU=1

#--------------------------------------------------------------------------

#--------------------------------------------------------------------------

sed -i "s/\r//g" input.mop

#---------------------------------------------------
natoms=`awk '
  BEGIN{ flag = 0 }
  { 
    if($1=="Tv" && flag==0){
      printf "%d",(NR-1-3)
      flag = 1
    }
  }
  END{}' input.mop`
echo "Number of atoms: "${natoms}
#---------------------------------------------------

cp input.mop input.mop_original
cp input.mop input.mop_tmp

mpirun -np ${NCPU} ${mopac} input.mop

# Formation Energy [eV] (KCAL/MOL -> eV)
FE_old=`awk '{if($1=="FINAL" && $2=="FORMATION"){printf "%f",($6*0.0434)}}' input.out`

#--------------------------------------------------------------------------


#--------------------------------------------------------------------------

for i in `seq 1 ${Ncycles}`
do
  echo "-----------------------------------------------------"
  echo "No. $i cycle"
  #
  echo "-------------"
  R1=`echo $(( $RANDOM % ${natoms} + 1 + 3))`
  ratom1=`awk -v R1=${R1} '{if(NR==R1){print $1}}' input.mop_tmp`
  xR1=`awk -v R1=${R1} '{if(NR==R1){print $2}}' input.mop_tmp`
  yR1=`awk -v R1=${R1} '{if(NR==R1){print $3}}' input.mop_tmp`
  zR1=`awk -v R1=${R1} '{if(NR==R1){print $4}}' input.mop_tmp`
  echo "Line: ${R1}"
  echo ${ratom1}" "${xR1}" "${yR1}" "${zR1}
  #
  R2=`echo $(( $RANDOM % ${natoms} + 1 + 3))`
  ratom2=`awk -v R2=${R2} '{if(NR==R2){print $1}}' input.mop_tmp`
  #
  while [ ${ratom2} == ${ratom1} ]
  do
    echo "-------------------------------------"
    echo "It's the same element so do it again."
    R2=`echo $(( $RANDOM % ${natoms} + 1 + 3))`
    ratom2=`awk -v R2=${R2} '{if(NR==R2){print $1}}' input.mop_tmp`
    echo "New Line: ${R2}, Element2: ${ratom2}"
    echo "    Line: ${R1}, Element1: ${ratom1}"
    echo "-------------------------------------"
  done
  #
  xR2=`awk -v R2=${R2} '{if(NR==R2){print $2}}' input.mop_tmp`
  yR2=`awk -v R2=${R2} '{if(NR==R2){print $3}}' input.mop_tmp`
  zR2=`awk -v R2=${R2} '{if(NR==R2){print $4}}' input.mop_tmp`
  echo "Line: ${R2}"
  echo ${ratom2}" "${xR2}" "${yR2}" "${zR2}
  echo "-------------"
  echo "This time we will adopt the exchange of atomic coordinates."
  awk -v R1=${R1} -v ratom1=${ratom1} -v xR2=${xR2} -v yR2=${yR2} -v zR2=${zR2} '{
    if(NR==R1){printf "%s %s %s %s \n",ratom1,xR2,yR2,zR2}else{print $0}
    }' input.mop_tmp > input.mop_r1
  awk -v R2=${R2} -v ratom2=${ratom2} -v xR1=${xR1} -v yR1=${yR1} -v zR1=${zR1} '{
    if(NR==R2){printf "%s %s %s %s \n",ratom2,xR1,yR1,zR1}else{print $0}
    }' input.mop_r1  > input.mop
  echo "-------------"
  #
  #diff input.mop_tmp input.mop
  #
  mpirun -np ${NCPU} ${mopac} input.mop
  #
  # Formation Energy [eV]
  FE_new=`awk '{if($1=="FINAL" && $2=="FORMATION"){printf "%f",($6*0.0434)}}' input.out`
  #
  R0=`echo $(( $RANDOM % 101 + 0 ))`
  echo "Random value: "${R0}
  #----------------------------------------------------------
  swap_flag=`echo ${FE_new} ${FE_old} ${kbT} ${R0} | awk '{
    if( $1 <= $2 ){print "yes"}
    else if( ($4/100) <= exp(-($1-$2)/$3) ){print "yes"}
    else{print "no"} }'`
  #----------------------------------------------------------
  if [ ${swap_flag} == "yes" ]; then
    cp input.mop input.mop_tmp
    echo "-----------------------------------------------------------"
    echo "Calculated using exchanged atomic coordinates."
    FE_old=${FE_new}
    echo "Formation Energy: "${FE_old}" [eV]"
    echo "-----------------------------------------------------------"
  else
    cp input.mop_tmp input.mop
    echo "-----------------------------------------------------------"
    echo "This time we will not exchange the atomic coordinates."
    echo "New Formation Energy: "${FE_new}" [eV]"
    echo "Old Formation Energy: "${FE_old}" [eV]"
    echo "-----------------------------------------------------------"
  fi
  echo "-----------------------------------------------------"
done

sed -i "s/$/\r/g" input.mop
sed -i "s/$/\r/g" input.mop_original

rm -f input.mop_tmp input.mop_r1

#--------------------------------------------------------------------------
