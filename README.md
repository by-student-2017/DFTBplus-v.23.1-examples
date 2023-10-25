# DFTBplus-v.23.1-examples


## Examples ######################################
- perfluorosulfonate polymer
  + It shows the steps to draw a structure using ChemSketch (non-commercial) and calculate from GAFF to ReaxFF and then to DFTB+.
  + Another feature is that it shows an example of structural optimization using GAFF for arranging water molecules. I would like you to perform calculations for various materials.
  + Due to the computational time required, we did not calculate MSD, diffusion coefficient, frequency, or IR. Please try it out and let me know if there is a better way or improvements.
- TTIP/c-Si(100) (Hydrogen-terminated Si(100) surface)
  + I think it's generally okay because it shows a figure with similar results to the reference [3].
  + Slater Koster file can be calculated 10 times faster than xTB (GFN1-xTB). We have confirmed that the results are similar to those in reference [3] only with xTB. I failed with ReaxFF. ReaxFF may give good results with NEB.
  + I am using GFN1-xTB. The reason is that GFN2-xTB does not converge well. If anyone has found a better way to calculate it, please let me know.
  + In the literature [3], it was hydrogen terminated, which I thought was surprising. While some people are trying to solve the problem by brute force using the power of PCs without hydrogen termination, it is wonderful that they are reporting on hydrogen termination even in 2022. I thought he was a real professional.
  + In DFTB+, an initial structure in which the TTIP molecules are brought closer to the Si interface may be sufficient. Initially, I tried to calculate the TTIP molecule with an initial structure closer to the Si interface, but the molecule was broken in ReaxFF, so this is the current input file.
  + DFTB, that is, "*.skf", just floated on the surface and did not react. If you want to get the same results as in literature [3], you need to use GFN1-xTB.
  + There are also sites where hydrogen is not terminated (dangling bonds), but TTIP does not seem to work on them.
- GFN2-xTB
  + I created this item to find out under which calculation conditions GFN2-xTB converges well.
  + Due to my time constraints, I only checked the SCF calculation and did not check the band structure or DOS. Interested readers may wish to compare the band structure with the results of GFN1-xTB and *.skf.
  + GFN2-xTB may be able to calculate well for systems with open gaps such as semiconductors and insulators. GFN2-xTB does not converge well with a unit cell, but it can be calculated successfully with a supercell. It may become a practical tool for calculations of supercells with element substitutions.
  + System that did not converge with GFN2-xTB: Mn4Si7, CaMgZn, MnGaNi2, Li3Al2, ZrCuB, TaCoB, AlFe2Si, CsHSO4, Li2BNH6
  + For Whistler-based structures, "{ 0, 0}: On entry to DSTEGR2 parameter number -202 had an illegal value" is output. If this is related to ScaLapack, it may work fine if you stop OpenMPI.
- GFN1-xTB
  + Even if "GFN2-xTB" does not converge well, "GFN1-xTB" may converge. Stores the results when SCF converges. I have not checked DOS, Band, etc., including "GFN2-xTB". I want you to definitely check this point.
  + [Extended tight-binding quantum chemistry methods](https://doi.org/10.1002/wcms.1493)
    + In this respect, in 2017 GFN1-xTB filled a gap in the market of off-the-shelf atomistic models as it is fast, robust, reasonably accurate, and works for many metallic systems.
  
## Activation Energy (TS - Reactant) ######################################
- If accurate reaction energies were obtained (1 kcal/mol even with highly accurate CCSD(T)), the relationship with the experimental results would be as follows.
- About 10 kcal/mol: Reacts at room temperature
- About 20 kcal/mol: Takes very long at room temperature
- About 25 kcal/mol: Reacts when heated in an oil bath
- \>= 30 kcal/mol: Rarely happens
- DFTB is close to MOPAC or ReaxFF in accuracy and precision. It has an accuracy of about 10 kcal/mol, so it is useful for practical purposes.
  + [C. Bannwarth et al., Chem. Theory Comput. 2019, 15 (2019) 1652-1671.](https://doi.org/10.1021/acs.jctc.8b01176)
  + [Reactive Force Fields in Particular ReaxFF and Application Possibilities](https://www.tu-chemnitz.de/physik/CPHYS/Conferences/EL/EL2010/presentations/schonfelder.t.10.reactive.0701.pdf)

## Car-Parrinello methods ######################################
- XL-BOMD method is used for "perfluorosulfonate polymer". This is because the purpose is simply to calculate MSD or vibrations to find the diffusion coefficient of proton.
- In the case of a reaction in which the HOMO-LUMO gap closes, the conditions for applying the Car-Parrinello method are no longer satisfied for the reasons shown below. Therefore, please be careful when applying the XL-BOMD method. This (The Car-Parrinello method) is an effective method for calculating MSD and vibrations in systems with no reaction and a HOMO-LUMO gap.
- The Car-Parrinello method requires that the time scales of the electron fluctuation motion and the nuclear fluctuation motion be sufficiently separated. This means that the HOMO-LUMO gap must be large. Therefore, handling in systems close to metal is generally not recommended.
  + [F. A. Bornemann et al., Numerische Mathematik 78 (1998) 359-376.](https://doi.org/10.1007/s002110050316)


## References ######################################
- [1] [Makoto Yoneya at Work](https://makoto-yoneya.github.io/)
  + [LAMMPS for primers on WindowsPC (for organic materials)](https://makoto-yoneya.github.io/LAMMPS-organics/)
  + [LAMMPS for primers on WindowsPC (for inorganic materials)](https://makoto-yoneya.github.io/LAMMPS-inorganics/)
  + [GROMACS for primers on WindowsPC (for small molecular weight materials)](https://makoto-yoneya.github.io/MDforPRIMERS/)
  + [GROMACS for primers on WindowsPC (for synthetic polymer materials)](https://makoto-yoneya.github.io/MDforPOLYMERS/)
- [2] [Proton conduction simulation of perfluorosulfonic acid polymers using quantum molecular dynamics method](http://molsci.center.ims.ac.jp/area/2007/bk2007/papers/3P057_w.pdf)
- [3] [Investigation of thermal and transport properties of organic and inorganic compounds](https://repository.kulib.kyoto-u.ac.jp/dspace/bitstream/2433/283169/1/scr_2023_48.pdf)
- [4] [Charge transport analysis in organic semiconductor by using density functional tight-binding (DFTB) method](http://molsci.center.ims.ac.jp/area/2015/PDF/pdf/3P040_m.pdf)


## Student's Element Substitution Rules ######################################
- Up to about 12% for same groups in the periodic table.
- Up to 2% if groups is +/-1.
- Conditions other than the above are rarely tried.
- If the formation energy is negative (stable), increase the amount of substitution by a few percent.

## Acknowledgment ######################################
- This project (modified version) is/was partially supported by the following :
  + meguREnergy Co., Ltd.
  + ATSUMITEC Co., Ltd.
  + RIKEN