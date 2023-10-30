#!/bin/bash

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

a1=`awk -v natoms=${natoms} '{if(NR==3+natoms+1){printf "%10.5f", $2}}' input.mop`
a2=`awk -v natoms=${natoms} '{if(NR==3+natoms+1){printf "%10.5f", $3}}' input.mop`
a3=`awk -v natoms=${natoms} '{if(NR==3+natoms+1){printf "%10.5f", $4}}' input.mop`

b1=`awk -v natoms=${natoms} '{if(NR==3+natoms+2){printf "%10.5f", $2}}' input.mop`
b2=`awk -v natoms=${natoms} '{if(NR==3+natoms+2){printf "%10.5f", $3}}' input.mop`
b3=`awk -v natoms=${natoms} '{if(NR==3+natoms+2){printf "%10.5f", $4}}' input.mop`

c1=`awk -v natoms=${natoms} '{if(NR==3+natoms+3){printf "%10.5f", $2}}' input.mop`
c2=`awk -v natoms=${natoms} '{if(NR==3+natoms+3){printf "%10.5f", $3}}' input.mop`
c3=`awk -v natoms=${natoms} '{if(NR==3+natoms+3){printf "%10.5f", $4}}' input.mop`

echo ${natoms} > input.exyz
echo "Lattice= \"${a1} ${a2} ${a3} ${b1} ${b2} ${b3} ${c1} ${c2} ${c3}\"" >> input.exyz

awk -v natoms=${natoms} '{if(NR>=4 && NR<=(3+natoms)){print $0}}' input.mop >> input.exyz

echo "Please, open input.exyz on Ovito"

#---------------------------------------------------