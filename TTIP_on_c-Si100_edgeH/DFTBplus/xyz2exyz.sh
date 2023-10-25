#!/bin/bash

# Usage (on Linus or WSL, etc)
# sh ./xyz2exyz.sh
# or 
# chmod +x xyz2exyz.sh
# ./xyz2exyz.sh

natom=`awk '{if(NR==1){printf "%d",$1}}' geo_end.gen`
a1=`awk -v natom=${natom} '{if(NR==natom+4){printf "%e",$1}}' geo_end.gen`
a2=`awk -v natom=${natom} '{if(NR==natom+4){printf "%e",$2}}' geo_end.gen`
a3=`awk -v natom=${natom} '{if(NR==natom+4){printf "%e",$3}}' geo_end.gen`
b1=`awk -v natom=${natom} '{if(NR==natom+5){printf "%e",$1}}' geo_end.gen`
b2=`awk -v natom=${natom} '{if(NR==natom+5){printf "%e",$2}}' geo_end.gen`
b3=`awk -v natom=${natom} '{if(NR==natom+5){printf "%e",$3}}' geo_end.gen`
c1=`awk -v natom=${natom} '{if(NR==natom+6){printf "%e",$1}}' geo_end.gen`
c2=`awk -v natom=${natom} '{if(NR==natom+6){printf "%e",$2}}' geo_end.gen`
c3=`awk -v natom=${natom} '{if(NR==natom+6){printf "%e",$3}}' geo_end.gen`

cp geo_end.xyz geo_end.exyz

sed -i "s/MD iter/Lattice=\"${a1} ${a2} ${a3}  ${b1} ${b2} ${b3}  ${c1} ${c2} ${c3}\": MD iter/g" geo_end.exyz

echo "geo_end_unwrap.exyz is only correct for cubic structures !!!"

cp geo_end.exyz tmp0.exyz

awk -v natom=${natom} -v a1=${a1} '{
  if($1==natom){print $0}
  else if($2>a1){printf "   %2s %15.8f %15.8f %15.8f %15.8f %15.8f %15.8f %15.8f \n",$1,($2-a1),$3,$4,$5,$6,$7,$8}
  else if($2<0 ){printf "   %2s %15.8f %15.8f %15.8f %15.8f %15.8f %15.8f %15.8f \n",$1,($2+a1),$3,$4,$5,$6,$7,$8}
  else{print $0}
}' tmp0.exyz > tmp_a1.exyz
awk -v natom=${natom} -v b2=${b2} '{
  if($1==natom){print $0}
  else if($3>b2){printf "   %2s %15.8f %15.8f %15.8f %15.8f %15.8f %15.8f %15.8f \n",$1,$2,($3-b2),$4,$5,$6,$7,$8}
  else if($3<0 ){printf "   %2s %15.8f %15.8f %15.8f %15.8f %15.8f %15.8f %15.8f \n",$1,$2,($3+b2),$4,$5,$6,$7,$8}
  else{print $0}
}' tmp_a1.exyz > tmp_b2.exyz
awk -v natom=${natom} -v c3=${c3} '{
  if($1==natom){print $0}
  else if($4>c3){printf "   %2s %15.8f %15.8f %15.8f %15.8f %15.8f %15.8f %15.8f \n",$1,$2,$3,($4-c3),$5,$6,$7,$8}
  else if($4<0 ){printf "   %2s %15.8f %15.8f %15.8f %15.8f %15.8f %15.8f %15.8f \n",$1,$2,$3,($4+c3),$5,$6,$7,$8}
  else{print $0}
}' tmp_b2.exyz > tmp_c3.exyz

cp tmp_c3.exyz geo_end_wrap.exyz

echo "-----------------------------------------------------"
echo "geo_end.xyz:"
echo "  Position, x [Angstrom]"
echo "  Charge, q [e]"
echo "  Velocities, vx [Angstrom/ps]=[A/ps]=[AA/ps]"
echo "1:atom, 2:x,  3:y,  4:z,  5:q, 6:vx, 7:vy, 8:vz"
echo "-----------------------------------------------------"
echo "-----------------------------------------------------"
echo "geo_end_wrap.exyz"
echo "  Position, xs [Angstrom] (wrap)"
echo "  Charge, q [e]"
echo "  Velocities, vx [Angstrom/ps]=[A/ps]=[AA/ps]"
echo "1:atom, 2:xs, 3:ys, 4:xs, 5:q, 6:vx, 7:vy, 8:vz"
echo "-----------------------------------------------------"

rm -f tmp0.exyz tmp_a1.exyz tmp_b2.exyz tmp_c3.exyz

