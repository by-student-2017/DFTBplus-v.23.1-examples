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
  + Due to my time constraints, I only checked the SCC calculation and did not check the band structure or DOS. Interested readers may wish to compare the band structure with the results of GFN1-xTB and *.skf.
  + GFN2-xTB may be able to calculate well for systems with open gaps such as semiconductors and insulators. GFN2-xTB does not converge well with a unit cell, but it can be calculated successfully with a supercell. It may become a practical tool for calculations of supercells with element substitutions.
  + System that did not converge with GFN2-xTB: Mn4Si7, CaMgZn, MnGaNi2, Li3Al2, ZrCuB, TaCoB, AlFe2Si, CsHSO4, Li2BNH6
  + For Whistler-based structures, "{ 0, 0}: On entry to DSTEGR2 parameter number -202 had an illegal value" is output. If this is related to ScaLapack, it may work fine if you stop OpenMPI.
- GFN1-xTB
  + Even if "GFN2-xTB" does not converge well, "GFN1-xTB" may converge. Stores the results when SCC converges. I have not checked DOS, Band, etc., including "GFN2-xTB". I want you to definitely check this point.
  + [Extended tight-binding quantum chemistry methods](https://doi.org/10.1002/wcms.1493)
    + In this respect, in 2017 GFN1-xTB filled a gap in the market of off-the-shelf atomistic models as it is fast, robust, reasonably accurate, and works for many metallic systems.
  + [Performance of GFN1-xTB for periodic optimization of metal organic frameworks](https://doi.org/10.1039/D2CP00184E)
    + Some structures converged (change in energy <− 1e-2 Hartree), but still had residual gradients larger than the default criterion of 1e-5 Hartree. 
    + These RMSD values compare favourably with those obtained of a set of 72 MOFs calculated with the PM7 semi-empirical method. (e.g., MOPAC PM7)
  + [Refined GFN1-xTB Parameters for Engineering Phase-Stable CsPbX3 Perovskites](https://doi.org/10.1021/acs.jpcc.2c02412)
  + [Efficient Computation of Structural and Electronic Properties of Halide Perovskites Using Density Functional Tight Binding: GFN1-xTB Method](https://doi.org/10.1021/acs.jcim.1c00432)
  + [Electronic structure of two-dimensional-layered PbTiO3 perovskite crystal: an extended tight-binding study based on DFT](https://doi.org/10.1007/s12034-022-02688-3)

## Activation Energy (TS - Reactant) ######################################
- If accurate reaction energies were obtained (1 kcal/mol even with highly accurate CCSD(T)), the relationship with the experimental results would be as follows.
- About 10 kcal/mol: Reacts at room temperature
- About 20 kcal/mol: Takes very long at room temperature
- About 25 kcal/mol: Reacts when heated in an oil bath
- \>= 30 kcal/mol: Rarely happens
- DFTB is close to MOPAC or ReaxFF in accuracy and precision. It has an accuracy of about 10 kcal/mol, so it is useful for practical purposes.
  + [C. Bannwarth et al., Chem. Theory Comput. 2019, 15 (2019) 1652-1671.](https://doi.org/10.1021/acs.jctc.8b01176)
  + [Reactive Force Fields in Particular ReaxFF and Application Possibilities](https://www.tu-chemnitz.de/physik/CPHYS/Conferences/EL/EL2010/presentations/schonfelder.t.10.reactive.0701.pdf)

## extended Lagrangian (XL) Born-Oppenheimer dynamics (XL-BOMD) ######################################
- XL-BOMD method is used for "perfluorosulfonate polymer". This is because the purpose is simply to calculate MSD or vibrations to find the diffusion coefficient of proton.
- High reliability even for metal
- A time step comparable to that of classical MD can be adopted.
  + e.g., O-H 3300 [cm^-1] = 10.11 [fs] or  C-H 3000 [cm^-1] = 11.11 [fs] --> x 1/10 (Track MD by dividing the time for these vibrations into 10) --> TimeStep [fs] = 1
  + If energy is released due to a reaction, the speed (temperature) of atoms increases, atoms collide, etc., and MD cannot be calculated properly, reduce the TimeStep. ReaxFF is often set to 0.25 [fs] or 0.1 [fs].
- In the case of large structural changes, the time step may have to be shortened due to SCC convergence problems.
  + e.g., 1 [fs] --> 0.5 [fs]
- Even when large structural changes such as structural phase transitions occur, calculations are unlikely to break down.

## Car-Parrinello method ######################################
- Not implemented in DFTB+.
- In the case of a reaction in which the HOMO-LUMO gap closes, the conditions for applying the Car-Parrinello method are no longer satisfied for the reasons shown below. Therefore, please be careful when applying the XL-BOMD method. This (The Car-Parrinello method) is an effective method for calculating MSD and vibrations in systems with no reaction and a HOMO-LUMO gap.
- The Car-Parrinello method requires that the time scales of the electron fluctuation motion and the nuclear fluctuation motion be sufficiently separated. This means that the HOMO-LUMO gap must be large. Therefore, handling in systems close to metal is generally not recommended.
  + [F. A. Bornemann et al., Numerische Mathematik 78 (1998) 359-376.](https://doi.org/10.1007/s002110050316)
- In the case of semiconductors and insulators, calculations are often relatively quick.
- The time step of CPMD is about 1/10 of that of classical MD. In other words, it is 0.1 fs.
- Difficult to adapt to metal systems (requires considerable skill)
- Requires know-how such as virtual temperature.

## References ######################################
- [1] [Makoto Yoneya at Work](https://makoto-yoneya.github.io/)
  + [LAMMPS for primers on WindowsPC (for organic materials)](https://makoto-yoneya.github.io/LAMMPS-organics/)
  + [LAMMPS for primers on WindowsPC (for inorganic materials)](https://makoto-yoneya.github.io/LAMMPS-inorganics/)
  + [GROMACS for primers on WindowsPC (for small molecular weight materials)](https://makoto-yoneya.github.io/MDforPRIMERS/)
  + [GROMACS for primers on WindowsPC (for synthetic polymer materials)](https://makoto-yoneya.github.io/MDforPOLYMERS/)
- [2] [Proton conduction simulation of perfluorosulfonic acid polymers using quantum molecular dynamics method](http://molsci.center.ims.ac.jp/area/2007/bk2007/papers/3P057_w.pdf)
- [3] [Investigation of thermal and transport properties of organic and inorganic compounds](https://repository.kulib.kyoto-u.ac.jp/dspace/bitstream/2433/283169/1/scr_2023_48.pdf)
- [4] [Charge transport analysis in organic semiconductor by using density functional tight-binding (DFTB) method](http://molsci.center.ims.ac.jp/area/2015/PDF/pdf/3P040_m.pdf)
- [CP1] [Car-Parrinello method](https://www.jstage.jst.go.jp/article/mssj/17/3/17_167/_pdf/-char/ja)

## Note ######################################
- Note 1: On a regular PC, it is faster to make each axis a supercell of 8 angstroms or more and calculate at 1k than to use a small cell to calculate at a random k point.
- Note 2: GFN2-xTB is more stable and converges easily if each axis is made into a supercell of 8 (if possible, 12.8) angstroms or more.
- Note 3: On a normal PC, when trying to calculate under the above conditions, it is faster to calculate with 1 CPU without using MPI parallelism (such as OpenMPI) or OpenMP parallelism.
- Note 4: SCCTolerance = the order of 1e-5 * number of atoms (vibration: 1e-7 * number of atoms)
- Note 5: GFN2-xTB did not converge using anything other than the Broyden method.
- Note 6: Before performing MD calculations of diffusion coefficient and MSD, it is recommended to clarify the calculation conditions of the Broyden method. Please choose the one closest to the default value.


## Student's Element Substitution Rules ######################################
- For ternary or higher systems
- Up to about 12% for same groups in the periodic table.
- Up to 2.3% if groups is +/-1.
- Up to 1% if group is +/-2 or more.
- If the formation energy is negative (stable), increase the amount of substitution by a few percent.


## Units (DFTB+ and Lammps output) ######################################
- force : DFTB+ (results.tag: Ha/Bohr), Lammps (eV/Angstrom)
- stress: DFTB+ (results.tag: au), Lammps (bar = 100 kPa = 0.1 MPa)
  + (dftbplus.h) stress: Pa
  + (DFTB+ output (terminal or console, etc)) Pressure: au and Pa
  + (DFTBP) virial: eV
  + "elastic[ii][jj] /= (PRESURE_AU * 1.0E9) # Convert to GPa": Inue 134 in calcelastic (python3 code): au => *1.0/(0.339893208050290E-13 * 1.0E9) => GPa
  + ("fix external command" on Lammps) energy and virial are energy units [eV]. (https://docs.lammps.org/fix_external.html)
  + Ref. VASP: E = V * PSTRESS (https://www.vasp.at/wiki/index.php/PSTRESS)
- volume: DFTB+ (results.tag: au^3 = Bohr^3), Lammps (A^3 = Angstrom^3)
  + (DFTB+ output) Volume: [au^3] and [A^3]


## Unfolding ######################################
- In calculations using supercells, it is necessary to return the band dispersion to the unit cell by unfolding and compare it with experiment (ARPES).
- As shown below, the unfolding code exists, but it is not compatible with DFTB+.
  + [siesta-unfold](https://github.com/yw-choi/siesta-unfold)
  + [bandup](https://github.com/band-unfolding/bandup)
  + [banduppy](https://github.com/band-unfolding/banduppy)
  + [VaspBandUnfolding](https://github.com/QijingZheng/VaspBandUnfolding)
  + [easyunfold](https://github.com/SMTG-Bham/easyunfold)
- [C.-C. Lee, et al., J. Phys.: Condens. Matter 25 (2013) 345501.](10.1088/0953-8984/25/34/345501)

## Acknowledgment ######################################
- This project (modified version) is/was partially supported by the following :
  + meguREnergy Co., Ltd.
  + ATSUMITEC Co., Ltd.
  + RIKEN