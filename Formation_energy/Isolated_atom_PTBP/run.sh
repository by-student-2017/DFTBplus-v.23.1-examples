#!/bin/bash

#--------------------------------------------------------------------------

export OMP_NUM_THREADS=1
NCPU=1

#--------------------------------------------------------------------------

rm -f band.out charges.bin detailed.out dftb_out.hsd dftb_pin.hsd POSCAR

#--------------------------------------------------------------------------

# 86 atoms
element_list=( H He \
  Li Be B C N O F Ne \
  Na Mg Al Si P S Cl Ar \
  K Ca Sc Ti V Cr Mn Fe Co Ni Cu Zn Ga Ge As Se Br Kr \
  Rb Sr Y Zr Nb Mo Tc Ru Rh Pd Ag Cd In Sn Sb Te I Xe \
  Cs Ba La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu Hf Ta W Re Os Ir Pt Au Hg Tl Pb Bi Po At Rn )

#--------------------------------------------------------------------------

echo "# Atom, Total Energy [eV], Extrapolated to 0 K [eV], Total Mermin free energy [eV], Force related energy [eV]" > isolated_atom_energy_PTBP.txt

#--------------------------------------------------------------------------

for atom in "${element_list[@]}"
do
  #------------------------------------------------------------------------
  echo "${atom} calculation"
  #------------------------------------------------------------------------
  
  #------------------------------------------------------------------------
  cp POSCAR_template POSCAR
  sed -i "s/Xx/${atom}/g" POSCAR
  #------------------------------------------------------------------------
  
  #------------------------------------------------------------------------
  cp dftb_in_tmp.hsd dftb_in.hsd
  
  case "${atom}" in
    H|He)
      angmom="s"
      ;;
    Li|Be|B|C|N|O|F|Ne|Na|Mg|Al|Si|P|S|Cl|Ar)
      angmom="p"
      ;;
    K|Ca|Sc|Ti|V|Cr|Mn|Fe|Co|Ni|Cu|Zn|Ga|Ge|As|Se|Br|Kr)
      angmom="d"
      ;;
    *)
      angmom="d"
      ;;
  esac
  
  sed -i "/MaxAngularMomentum = {/a \  ${atom} = \"${angmom}\"" dftb_in.hsd
  #------------------------------------------------------------------------
  
  #------------------------------------------------------------------------
  mpirun -np ${NCPU} dftb+ < dftb_in.hsd | tee dftb_out.hsd
  #------------------------------------------------------------------------
  
  #------------------------------------------------------------------------
  # Total Energy [eV]
  TE=`awk '{if($1=="Total" && $2=="Energy:"){printf "%f",$5}}' dftb_out.hsd`
  #---------------
  # Extrapolated to 0 K [eV]
  ETE=`awk '{if($1=="Extrapolated" && $2=="to"){printf "%f",$6}}' dftb_out.hsd`
  #---------------
  # Total Mermin free energy [eV]
  TMFE=`awk '{if($1=="Total" && $2=="Mermin"){printf "%f",$7}}' dftb_out.hsd`
  #---------------
  # Force related energy [eV]
  FRE=`awk '{if($1=="Force" && $2=="related"){printf "%f",$6}}' dftb_out.hsd`
  #---------------
  echo "${atom}, ${TE}, ${ETE}, ${TMFE}, ${FRE}" >> isolated_atom_energy_PTBP.txt
  #------------------------------------------------------------------------
  
  #------------------------------------------------------------------------
  rm -f band.out charges.bin detailed.out dftb_out.hsd dftb_pin.hsd POSCAR
  #------------------------------------------------------------------------
done

#--------------------------------------------------------------------------
