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

This toolbox can be running on Windows, Ubuntu, and Mac OS.

#### Authorship

This toolbox is created by: *Birgit van Huijgevoort*, *Oliver Schön*, *Sadegh Soudjani* and *Sofie Haesaert*.

#### Note on Path Convension

All paths in this tutorial follow the **Linux** convention. Beware of changes if you are using **Windows** or **Mac OS**.


### 2. Installation of Dependencies

#### MATLAB toolboxes

Install MATLAB toolboxes ***Control System Toolbox***, ***Statistics and Machine Learning Toolbox*** and ***Deep Learning Toolbox***. This can be done by running the installation package of MATLAB and select the corresponding terms in the installation options. You can also install them in the MATLAB Window.

#### tbxmanager

Configure the `tbxmanager` following [***this instruction***](https://www.mpt3.org/Main/Installation) which installs a cluster MATLAB toolboxes for you, including `YALMIP`, the `sedumi` solver, `mpt` that works with polyhedrons, which are necessary dependencies for this toolbox. Let us use `TBX_MANAGER_DIR` to denote the root directory of the installation. The associated MATLAB toolboxes are placed under `TBX_MANAGER_DIR/toolboxes/`. You may also replace them with your own installations, although it is not necessary.

#### the mosek solver for YALMIP

The `mosek` solver is also needed, which can be installed following [***this instruction***](https://docs.mosek.com/10.0/install/installation.html). Note that `mosek` has different versions among `Conda`, `Windows`, `Linux`, and `Mac OS`. **Be careful that you are downloading the correct version**. It is also important to obtain the personal license file `mosek.lic` following [***this intruction***](https://docs.mosek.com/10.0/licensing/index.html) and place it in the directory regulated by the installation instruction. This license is only for a specific user of the OS. Note down the root directory of `mosek` as `MOSEK_DIR`. We are only using the MATLAB toolbox of `mosek`, so the concerned path is `MOSEK_MATLAB_DIR = MOSEK_DIR/mosek/X.X/toolbox/r20xxa`. The specific path name may be different according to the versions.

#### tensor toolbox

Download the `tensor toolbox` follow [this instruction](https://www.tensortoolbox.org). Note down its root directory as `TENSOR_DIR`.

### 3. One-time configuration

Before you run any codes in this toolbox, you need to add the paths of the `tbxmanager`, the `mosek` solver, and the `tensor_toolbox` to MATLAB. We recommend to simplify this process via one-time configuration. Supposing that the root directory of this toolbox is `SYSCORE_ROOT=SySCoRe-software`, open `SYSCORE_ROOT/config.m`, and fill the paths of the above toolboxes to the corresponding `addpath` statements.
```
try % Add the path to the tbxmanager
    addpath(genpath('~/Documents/test/tbxmanager/'));
catch
    warning('Could not find mpt3 toolbox. Synthesis may fail.');
end

try % Add the path to the tensor_toolbox
    addpath(genpath('~/Documents/test/tensor_toolbox/'));
catch
    warning('Could not find tensor toolbox. Synthesis may fail.');
end

try % Add the path to the mosek solver
    addpath(genpath('~/Documents/test/mosek/mosek/10.0/toolbox/r2017a'));
catch
    warning('Could not find mosek solver. Synthesis may fail.');
end
```
Meanwhile, the configuration file also add the paths of all subfolders of this toolbox via
```
addpath(genpath(fileparts(which(mfilename))));
```
This configuration only needs to be conducted once. Whenever you run a code using this toolbox, run this `config.m` file first.

### 3. Running Tutorials

You can run all six tutorial scripts under the 'SYSCORE_ROOT/Tutorials/' directory.
- `SYSCORE_ROOT/Tutorials/CarPark1D.m`
- `SYSCORE_ROOT/Tutorials/CarPark2D_RunningExample.m`
- `SYSCORE_ROOT/Tutorials/CarPark2D_interfaceOption.m`
- `SYSCORE_ROOT/Tutorials/PackageDelivery.m`
- `SYSCORE_ROOT/Tutorials/BAS.m`
- `SYSCORE_ROOT/Tutorials/VanderPol.m`

Note that all tutorial codes start with the following statements:
```
clc; clear; close all;                      % Clean the environment;
cd([fileparts(which(mfilename)), '/..']);   % Navigate back to the root directory of the toolbox;
run config.m                                % Run the configuration file.
```
It is important that the running should be conducted under the root directory `SySCoRe-software` since many functions in this toolbox use **relative paths**. Your code can also start with these statements, but do change the relative path `/..` in the statement according to the specific position of your `m`-script.


### 4. Classes and functions

Use the following classes and functions to solve your problems.

#### Building a model
Using the following classes to build a model:
- `Models/LinModel.m`
- NonlinModel

#### Build a specification & translate it to a DFA
- TranslateSpec

#### Computing abstraction
Compute a finite state abstraction using
- FSabstraction

Compute a reduced-order model using
- ModelReduction

Compute a piecewise-affine approximation using
- PWAapproximation

### Quantify the simulation model between the abstract and original model
- QuantifySim

### Synthesize a robust controller
- RefineController

### Simulate the resulting closed loop system
- ImplementController

## References
- van Huijgevoort, B. C., & Haesaert, S. (2020). Similarity quantification for linear stochastic systems: A coupling compensator approach. Automatica, 144, 110476.
- Haesaert, S., Soudjani, S. , & Abate, A. (2017). Verification of general Markov decision processes by approximate similarity relations and policy refinement. SIAM Journal on Control and Optimization, 55(4), 2333-2367.
- Haesaert, S., & Soudjani, S. (2020). Robust dynamic programming for temporal logic control of stochastic systems. IEEE Transactions on Automatic Control, 66(6), 2496-2511.
- van Huijgevoort, B.C. & Haesaert, S. (2022). Temporal logic control of nonlinear stochastic systems using a piecewise-affine abstraction. https://www.sofiehaesaert.com/assets/Research/PWA_abstractions.pdf

