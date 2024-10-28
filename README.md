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
  savepop         save population dynamics (1 = true, 0 = false)
  print_outputs   print full outputs for all iterations (1 = true, 0 = false)
  R_points        number of inter-cofactor separations to be simulated
  deltaG_points   number of delta G values to be simulated
  R_min           minimum inter-cofactor separation [Angstroms]
  R_max           maximum inter-cofactor separation [Angstroms]
  deltaG_max      maximum driving force for FET [eV]
  deltaG_min      minimum driving force for FET [eV]
  kbT             Boltzman factor
  V0              Maximum electronic coupling (as implemented by Hopfield 1974)
  Ei              initial photon energy deposited [eV]
  lambda_c        classical reorganization energy (outer- and inner-sphere contributions) [eV]
  beta            wavefunction decay constant
  atoms           number of atoms in each cofactor
  bond_length     crude bond length to use in calculation of cofactor diameter (approximated as a perfect circle)
  S               Huang-Rhys factor for high-frequency vibration (S = lambda_vq/(hbar * omega)
  vibfreq         Frequency of quantum mode (hbar * omega)  
  quanta          Maximum vibrational quanta
  log_ksink       log10(sink rate [s-1]) (order of magnitude)
  log_kESdecay    log10(excited-state decay rate [s-1]) (order of magnitude)
  log_ti          log10(initial time) (order of magnitude)
  log_tf          log10(final time) (order of magnitude)
  timepoints      total number of timepoints at which to calculate the populations

Notation for the population vectors:
p(1) = ground state population
p(2) = D*AAA population
p(3) = D+A-AA population
p(4) = D+AA-A population
p(5) = D+AAA- population
p(6) = sink population

How to Run:
  Place input.txt in the same directory as main.m.
  Run main.m in MATLAB.
  View progress and output statistics in the MATLAB command window.
  Check the results.mat file for detailed results, including rate matrices, quantum yield, and energy efficiency.
  
Outputs:
  Quantum Yield (OUT.PLOT.QY): Quantum yield for each combination of ΔG and R (formatted for easy plotting in Origin Pro)
  Energy Efficiency (OUT.PLOT.EE): Energy efficiency for each combination of ΔG and R (formatted for easy plotting in Origin Pro)
  Rate Matrices (OUT.PLOT.RATES.kFET, kBET, k2G, k3G, k4G): Forward, backward, and recombination rates for each transition (formatted for easy     
                                                            plotting in Origin Pro)
  Summary (OUT.SUMMARY): Contains the maximum energy efficiency, the corresponding ΔG and R values, and key parameters.

Questions? Please feel free to contact Jon at jonathan.schultz@duke.edu
