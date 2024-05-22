%% README
% This is the complete set of codes necessary to run simulations of the Notch Delta Jagged system on a square lattice and then calculate its beta over some region in parameter space.

%% For running the Notch Delta Jagged simulations over a given phase range: 
% In ./Generating_Datasets
% Codes to run the Notch Delta Jagged simulations and generate the datasets:
~ main_run.m runs the simulations for a given sweep of parameter space.
~ periodic_square_NDJ.m is the primary function main_run calls upon. It generates one dataset corresponding to its input parameters.

The auxiliary functions/codes involved here are 
~ parameters.m
~ ndj_equations.m
~ Hill.m

%% For calculating beta and other statistical indices: in ./figure6_figure7
% Statistical indices and measures for comparison with beta
~ SarleBimodalityIndex.m
~ HartigansDipSignifTest.m
~ HartigansDipTest.m

% Calculating beta
~ beta_phase_diagram.m is the code that sweeps across phase space, it calculates the beta and other quantities of interest for each point in phase space and plots their phase diagrams. It loads each dataset and calls calculate_beta.m in order to evaluate quantities. 

~ calculate_beta.m is the function that beta_phase_diagram calls upon. It calculates all the quantities and betas for a given dataset.

The auxiliary functions involved here
~ devr.m is an auxiliary function that calculate_beta.m calls upon that, for a given lattice of cells with N, D, J values, returns the Next and Lext (Dext+Jext) for each cell in the lattice

~ RadialNeighbours.m is called upon by devr.m to obtain indices of all neighboring cells for a given cell in a periodic lattice.

%% Plotting requisite figures
~ figure6.m and figure7.m respectively will give the plots that are present in each of these figures in the manuscript

% Notch Delta Jagged spatial patterning along beta = 0 
~ ./figure8/figure8.m plots heatmaps and kernel density estimates of NICD levels in NDJ populations corresponding to different calculated betas. It also generates plots of radial distribution functions and power spectra of these patterns.  