# DFTBplus-v.23.1-examples


## Examples ######################################
- perfluorosulfonate polymer
  + It shows the steps to draw a structure using ChemSketch (free version) and calculate from GAFF to ReaxFF and then to DFTB+.
  + Another feature is that it shows an example of structural optimization using GAFF for arranging water molecules. I would like you to perform calculations using various materials.
- TTIP/c-Si(100) (Hydrogen-terminated Si(100) surface)
  + I think it's generally okay because it shows a figure with similar results to the reference [3].
  + Slater Koster file can be calculated 10 times faster than xTB. We have confirmed that the results are similar to those in reference [3] only with xTB. I failed with ReaxFF. ReaxFF may give good results with NEB.
  + I am using GFN1-xTB. The reason is that GFN2-xTB does not converge well. If anyone has found a better way to calculate it, please let me know.
  + In the literature [3], it was hydrogen terminated, which I thought was surprising. While some people are trying to solve the problem by brute force using the power of PCs without hydrogen termination, it is wonderful that they are reporting on hydrogen termination even in 2022. I thought he was a real professional.

## References ######################################
- [1] [Makoto Yoneya at Work](https://makoto-yoneya.github.io/)
  + [LAMMPS for primers on WindowsPC (for organic materials)](https://makoto-yoneya.github.io/LAMMPS-organics/)
  + [LAMMPS for primers on WindowsPC (for inorganic materials)](https://makoto-yoneya.github.io/LAMMPS-inorganics/)
  + [GROMACS for primers on WindowsPC (for small molecular weight materials)](https://makoto-yoneya.github.io/MDforPRIMERS/)
  + [GROMACS for primers on WindowsPC (for synthetic polymer materials)](https://makoto-yoneya.github.io/MDforPOLYMERS/)
- [2] [Proton conduction simulation of perfluorosulfonic acid polymers using quantum molecular dynamics method](http://molsci.center.ims.ac.jp/area/2007/bk2007/papers/3P057_w.pdf)
- [3] [Investigation of thermal and transport properties of organic and inorganic compounds](https://repository.kulib.kyoto-u.ac.jp/dspace/bitstream/2433/283169/1/scr_2023_48.pdf)

## Acknowledgment ######################################
- This project (modified version) is/was partially supported by the following :
  + meguREnergy Co., Ltd.
  + ATSUMITEC Co., Ltd.
  + RIKEN