# SySCoRe: Toolbox for the Synthesis of Linear Temporal Logic

## A Quick Start Tutorial

### 1. Introduction

**SySCoRe** stands for *Synthesis via Stochastic Coupling Relations for stochastic continuous state systems*. It is a toolbox that synthesizes controllers for stochastic continuous-state systems to satisfy ***linear temporal logic (LTL)*** specifications. Starting from a system description and a ***co-safe linear temporal logic specification (scLTL)***, **SySCoRe** provides all necessary functions for synthesizing a robust controller and quantifying the associated formal robustness guarantees. It distinguishes itself from other available tools by supporting nonlinear dynamics, complex co-safe temporal logic specifications over infinite horizons and model-order reduction.

To achieve this, **SySCoRe** first generates a finite-state abstraction of the provided model and performs probabilistic model checking. Then, it establishes a probabilistic coupling to the original stochastic system encoded in an approximate simulation relation, based on which a lower bound on the satisfaction probability is computed. **SySCoRe** provides non-trivial lower bounds for infinite-horizon properties and unbounded disturbances since its computed error does not grow linear in the horizon of the specification. It exploits a tensor representation to facilitate the efficient computation of transition probabilities. We showcase these features on several tutorials.

#### License

See the `LICENSE` file for the license terms of this toolbox.

#### Documentation Support

See the folder `SySCoRe-software/doc` for full documentation and a `GettingStarted` file. 

#### Supported Operating Systems

This toolbox can be running on ***Windows***, ***Ubuntu***, and ***Mac OS***. Note that all paths in this tutorial follow the ***Linux*** convention. Beware of changes if you are using ***Windows*** or ***Mac OS***.

#### Contributors

This toolbox is created by: **Birgit van Huijgevoort**, **Oliver Schön**, **Sadegh Soudjani** and **Sofie Haesaert**.


### 2. Installation of Dependencies

#### MATLAB toolboxes

Install MATLAB toolboxes ***Control System Toolbox***, ***Statistics and Machine Learning Toolbox*** and ***Deep Learning Toolbox***. This can be done by running the installation package of MATLAB and select the corresponding terms in the installation options. You can also install them in the MATLAB Window.

#### tbxmanager

Install the ***tbxmanager*** following [***this instruction***](https://www.mpt3.org/Main/Installation) which includes a cluster MATLAB toolboxes for you, including ***YALMIP***, the ***sedumi*** solver, ***mpt*** that works with polyhedrons, which are necessary dependencies for this toolbox. Let us use `$TBX_MANAGER_DIR` to denote the path of the root directory of the installation. The associated MATLAB toolboxes are placed under `$TBX_MANAGER_DIR/toolboxes/`. You may also replace them with your own installations, although it is not necessary.

#### the mosek solver for YALMIP

The ***mosek*** solver is also needed, which can be installed following [***this instruction***](https://docs.mosek.com/10.0/install/installation.html). Note that ***mosek*** has different versions among ***Conda***, ***Windows***, ***Linux***, and ***Mac OS***. **Be careful that you are downloading the correct version according to your operating system.** 

- **IMPORTANT information about license!!!**: to use ***mosek***, you need to obtain a personal license file `mosek.lic` following [***this intruction***](https://docs.mosek.com/10.0/licensing/index.html) and place it in the directory regulated by the installation instruction. This license is only for a specific user. But it can be used on different operating systems. 

- **IMPORTANT for Windows user!!!**: it is recommended to use the *Manual Installers (Alternative)* option to directly download the archive of ***mosek*** and extract it to your preferred directory, instead of installing from a `.msi` file using the *Default Installers (Preferred)* option. The reason is that the latter will defaultly install ***mosek*** in your `C:/Program Files` directory. **Note that MATLAB does not accept spaces in a path...**

Supposing that the path of the root directory of your ***mosek*** is `$MOSEK_DIR`, what we are concerned with is the path of the MATLAB toolbox of ***mosek***, i.e., `$MOSEK_MATLAB_DIR=$MOSEK_DIR/mosek/X.X/toolbox/r20xxa`, where `X` and `x` denote the version numbers.

#### tensor toolbox

Download the ***tensor toolbox*** following [***this instruction***](https://www.tensortoolbox.org). Note down its root path as `$TENSOR_DIR`.

### 3. One-Time Configuration

Before you run any codes in this toolbox, you need to add the root paths of your ***tbxmanager***, ***mosek*** solver, and ***tensor_toolbox*** to MATLAB. We recommend to simplify this process via one-time configuration. Supposing that the root directory of this toolbox is `$SYSCORE_ROOT=SySCoRe-software`, open `$SYSCORE_ROOT/config.m`, and fill the paths of the above toolboxes in your system to the corresponding `addpath` statements.
```
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
```
Meanwhile, the configuration file also add the paths of all subfolders of this toolbox via
```
%% Add all subfolders of this toolbox to the MATLAB path.
% You do not need to modify this part
addpath(genpath(fileparts(which(mfilename))));
```
This configuration only needs to be conducted once. Whenever you run a code using this toolbox, run this `config.m` file first.

### 3. Running Tutorials

You can run all six tutorial scripts under the `SYSCORE_ROOT/Tutorials/` directory.
- `$SYSCORE_ROOT/Tutorials/CarPark1D.m`
- `$SYSCORE_ROOT/Tutorials/CarPark2D_RunningExample.m`
- `$SYSCORE_ROOT/Tutorials/CarPark2D_interfaceOption.m`
- `$SYSCORE_ROOT/Tutorials/PackageDelivery.m`
- `$SYSCORE_ROOT/Tutorials/BAS.m`
- `$SYSCORE_ROOT/Tutorials/VanderPol.m`

Note that all tutorial codes start with the following statements:
```
clc; clear; close all;                      % Clean the environment;
cd([fileparts(which(mfilename)), '/..']);   % Navigate back to the root directory of the toolbox;
run config.m                                % Run the configuration file.
```
It is important that the running should be conducted under the root directory `SYSCORE_ROOT` since many functions in this toolbox use **relative paths**. Your code can also start with these statements, but do change the relative path `/..` in the statement according to the specific position of your `m`-script.


### 4. Classes and Functions

Use the following classes and functions to solve your problems.

#### Build dynamic system models
Use the following classes to build a model:
- `$SYSCORE_ROOT/Models/LinModel.m`: for linear models;
- `$SYSCORE_ROOT/Models/NonlinModel.m`: for nonlinear models.

#### Translate a specification to a DFA
Use the following function to translate an LTL formula to a DFA:
- `$SYSCORE_ROOT/Specification/TranslateSpec.m`

This function calls a series functions following `TranslateSpec` -> `spec2buchi` -> `create_buchi`, and the last one runs the executable `$SYSCORE_ROOT/Specification/LTL2BA/ltl2ba/ltl2ba_X` which generates a Büchi Automaton, where `X` can be either `win`, `linux`, or `mac`, respectively representing the executables that should be run on ***Windows***, ***Ubuntu***, or ***Mac OS***. The source code of these executables is written in ***C*** and can be obtained in [*here*](http://www.lsv.fr/~gastin/ltl2ba/download.php). An online tool of translating an LTL specification to a Büchi Automaton can be found [*here*](http://www.lsv.fr/~gastin/ltl2ba/).


#### Compute abstraction
Use the following functions to compute abstract models:
- `$SYSCORE_ROOT/Abstractions/FSabstraction.m`: for finite state abstraction;
- `$SYSCORE_ROOT/Abstractions/ModelReduction.m` for a reduced-order model;
- `$SYSCORE_ROOT/Abstractions/PWAapproximation.m` for a piecewise-affine approximation.

#### Relation quantification
Use the following function to quantify the simulation relation between the abstract and original model
- `$SYSCORE_ROOT/Similarity/QuantifySim.m` 

#### Synthesis
Use the following classes and functions to synthesize a robust controller
- `$SYSCORE_ROOT/Controllers/RefineController.m`: the class for a refined controller;
- `$SYSCORE_ROOT/Controllers/SynthesizeRobustController.m`: synthesize a robust controller;
- `$SYSCORE_ROOT/Controllers/ImplementController.m`: simulate the closed loop system with the synthesized controller.


### References
- **van Huijgevoort, B. C.** and **Haesaert, S.** (2020). Similarity quantification for linear stochastic systems: A coupling compensator approach. *Automatica*, 144, 110476.
- **Haesaert, S.**, **Soudjani, S. **, and **Abate, A.** (2017). Verification of general Markov decision processes by approximate similarity relations and policy refinement. *SIAM Journal on Control and Optimization*, 55(4), 2333-2367.
- **Haesaert, S.** and **Soudjani, S.** (2020). Robust dynamic programming for temporal logic control of stochastic systems. *IEEE Transactions on Automatic Control*, 66(6), 2496-2511.
- **van Huijgevoort, B.C.** and **Haesaert, S.** (2022). Temporal logic control of nonlinear stochastic systems using a piecewise-affine abstraction. [[*Link*](https://www.sofiehaesaert.com/assets/Research/PWA_abstractions.pdf)]

