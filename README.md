# Redox-chain-efficiency

This code can be used to reproduce the results shown in:
Schultz, J. D.; Parker, K.; Therien, M.; Beratan, D. N.* Efficiency limits of energy conversion by light-driven redox chains. J. Am. Chem. Soc. 2024 (accepted)

The script simulates the time evolution of an electron transfer chain in a system of cofactors, with quantum yield, energy efficiency, and rate matrices as key outputs. The simulation models the rates and population dynamics of an electron transfer chain, with inter-cofactor separations and driving forces (ΔG) as input parameters.

Features:
  Quantum Yield Calculation: Simulates the quantum yield for different inter-cofactor distances and ΔG values.
  Energy Efficiency Estimation: Computes energy efficiency for the system under different conditions.
  Rate Matrices: Calculates forward and backward electron transfer rates between different cofactors and recombination rates to the ground state.
  Customizable Input: Load various system parameters from an external input file (input.txt) to easily modify the simulation setup (see below for                          complete list of inputs).

Prerequisites:
  MATLAB (Tested with version R2023a)
  Input file (input.txt), structured as:
    First column: Variable names (e.g., log_kESdecay, log_ksink, R_min, etc.)
    Second column: Corresponding values.

File Descriptions:
  main.m: This script is the main code that runs the electron transfer chain simulation.
  input.txt: Input file containing the simulation parameters (inter-cofactor separations, rates, energies, etc.).
  results.mat: Contains the output structure OUT with all computed data, including rate matrices, quantum yield, and energy efficiency matrices.

Description of inputs: 
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

Notation for the population vectors:
p(1) = ground state population
p(2) = D*AAA population
p(3) = D+A-AA population
p(4) = D+AA-A population
p(5) = D+AAA- population
p(6) = sink population

Questions? Please feel free to contact Jon at jonathan.schultz@duke.edu
