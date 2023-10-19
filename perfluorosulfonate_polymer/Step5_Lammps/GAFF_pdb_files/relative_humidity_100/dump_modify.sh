#!/bin/bash

nms=`awk '{if($1=="Masses"){printf "%d",(NR)}}' system.data`
nml=`awk '{if($1=="Atoms"){printf "%d",(NR)}}' system.data`

awk -v nms=${nms} -v nml=${nml} '{
  if(NR==nms){printf "dump_modify     d1 element "}
  if( (nms < NR) && (NR < nml) ){
    #
    if((NR-nms-2)%20==0){printf "&\n  "}
    #
    #{printf "%d",$1} # for debug
    if( ( 0.5 <= $2) && ($2 <=  1.4) ){printf " H "}
    if( (11.5 <= $2) && ($2 <= 12.4) ){printf " C "}
    if( (13.5 <= $2) && ($2 <= 14.4) ){printf " N "}
    if( (15.5 <= $2) && ($2 <= 16.4) ){printf " O "}
    if( (18.5 <= $2) && ($2 <= 19.4) ){printf " F "}
    if( (30.5 <= $2) && ($2 <= 31.4) ){printf " P "}
    if( (31.5 <= $2) && ($2 <= 32.4) ){printf " S "}
    if( (34.5 <= $2) && ($2 <= 36.4) ){printf "Cl "}
    if( (79.5 <= $2) && ($2 <= 80.4) ){printf "Br "}
    if((126.5 <= $2) && ($2 <= 127.4)){printf " I "}
  }
  if(NR==nml){printf "\n"}
}' system.data > dump_modify.txt

echo "#------------------------------+-------------------------------"
echo "#  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 &"
echo "#------------------------------+-------------------------------"
cat dump_modify.txt
echo "#------------------------------+-------------------------------"
echo "#  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 &"
echo "#------------------------------+-------------------------------"
echo "# Add the above command (from \"dump_modify\" to the last atomic"
echo "#  symbol) under \"dump d1 all cfg ...\" in run.in.EXAMPLE."
