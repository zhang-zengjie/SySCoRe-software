%%% 1D car park case study
% 
% 1D car park is an LTI systems of the form
% x(t+1) = Ax(t) + Bu(t) + Bw w(t)
% y(t) = Cx(t)
%
% Expected runtime = approx 5 seconds

clc; clear; close all;
cd([fileparts(which(mfilename)), '/..']);
config

%% Specify system parameters and regions

% Define system parameters
A = 0.9;
B = 0.5;
C = 1;
D = 0;
Bw = sqrt(0.5); % corresponds to w from distr with variance 0.5
dim = length(A);

% Specify mean and variance of disturbance w(t) 
mu = zeros(dim,1); % mean of disturbance
sigma = eye(dim); % variance of disturbance

% Set up an LTI model
sysLTI = LinModel(A,B,C,D,Bw,mu,sigma);
 
% Bounds on state space 
x1l = -10;   % Lowerbound x1
x1u = 10;   % Upperbound x1
% Define bounded state space
sysLTI.X = Polyhedron('lb', x1l, 'ub', x1u);

% Bounds on input space
ul = [-1];   % Lowerbound input u
uu = [1];     % Upperbound input u
% Define bounded input space
sysLTI.U = Polyhedron('lb', ul, 'ub', uu);

% Specify regions for the specification
P1 = [5 6];    % x1-coordinates
P1 = Polyhedron('lb', P1(1), 'ub', P1(2));

P2 = [6 10];    % x1-coordinates
P2 = Polyhedron('lb', P2(1), 'ub', P2(2));

sysLTI.regions = [P1;P2];
sysLTI.AP = {'p1', 'p2'}; % the corresponding atomic propositions

Plot_sysLTI(sysLTI)

%% Step 1: Translate the specification

% Define the scLTL specification
formula = '(!p2 U p1)';  % p1 = parking, p2 = avoid region

% Translate the spec to a DFA
%%% Make sure your current folder is the main SySCoRe folder
[DFA] = TranslateSpec(formula,sysLTI.AP);

%% Step 2 Finite-state abstraction
tGridStart = tic;

% Construct abstract input space
lu = 7; % number of abstract inputs
uhat = GridInputSpace(lu,sysLTI.U); % abstract input space

% Construct finite-state abstraction
l = 200;  % number of grid cells
tol=10^-6;
sysAbs = FSabstraction(sysLTI,uhat,l,tol,DFA);

tGridEnd = toc(tGridStart);
%% Step 3 Similarity quantification
tSimStart = tic;

% specify output deviation epsilon
epsilon = 0.2;

% Quantify similarity 
% interface function u = uhat
[rel, ~] = QuantifySim(sysLTI, sysAbs, epsilon);

tSimEnd = toc(tSimStart);

disp(['delta = ', num2str(rel.delta), ', epsilon = ', num2str(rel.epsilon) ])
%% Step 4 Synthesize a robust controller

% Specify threshold for reaching convergence
thold = 1e-6;    

% Synthesize an abstract robust controller
[satProb, pol] = SynthesizeRobustController(sysAbs,DFA, rel, thold, true);

% Plot satisfaction probability
plotSatProb(satProb, sysAbs, 'initial', DFA);

%% Step 5 Control refinement

% Refine abstract controller to a continous-state controller
Controller = RefineController(satProb,pol,sysAbs,rel,sysLTI,DFA);

%% Step 6 Implementation
x0 = -2;
N = 40;     % time horizon

% Simulate controlled system
xsim = ImplementController(x0,N,Controller);
plotTrajectories(xsim, [x1l, x1u], sysLTI);
