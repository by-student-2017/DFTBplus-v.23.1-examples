#!/bin/bash

# Usage (on Linus or WSL, etc)
# sh ./dump_modify.sh
# or 
# chmod +x dump_modify.sh
# ./dump_modify.sh

#  input file: system.data
# output file: dump_modify.txt

nms=`awk '{if($1=="Masses"){printf "%d",(NR)}}' system.data`
nml=`awk '{if($1=="Atoms"){printf "%d",(NR)}}' system.data`

awk -v nms=${nms} -v nml=${nml} '{
  if(NR==nms){printf "dump_modify     d1 element "}
  if( (nms < NR) && (NR < nml) ){
    #
    if((NR-nms-2)%20==0){printf "&\n  "}
    #
    #if((NR-nms-2)>=0){printf "%2d",$1} # for debug
         if( ( 1.0-0.4 <= $2) && ($2 <=  1.0+0.4) ){ if($4=="H"){printf "Hw "}else{printf " H "} }
    else if( ( 6.9-0.4 <= $2) && ($2 <=  6.9+0.4) ){printf "Li "}
    else if( (10.8-0.4 <= $2) && ($2 <= 10.8+0.4) ){printf " B "}
    else if( (12.0-0.4 <= $2) && ($2 <= 12.0+0.4) ){printf " C "}
    else if( (14.0-0.4 <= $2) && ($2 <= 14.0+0.4) ){printf " N "}
    else if( (16.0-0.4 <= $2) && ($2 <= 16.0+0.4) ){ if($4=="O"){printf "Ow "}else{printf " O "} }
    else if( (19.0-0.4 <= $2) && ($2 <= 19.0+0.4) ){printf " F "}
    else if( (23.0-0.4 <= $2) && ($2 <= 23.0+0.4) ){printf "Na "}
    else if( (24.0-0.4 <= $2) && ($2 <= 24.0+0.4) ){printf "Mg "}
    else if( (27.0-0.4 <= $2) && ($2 <= 27.0+0.4) ){printf "Al "}
    else if( (28.0-0.4 <= $2) && ($2 <= 28.0+0.4) ){printf "Si "}
    else if( (31.0-0.4 <= $2) && ($2 <= 31.0+0.4) ){printf " P "}
    else if( (32.0-0.4 <= $2) && ($2 <= 32.0+0.4) ){printf " S "}
    else if( (35.5-0.4 <= $2) && ($2 <= 35.5+0.4) ){printf "Cl "}
    else if( (39.1-0.4 <= $2) && ($2 <= 39.1+0.4) ){printf " K "}
    else if( (40.0-0.4 <= $2) && ($2 <= 40.0+0.4) ){printf "Ca "}
    else if( (45.0-0.4 <= $2) && ($2 <= 45.0+0.4) ){printf "Sc "}
    else if( (47.9-0.4 <= $2) && ($2 <= 47.9+0.4) ){printf "Ti "}
    else if( (50.0-0.4 <= $2) && ($2 <= 50.0+0.4) ){printf " V "}
    else if( (52.0-0.4 <= $2) && ($2 <= 52.0+0.4) ){printf "Cr "}
    else if( (55.0-0.4 <= $2) && ($2 <= 55.0+0.4) ){printf "Mn "}
    else if( (56.0-0.4 <= $2) && ($2 <= 56.0+0.4) ){printf "Fe "}
    else if( (58.9-0.1 <= $2) && ($2 <= 58.9+0.1) ){printf "Co "}
    else if( (58.7-0.1 <= $2) && ($2 <= 58.7+0.1) ){printf "Ni "}
    else if( (63.0-0.4 <= $2) && ($2 <= 63.0+0.4) ){printf "Cu "}
    else if( (65.0-0.4 <= $2) && ($2 <= 65.0+0.4) ){printf "Zn "}
    else if( (69.7-0.4 <= $2) && ($2 <= 69.7+0.4) ){printf "Ga "}
    else if( (72.6-0.4 <= $2) && ($2 <= 72.6+0.4) ){printf "Ge "}
    else if( (74.9-0.4 <= $2) && ($2 <= 74.9+0.4) ){printf "As "}
    else if( (78.9-0.4 <= $2) && ($2 <= 78.9+0.4) ){printf "Se "}
    else if( (79.9-0.4 <= $2) && ($2 <= 79.9+0.4) ){printf "Br "}
    else if( (85.5-0.4 <= $2) && ($2 <= 85.5+0.4) ){printf "Rb "}
    else if( (87.6-0.4 <= $2) && ($2 <= 87.6+0.4) ){printf "Sr "}
    else if( (88.9-0.4 <= $2) && ($2 <= 88.9+0.4) ){printf " Y "}
    else if( (91.2-0.4 <= $2) && ($2 <= 91.2+0.4) ){printf "Zr "}
    else if( (92.9-0.4 <= $2) && ($2 <= 92.9+0.4) ){printf "Nb "}
    else if( (69.0-0.4 <= $2) && ($2 <= 96.0+0.4) ){printf "Mo "}
    else if( (99.0-0.4 <= $2) && ($2 <= 99.0+0.4) ){printf "Te "}
    else if((101.1-0.4 <= $2) && ($2 <= 101.1+0.4)){printf "Ru "}
    else if((102.9-0.4 <= $2) && ($2 <= 102.9+0.4)){printf "Rh "}
    else if((106.4-0.4 <= $2) && ($2 <= 106.4+0.4)){printf "Pd "}
    else if((107.9-0.4 <= $2) && ($2 <= 107.9+0.4)){printf "Ag "}
    else if((112.4-0.4 <= $2) && ($2 <= 112.4+0.4)){printf "Cd "}
    else if((114.8-0.4 <= $2) && ($2 <= 114.8+0.4)){printf "In "}
    else if((118.7-0.4 <= $2) && ($2 <= 118.7+0.4)){printf "Sn "}
    else if((127.6-0.4 <= $2) && ($2 <= 127.6+0.4)){printf "Te "}
    else if((126.9-0.4 <= $2) && ($2 <= 126.9+0.4)){printf " I "}
    else if((132.9-0.4 <= $2) && ($2 <= 132.9+0.4)){printf "Cs "}
    else if((137.3-0.4 <= $2) && ($2 <= 137.3+0.4)){printf "Ba "}
    else if((138.9-0.4 <= $2) && ($2 <= 138.9+0.4)){printf "La "}
    else if((140.1-0.4 <= $2) && ($2 <= 140.1+0.4)){printf "Ce "}
    else if((140.9-0.4 <= $2) && ($2 <= 140.9+0.4)){printf "Pr "}
    else if((144.2-0.4 <= $2) && ($2 <= 144.2+0.4)){printf "Nd "}
    else if((150.4-0.4 <= $2) && ($2 <= 150.4+0.4)){printf "Sm "}
    else if((152.0-0.4 <= $2) && ($2 <= 152.0+0.4)){printf "Eu "}
    else if((157.3-0.4 <= $2) && ($2 <= 157.3+0.4)){printf "Gd "}
    else if((158.9-0.4 <= $2) && ($2 <= 158.9+0.4)){printf "Tb "}
    else if((162.5-0.4 <= $2) && ($2 <= 162.5+0.4)){printf "Dy "}
    else if((164.9-0.4 <= $2) && ($2 <= 164.9+0.4)){printf "Ho "}
    else if((167.3-0.4 <= $2) && ($2 <= 167.3+0.4)){printf "Er "}
    else if((168.9-0.4 <= $2) && ($2 <= 168.9+0.4)){printf "Tm "}
    else if((173.0-0.4 <= $2) && ($2 <= 173.0+0.4)){printf "Yb "}
    else if((175.0-0.4 <= $2) && ($2 <= 175.0+0.4)){printf "Lu "}
    else if((178.5-0.4 <= $2) && ($2 <= 178.5+0.4)){printf "Hf "}
    else if((180.9-0.4 <= $2) && ($2 <= 180.9+0.4)){printf "Ta "}
    else if((183.8-0.4 <= $2) && ($2 <= 183.8+0.4)){printf " W "}
    else if((186.2-0.4 <= $2) && ($2 <= 186.2+0.4)){printf "Re "}
    else if((190.2-0.4 <= $2) && ($2 <= 190.2+0.4)){printf "Os "}
    else if((192.2-0.4 <= $2) && ($2 <= 192.2+0.4)){printf "Ir "}
    else if((195.1-0.4 <= $2) && ($2 <= 195.1+0.4)){printf "Pt "}
    else if((197.0-0.4 <= $2) && ($2 <= 197.0+0.4)){printf "Au "}
    else if((200.6-0.4 <= $2) && ($2 <= 200.6+0.4)){printf "Hg "}
    else if((204.4-0.4 <= $2) && ($2 <= 204.4+0.4)){printf "Tl "}
    else if((207.2-0.4 <= $2) && ($2 <= 207.2+0.4)){printf "Pb "}
    else if((209.0-0.4 <= $2) && ($2 <= 209.0+0.4)){printf "Bi "}
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
echo "# Hw = H of water, Ow = O of water"
echo "#------------------------------+-------------------------------"
echo ""
echo ""
echo "#------------------------------+---------------------------------------------------"
echo "# Debug information"
echo "#   If the number is not followed by an atomic symbol and "
echo "#   the numbers are shown consecutively, "
echo "#   this is where the problem occurs."
echo "#----------                                             ---------------------------"
awk -v nms=${nms} -v nml=${nml} '{
  if( (nms < NR) && (NR < nml-1) ){
    #
    if((NR-nms-2)%10==0){printf " \n  "}
    #
    if((NR-nms-2)>=0){printf "%5d",$1} # for debug
         if( ( 1.0-0.4 <= $2) && ($2 <=  1.0+0.4) ){ if($4=="H"){printf "Hw "}else{printf " H "} }
    else if( ( 6.9-0.4 <= $2) && ($2 <=  6.9+0.4) ){printf "Li "}
    else if( (10.8-0.4 <= $2) && ($2 <= 10.8+0.4) ){printf " B "}
    else if( (12.0-0.4 <= $2) && ($2 <= 12.0+0.4) ){printf " C "}
    else if( (14.0-0.4 <= $2) && ($2 <= 14.0+0.4) ){printf " N "}
    else if( (16.0-0.4 <= $2) && ($2 <= 16.0+0.4) ){ if($4=="O"){printf "Ow "}else{printf " O "} }
    else if( (19.0-0.4 <= $2) && ($2 <= 19.0+0.4) ){printf " F "}
    else if( (23.0-0.4 <= $2) && ($2 <= 23.0+0.4) ){printf "Na "}
    else if( (24.0-0.4 <= $2) && ($2 <= 24.0+0.4) ){printf "Mg "}
    else if( (27.0-0.4 <= $2) && ($2 <= 27.0+0.4) ){printf "Al "}
    else if( (28.0-0.4 <= $2) && ($2 <= 28.0+0.4) ){printf "Si "}
    else if( (31.0-0.4 <= $2) && ($2 <= 31.0+0.4) ){printf " P "}
    else if( (32.0-0.4 <= $2) && ($2 <= 32.0+0.4) ){printf " S "}
    else if( (35.5-0.4 <= $2) && ($2 <= 35.5+0.4) ){printf "Cl "}
    else if( (39.1-0.4 <= $2) && ($2 <= 39.1+0.4) ){printf " K "}
    else if( (40.0-0.4 <= $2) && ($2 <= 40.0+0.4) ){printf "Ca "}
    else if( (45.0-0.4 <= $2) && ($2 <= 45.0+0.4) ){printf "Sc "}
    else if( (47.9-0.4 <= $2) && ($2 <= 47.9+0.4) ){printf "Ti "}
    else if( (50.0-0.4 <= $2) && ($2 <= 50.0+0.4) ){printf " V "}
    else if( (52.0-0.4 <= $2) && ($2 <= 52.0+0.4) ){printf "Cr "}
    else if( (55.0-0.4 <= $2) && ($2 <= 55.0+0.4) ){printf "Mn "}
    else if( (56.0-0.4 <= $2) && ($2 <= 56.0+0.4) ){printf "Fe "}
    else if( (58.9-0.1 <= $2) && ($2 <= 58.9+0.1) ){printf "Co "}
    else if( (58.7-0.1 <= $2) && ($2 <= 58.7+0.1) ){printf "Ni "}
    else if( (63.0-0.4 <= $2) && ($2 <= 63.0+0.4) ){printf "Cu "}
    else if( (65.0-0.4 <= $2) && ($2 <= 65.0+0.4) ){printf "Zn "}
    else if( (69.7-0.4 <= $2) && ($2 <= 69.7+0.4) ){printf "Ga "}
    else if( (72.6-0.4 <= $2) && ($2 <= 72.6+0.4) ){printf "Ge "}
    else if( (74.9-0.4 <= $2) && ($2 <= 74.9+0.4) ){printf "As "}
    else if( (78.9-0.4 <= $2) && ($2 <= 78.9+0.4) ){printf "Se "}
    else if( (79.9-0.4 <= $2) && ($2 <= 79.9+0.4) ){printf "Br "}
    else if( (85.5-0.4 <= $2) && ($2 <= 85.5+0.4) ){printf "Rb "}
    else if( (87.6-0.4 <= $2) && ($2 <= 87.6+0.4) ){printf "Sr "}
    else if( (88.9-0.4 <= $2) && ($2 <= 88.9+0.4) ){printf " Y "}
    else if( (91.2-0.4 <= $2) && ($2 <= 91.2+0.4) ){printf "Zr "}
    else if( (92.9-0.4 <= $2) && ($2 <= 92.9+0.4) ){printf "Nb "}
    else if( (69.0-0.4 <= $2) && ($2 <= 96.0+0.4) ){printf "Mo "}
    else if( (99.0-0.4 <= $2) && ($2 <= 99.0+0.4) ){printf "Te "}
    else if((101.1-0.4 <= $2) && ($2 <= 101.1+0.4)){printf "Ru "}
    else if((102.9-0.4 <= $2) && ($2 <= 102.9+0.4)){printf "Rh "}
    else if((106.4-0.4 <= $2) && ($2 <= 106.4+0.4)){printf "Pd "}
    else if((107.9-0.4 <= $2) && ($2 <= 107.9+0.4)){printf "Ag "}
    else if((112.4-0.4 <= $2) && ($2 <= 112.4+0.4)){printf "Cd "}
    else if((114.8-0.4 <= $2) && ($2 <= 114.8+0.4)){printf "In "}
    else if((118.7-0.4 <= $2) && ($2 <= 118.7+0.4)){printf "Sn "}
    else if((127.6-0.4 <= $2) && ($2 <= 127.6+0.4)){printf "Te "}
    else if((126.9-0.4 <= $2) && ($2 <= 126.9+0.4)){printf " I "}
    else if((132.9-0.4 <= $2) && ($2 <= 132.9+0.4)){printf "Cs "}
    else if((137.3-0.4 <= $2) && ($2 <= 137.3+0.4)){printf "Ba "}
    else if((138.9-0.4 <= $2) && ($2 <= 138.9+0.4)){printf "La "}
    else if((140.1-0.4 <= $2) && ($2 <= 140.1+0.4)){printf "Ce "}
    else if((140.9-0.4 <= $2) && ($2 <= 140.9+0.4)){printf "Pr "}
    else if((144.2-0.4 <= $2) && ($2 <= 144.2+0.4)){printf "Nd "}
    else if((150.4-0.4 <= $2) && ($2 <= 150.4+0.4)){printf "Sm "}
    else if((152.0-0.4 <= $2) && ($2 <= 152.0+0.4)){printf "Eu "}
    else if((157.3-0.4 <= $2) && ($2 <= 157.3+0.4)){printf "Gd "}
    else if((158.9-0.4 <= $2) && ($2 <= 158.9+0.4)){printf "Tb "}
    else if((162.5-0.4 <= $2) && ($2 <= 162.5+0.4)){printf "Dy "}
    else if((164.9-0.4 <= $2) && ($2 <= 164.9+0.4)){printf "Ho "}
    else if((167.3-0.4 <= $2) && ($2 <= 167.3+0.4)){printf "Er "}
    else if((168.9-0.4 <= $2) && ($2 <= 168.9+0.4)){printf "Tm "}
    else if((173.0-0.4 <= $2) && ($2 <= 173.0+0.4)){printf "Yb "}
    else if((175.0-0.4 <= $2) && ($2 <= 175.0+0.4)){printf "Lu "}
    else if((178.5-0.4 <= $2) && ($2 <= 178.5+0.4)){printf "Hf "}
    else if((180.9-0.4 <= $2) && ($2 <= 180.9+0.4)){printf "Ta "}
    else if((183.8-0.4 <= $2) && ($2 <= 183.8+0.4)){printf " W "}
    else if((186.2-0.4 <= $2) && ($2 <= 186.2+0.4)){printf "Re "}
    else if((190.2-0.4 <= $2) && ($2 <= 190.2+0.4)){printf "Os "}
    else if((192.2-0.4 <= $2) && ($2 <= 192.2+0.4)){printf "Ir "}
    else if((195.1-0.4 <= $2) && ($2 <= 195.1+0.4)){printf "Pt "}
    else if((197.0-0.4 <= $2) && ($2 <= 197.0+0.4)){printf "Au "}
    else if((200.6-0.4 <= $2) && ($2 <= 200.6+0.4)){printf "Hg "}
    else if((204.4-0.4 <= $2) && ($2 <= 204.4+0.4)){printf "Tl "}
    else if((207.2-0.4 <= $2) && ($2 <= 207.2+0.4)){printf "Pb "}
    else if((209.0-0.4 <= $2) && ($2 <= 209.0+0.4)){printf "Bi "}
  }
  if(NR==nml){printf "\n"}
}' system.data
echo "#------------------------------+---------------------------------------------------"

# Note: https://www.chemistry.or.jp/activity/atom_2022.pdf