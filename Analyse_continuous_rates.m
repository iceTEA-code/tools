%% ANALYSE CONTINUOUS RATES OF RETREAT OR THINNING
%
% Determines continuous estimates of retreat/thinning rates for exposure 
% age data in a horizontal or vertical transect. Penalised spline 
% regression uses both the normally-distributed exposure ages (2 sigma) and
% sample elevation uncertainties within a Bayesian framework.
%
% Just Another Gibbs Sampler (JAGS) is used to efficiently perform the
% analysis. If not found, then the program is downloaded and installed.
%
% Plots the modelled retreat/thinning profile, with or without 
% corresponding exposure ages, and the corresponding rates through time. 
%
% Exposure ages need to be in a correctly structured Matlab file 
% (_ages.mat). This can be done using Calc_Plot_age.m or Import_Plot_age.m,
% to calculate ages or import existing ages, respectively.
%
% Written by Richard Selwyn Jones, Durham University, and
% Niamh Cahill, University College Dublin.
% richard.s.jones@durham.ac.uk
% Part of the iceTEA tools suite.
%
%
%%

clear % Start fresh
addpath(genpath(pwd))

ages_name = 'example_thinningtransect'; % Name of dataset containting calculated ages (_ages.mat)

load_name = strcat(ages_name,'_ages.mat');
load(load_name);


%% Determine Rates

transect_type = 'vert'; % SET as 'vert' or 'horiz'
n_iter = []; % SET number of model iterations (default is 20000)
mask = [];   % Select samples to analyse (leave empty for all samples; [])

regressed_rates = transect_regress_spline(ages_ka,transect_type,n_iter,mask);


%% Plot Transect with Modelled Profile and Rates

% Plot settings
plot_ages = 1;  % Also plot exposure ages?  yes = 1, no = 0
save_plot = 0;  % Save plot?  1 to save as .png and .eps, otherwise 0
time_lim = [0 13];  % Optionally set limits of time axis (in ka), otherwise leave empty
pos_lim = [0 1100]; % Optionally set limits of relative position axis (in m or km), otherwise leave empty
rate_lim = [0 30];  % Optionally set limits of rate axis (in cm/yr or m/yr), otherwise leave empty

% Plot
plot_transect_spline_rates(regressed_rates,ages_ka,transect_type,plot_ages,save_plot,mask,time_lim,pos_lim,rate_lim);
