README
This is the complete set of codes necessary to run simulations of the LEUP system on a square lattice and then perform various analyses as outlined in (Barua et al. 2024)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

(1) How to generate LEUP datasets
In ./Generating_Datasets/LEUP

CODE TO BE RUN: square_lattice_main_run.m
This generates all the datasets required into the appropriate file structure in ./Datasets/LEUP, running the simulations for the required ranges of (r, beta) for all the types of neighborhoods required.

It calls upon rad_fn, which takes (r, beta, seed) as input and runs the LEUP lattice simulation. 'rad_fn' refers to the fact that radial neighborhoods are considered. Similarly, it also calls upon 'square_fn', 'diag_fn' which run LEUP simulations for extended Moore and Von Neumann neighborhoods respectively.

AUXILIARY CODES:
~ RadialNeighbours.m , SquareNeighbours.m , DiagNeighbours.m accordingly are functions that return indices of the radial, extended Moore, extended Von Neumann neighbor indices for a given cell in a periodic lattice.

~ leup.m is the function in the LEUP Langevin equation
~ SarleBimodalityIndex.m , HartigansDipTest.m . HartigansDipSignIfTest.m are statistical indices. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

(2) How to generate NDJ datasets (for comparison)
In ./Generating_Datasets/NDJ

CODE TO BE RUN: main_run.m
This generates all the NDJ datasets we require into the required file structure in ./Datasets/NDJ. It calls upon periodic_square_NDJ.m which runs the NDJ simulations for a give point in (D0, J0) phase space.

The remaining are auxiliary functions.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

(3) Obtaining plots in individual figures: the only codes to be run for each figure are those names as 'figure*.m' in each folder. The remaining are all auxiliary functions/methods, appropriately called by 'figure*.m'

CODES TO BE RUN:
In ./figure2 : figure2A__kde_plots.m , figure2B__avg_sigmal_slope.m
In ./figure3 : figure3_sigmal_phase_diagram.m
In ./figure4 : figure4.m
In ./figure5 : figure5.m

In ./figureS1 : figureS1__sigmal_vs_time.m

Figures 6, 7, 8 are from the beta calculation, to be found in ../LEUP_NDJ_calculating_beta
All the required plots for the figures are generated and saved as .eps files.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
