% prepare workspace
clear; close all;

% load default parameters
run('./par_default')

% set run parameters
runID     =  'DEMO_MO';           % run identifier  (D = 1e2; d0 = 1e-2; etam0 = 1e1)
restart   =  0;                   % restart from file (0: new run; <0: restart from last; >0: restart from specified frame)
nop       =  100;                 % output frame plotted/saved every 'nop' time steps
nrh       =  1;                   % record metrics history every 'nrh' time steps
plot_op   =  1;                   % switch on to live plot results
save_op   =  1;                   % switch on to save output to file
ndm_op    =  0;                   % plot nondimensionalised output

% set model domain parameters
D         =  1e6;                 % chamber depth [m]
N         =  100;                 % number of grid points in z-direction
h         =  D/N;                 % grid spacing (equal in both dimensions, do not set) [m]
L         =  D*1.5;               % chamber width (equal to h for 1-D mode) [m]

% set model timing parameters
t0end     =  200.0;               % stop when dimensionless time is reached
dt        =  1e2;

% set physical control parameters
g0        =  1.72;                % gravity [m/s2]
d0        =  1e-1;                % xtal size [m]
etam0     =  1;                   % melt viscosity [kg/m3]
L0        =  D/200;               % correlation length for eddy diffusivity (multiple of h, 0.5-1)
l0        =  d0*10;               % correlation length for phase fluctuation diffusivity (multiple of d0, 10-20)
Xi        =  0.5;                 % relative amplitude of random noise flux
Dsm       =  350;                 % entropy of fusion [J/kg/K]
kT        =  1e-6;                % thermal diffusivity [m2/s] 
cP        =  1000;                % heat capacity [J/kg/K]
aT        =  6e-5;                % thermal expansivity [1/K]
bPx       =  2e-11;               % xtal compressibility [1/Pa]
bPm       =  4e-11;               % melt compressibility [1/Pa]
Tliq0     =  1450;                % liquidus temperature at P = P0 [C]
Tsol0     =  1200;                % solidus temperature at P = P0 [C]
dTr       =  0.1;                 % random T perturbation [K]
dTg       =  0;                   % gaussian T perturbation [K]
taurct    =  1000;                % reaction time [s]
dTin      =  1;                   % initial temperature above/below liquidus
rhom0     =  2800;                % melt density constant [kg/m3]
rhox0     =  3300;                % xtal density constant [kg/m3]
cooling   =  'top';               % set boundaries on which cooling/heating is imposed
cooling_mode = 'radiative';       % switch between radiative and conductive boundary cooling modes
Tbnd      =  [0,nan];             % boundary rock temperature [C]
taubnd    =  1e6;                 % boundary cooling time [s]
atmos_blanket = 1;                % atmospheric thermal blanketing factor [>=1]

% set numerical model parameters
CFL       =  0.75;                % (physical) time stepping courant number (multiplies stable step) [0,1]
rtol      =  1e-3;                % outer its relative tolerance
atol      =  1e-9;                % outer its absolute tolerance
maxit     =  10;                  % maximum outer its
alpha     =  0.6;                % iterative step size parameter
gamma     =  1e-3;                % artificial horizontal inertia parameter (only applies if periodic)


%*****  RUN XCORE MODEL  **************************************************
run('../src/main')
%**************************************************************************
