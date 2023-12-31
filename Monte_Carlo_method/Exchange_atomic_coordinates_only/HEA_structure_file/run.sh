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

export OMP_NUM_THREADS=1
NCPU=1

#--------------------------------------------------------------------------

#--------------------------------------------------------------------------

#---------------------------------------------------
natoms=`awk '{if(NR==7){printf "%d",($1+$2+$3+$4+$5+$6+$7+$8+$9)}}' POSCAR`
echo "Number of atoms: "${natoms}
#---------------------------------------------------
echo -e "\n\n\n\n\n\n\n" > atom_data.txt
#---------------------------------------------------
# Atom 1
atom1=`awk '{if(NR==6){printf "%s",($1)}}' POSCAR`
natom1=`awk '{if(NR==7){printf "%d",($1)}}' POSCAR`
for i in `seq 1 ${natom1}`
do
  echo ${atom1} >> atom_data.txt
done
#---------------------------------------------------
# Atom 2
atom2=`awk '{if(NR==6){printf "%s",($2)}}' POSCAR`
natom2=`awk '{if(NR==7){printf "%d",($2)}}' POSCAR`
for i in `seq 1 ${natom2}`
do
  echo ${atom2} >> atom_data.txt
done
#---------------------------------------------------
# Atom 3
atom3=`awk '{if(NR==6){printf "%s",($3)}}' POSCAR`
natom3=`awk '{if(NR==7){printf "%d",($3)}}' POSCAR`
for i in `seq 1 ${natom3}`
do
  echo ${atom3} >> atom_data.txt
done
#---------------------------------------------------
# Atom 4
atom4=`awk '{if(NR==6){printf "%s",($4)}}' POSCAR`
natom4=`awk '{if(NR==7){printf "%d",($4)}}' POSCAR`
for i in `seq 1 ${natom4}`
do
  echo ${atom4} >> atom_data.txt
done
#---------------------------------------------------
# Atom 5
atom5=`awk '{if(NR==6){printf "%s",($5)}}' POSCAR`
natom5=`awk '{if(NR==7){printf "%d",($5)}}' POSCAR`
for i in `seq 1 ${natom5}`
do
  echo ${atom5} >> atom_data.txt
done
#---------------------------------------------------
# Atom 6
atom6=`awk '{if(NR==6){printf "%s",($6)}}' POSCAR`
natom6=`awk '{if(NR==7){printf "%d",($6)}}' POSCAR`
for i in `seq 1 ${natom6}`
do
  echo ${atom6} >> atom_data.txt
done
#---------------------------------------------------
# Atom 7
atom7=`awk '{if(NR==6){printf "%s",($7)}}' POSCAR`
natom7=`awk '{if(NR==7){printf "%d",($7)}}' POSCAR`
for i in `seq 1 ${natom7}`
do
  echo ${atom7} >> atom_data.txt
done
#---------------------------------------------------
# Atom 8
atom8=`awk '{if(NR==6){printf "%s",($8)}}' POSCAR`
natom8=`awk '{if(NR==7){printf "%d",($8)}}' POSCAR`
for i in `seq 1 ${natom8}`
do
  echo ${atom8} >> atom_data.txt
done
#---------------------------------------------------
# Atom 9
atom9=`awk '{if(NR==6){printf "%s",($9)}}' POSCAR`
natom9=`awk '{if(NR==7){printf "%d",($9)}}' POSCAR`
for i in `seq 1 ${natom9}`
do
  echo ${atom9} >> v
done
#---------------------------------------------------

sed -i "s/\r//g" POSCAR
sed -i "s/\r//g" atom_data.txt
cp POSCAR POSCAR_original
cp POSCAR POSCAR_tmp

rm -f charges.bin
#mpirun -np ${NCPU} dftb+ < dftb_in.hsd | tee dftb_out.hsd
mpirun -np ${NCPU} dftb+ < dftb_in.hsd > dftb_out.hsd

# Total Energy [eV]
TE_old=`awk '{if($1=="Total" && $2=="Energy:"){printf "%f",$5}}' dftb_out.hsd`

#--------------------------------------------------------------------------


#--------------------------------------------------------------------------

for i in `seq 1 ${Ncycles}`
do
  echo "-----------------------------------------------------"
  echo "No. $i cycle"
  #
  echo "-------------"
  R1=`echo $(( $RANDOM % ${natoms} + 1 + 8))`
  ratom1=`awk -v R1=${R1} '{if(NR==R1){print $1}}' atom_data.txt`
  xR1=`awk -v R1=${R1} '{if(NR==R1){print $1}}' POSCAR_tmp`
  yR1=`awk -v R1=${R1} '{if(NR==R1){print $2}}' POSCAR_tmp`
  zR1=`awk -v R1=${R1} '{if(NR==R1){print $3}}' POSCAR_tmp`
  echo "Line: ${R1}"
  echo ${xR1}" "${yR1}" "${zR1}
  #
  R2=`echo $(( $RANDOM % ${natoms} + 1 + 8))`
  ratom2=`awk -v R2=${R2} '{if(NR==R2){print $1}}' atom_data.txt`
  #
  while [ ${ratom2} == ${ratom1} ]
  do
    echo "-------------------------------------"
    echo "It's the same element so do it again."
    R2=`echo $(( $RANDOM % ${natoms} + 1 + 8))`
    ratom2=`awk -v R2=${R2} '{if(NR==R2){print $1}}' atom_data.txt`
    echo "New Line: ${R2}, Element2: ${ratom2}"
    echo "    Line: ${R1}, Element1: ${ratom1}"
    echo "-------------------------------------"
  done
  #
  xR2=`awk -v R2=${R2} '{if(NR==R2){print $1}}' POSCAR_tmp`
  yR2=`awk -v R2=${R2} '{if(NR==R2){print $2}}' POSCAR_tmp`
  zR2=`awk -v R2=${R2} '{if(NR==R2){print $3}}' POSCAR_tmp`
  echo "Line: ${R2}"
  echo ${xR2}" "${yR2}" "${zR2}
  echo "-------------"
  echo "This time we will adopt the exchange of atomic coordinates."
  awk -v R1=${R1} -v xR2=${xR2} -v yR2=${yR2} -v zR2=${zR2} '{
    if(NR==R1){printf "%s %s %s \n",xR2,yR2,zR2}else{print $0}
    }' POSCAR_tmp > POSCAR_r1
  awk -v R2=${R2} -v xR1=${xR1} -v yR1=${yR1} -v zR1=${zR1} '{
    if(NR==R2){printf "%s %s %s \n",xR1,yR1,zR1}else{print $0}
    }' POSCAR_r1  > POSCAR
  echo "-------------"
  #
  #diff POSCAR_tmp POSCAR
  #
  rm -f charges.bin
  #mpirun -np ${NCPU} dftb+ < dftb_in.hsd | tee dftb_out.hsd
  mpirun -np ${NCPU} dftb+ < dftb_in.hsd > dftb_out.hsd
  #
  # Total Energy [eV]
  TE_new=`awk '{if($1=="Total" && $2=="Energy:"){printf "%f",$5}}' dftb_out.hsd`
  #
  R0=`echo $(( $RANDOM % 101 + 0 ))`
  echo "Random value: "${R0}
  #----------------------------------------------------------
  swap_flag=`echo ${TE_new} ${TE_old} ${kbT} ${R0} | awk '{
    if( $1 <= $2 ){print "yes"}
    else if( ($4/100) <= exp(-($1-$2)/$3) ){print "yes"}
    else{print "no"} }'`
  #----------------------------------------------------------
  if [ ${swap_flag} == "yes" ]; then
    cp POSCAR POSCAR_tmp
    echo "-----------------------------------------------------------"
    echo "Calculated using exchanged atomic coordinates."
    TE_old=${TE_new}
    echo "Total Energy: "${TE_old}" [eV]"
    echo "-----------------------------------------------------------"
    #---------- For Memo -----------
    awk -v R1=${R1} -v ratom1=${ratom1} -v nc=$i '{
      if(NR==R1){printf "%s #change xyz at step %d \n",ratom1,nc}else{print $0}
      }' atom_data.txt > atom_data_r1.txt
    awk -v R2=${R2} -v ratom2=${ratom2} -v nc=$i '{
      if(NR==R2){printf "%s #change xyz at step %d \n",ratom2,nc}else{print $0}
      }' atom_data_r1.txt > atom_data.txt
    #-------------------------------
  else
    cp POSCAR_tmp POSCAR
    echo "-----------------------------------------------------------"
    echo "This time we will not exchange the atomic coordinates."
    echo "New total energy: "${TE_new}" [eV]"
    echo "Old total energy: "${TE_old}" [eV]"
    echo "-----------------------------------------------------------"
  fi
  echo "-----------------------------------------------------"
done

sed -i "s/$/\r/g" POSCAR
sed -i "s/$/\r/g" POSCAR_original
sed -i "s/$/\r/g" atom_data.txt

rm -f POSCAR_tmp POSCAR_r1 atom_data_r1.txt

#--------------------------------------------------------------------------
