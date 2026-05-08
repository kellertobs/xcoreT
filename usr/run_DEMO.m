% prepare workspace
clear; close all;

% load default parameters
run('./par_default')

% set run parameters
runID     =  'DEMO_MO';              % run identifier  (D = 1e2; d0 = 1e-2; etam0 = 1e1)
restart   =  0;                   % restart from file (0: new run; <0: restart from last; >0: restart from specified frame)
nop       =  50;                   % output frame plotted/saved every 'nop' time steps
nrh       =  1;                   % record metrics history every 'nrh' time steps
plot_op   =  1;                   % switch on to live plot results
save_op   =  1;                   % switch on to save output to file
ndm_op    =  0;                   % plot nondimensionalised output

% set model domain parameters
D         =  1e6;                  % chamber depth [m]
N         =  100;                  % number of grid points in z-direction
h         =  D/N;                 % grid spacing (equal in both dimensions, do not set) [m]
L         =  D*1.5;               % chamber width (equal to h for 1-D mode) [m]

% set model timing parameters
t0end     =  200.0;                % stop when dimensionless time is reached
dt        =  1e2;

% set physical control parameters
g0        =  1.72;
d0        =  1e-1;                % xtal size constant [m]
etam0     =  1e-1;                % melt viscosity constant [kg/m3]
L0        =  D/100;               % correlation length for eddy diffusivity (multiple of h, 0.5-1)
l0        =  d0*10;               % correlation length for phase fluctuation diffusivity (multiple of d0, 10-20)
Da        =  0.01;                % relative amplitude of crystallisation rate [s]
Xi        =  1;                   % relative amplitude of random noise flux
Dsm       =  350;                 % entropy of fusion [J/kg/K]
kT        = 1e-6;                 % thermal diffusivity [m2/s] 
cP        = 1000;                 % heat capacity [J/kg/K]
aT        = 5e-5;                 % thermal expansivity [1/K]
bPx       = 2e-11;                % xtal compressibility [1/Pa]
bPm       = 4e-11;                % melt compressibility [1/Pa]
Tliq0     = 1450;                 % liquidus temperature at P = P0 [C]
Tsol0     = 1200;                 % solidus temperature at P = P0 [C]
clap      =  (1/rhom0-1/rhox0)/Dsm;                   % liquidus/solidus Clapeyron slope (1/rhom0-1/rhox0)/Dsm (K/Pa)
adb       =  aT./rhom0./cP;                   % adiabatic coefficient aT./rhom0./cP [1/Pa]
dTr       =  1/10;                 % random T perturbation [K]
dTg       =  0;                   % gaussian T perturbation [K]
Tw        =  0;                   % wall rock temperature [C]
tauw      =  1e6;                   % wall cooling time [s]
taux      =  1000;
dTin      =  1;
rhom0     =  2700;                % melt density constant [kg/m3]
rhox0     =  3200;                % xtal density constant [kg/m3]

% set numerical model parameters
CFL       =  0.75;                % (physical) time stepping courant number (multiplies stable step) [0,1]
rtol      =  1e-3;                % outer its relative tolerance
atol      =  1e-9;                % outer its absolute tolerance
maxit     =  10;                  % maximum outer its
alpha     =  0.75;                % iterative step size parameter
gamma     =  1e-3;                % artificial horizontal inertia parameter (only applies if periodic)


%*****  RUN XCORE MODEL  **************************************************
run('../src/main')
%**************************************************************************
