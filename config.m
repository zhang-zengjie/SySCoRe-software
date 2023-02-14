%% config.m
% Add the necessary paths of the dependencies

%% Add the paths of the dependencies
% IMPORTANT!!!: this is just a template. You need to replace the paths below using your own paths of installation
    
try % Add the path to the tbxmanager
    addpath(genpath('~/tbxmanager/'));
catch
    warning('Could not find mpt3 toolbox. Synthesis may fail.');
end

try % Add the path to the tensor_toolbox
    addpath(genpath('~/tensor_toolbox/'));
catch
    warning('Could not find tensor toolbox. Synthesis may fail.');
end

try % Add the path to the mosek solver
    addpath(genpath('~/mosek/mosek/10.0/toolbox/r2017a'));
catch
    warning('Could not find mosek solver. Synthesis may fail.');
end

%% Add all subfolders of this toolbox to the MATLAB path.
% You do not need to modify this part
addpath(genpath(fileparts(which(mfilename))));
