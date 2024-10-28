# Redox-chain-efficiency



Inputs: 
R_points.......number of inter-cofactor separations to be simulated
deltaG_points..number of delta G values to be simulated
beta...........wavefunction decay constant
log_ti.........initial time (order of magnitude)
log_tf.........final time (order of magnitude)
R_min..........minimum inter-cofactor separation [Angstroms]
R_max..........maximum inter-cofactor separation [Angstroms]
d_cofactor.....cofactor diameter [Angstroms]
deltaG_max.....maximum driving force for FET [eV]
deltaG_min.....minimum driving force for FET [eV]
lambda_c.......classical reorganization energy (outer- and inner-sphere contributions) [eV]
S..............Huang-Rhys factor for high-frequency vibration (S = lambda_vq/(hbar*omega)
atoms..........number of atoms in each cofactor
Ei.............initial photon energy deposited [eV]
log_ksink......log10(sink rate [s-1])
log_kESdecay...log10(excited-state decay rate [s-1])

Notation for the population vector
p(1) = ground state population
p(2) = D*AAA population
p(3) = D+A-AA population
p(4) = D+AA-A population
p(5) = D+AAA- population
p(6) = sink population
