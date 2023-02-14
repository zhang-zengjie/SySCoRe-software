# SySCoRe: Toolbox for the Synthesis of Linear Temporal Logic

## Quick Start Tutorial

### 1. Introduction

**SySCoRe** stands for *Synthesis via Stochastic Coupling Relations for stochastic continuous state systems*. It is a toolbox that synthesizes controllers for stochastic continuous-state systems to satisfy ***linear temporal logic (LTL)*** specifications. Starting from a system description and a ***co-safe linear temporal logic specification (scLTL)***, **SySCoRe** provides all necessary functions for synthesizing a robust controller and quantifying the associated formal robustness guarantees. It distinguishes itself from other available tools by supporting nonlinear dynamics, complex co-safe temporal logic specifications over infinite horizons and model-order reduction.

To achieve this, **SySCoRe** first generates a finite-state abstraction of the provided model and performs probabilistic model checking. Then, it establishes a probabilistic coupling to the original stochastic system encoded in an approximate simulation relation, based on which a lower bound on the satisfaction probability is computed. **SySCoRe** provides non-trivial lower bounds for infinite-horizon properties and unbounded disturbances since its computed error does not grow linear in the horizon of the specification. It exploits a tensor representation to facilitate the efficient computation of transition probabilities. We showcase these features on several tutorials.

#### License

See the `LICENSE` file for the license terms of this toolbox.

#### Documentation Support

See the folder `SySCoRe-software/doc` for full documentation and a `GettingStarted` file. 

#### Authorship

This toolbox is created by: *Birgit van Huijgevoort*, *Oliver Schön*, *Sadegh Soudjani* and *Sofie Haesaert*.

### 1. Installation of Dependencies

#### MATLAB toolboxes

Install MATLAB toolboxes *Statistics and Machine Learning Toolbox* and *Deep Learning Toolbox*. This can be done by running the installation package of MATLAB and select the corresponding terms in the installation options.

#### The library for polyhedrons

Install the `mpt` toolbox that works with Polyhedrons follow this [instruction](https://www.mpt3.org/Main/Installation). Let us use `TBX_MANAGER_DIR` to denote the root directory of the installation.

#### YALMIP and its solvers

Install `YALMIP` following this [instruction](https://yalmip.github.io/tutorial/installation/). YALMIP is completely written in `m`-code. Thus, the installation of YALMIP is pretty simple and is irrelevant to the Operating Systems (OS). YALMIP itself does not contain low-level solvers. The following solvers need to be installed.

- Install the `SeDuMi` solver following this [instruction](https://github.com/SQLP/SeDuMi).

- Install the `MOSEK` solver following this [instruction](https://docs.mosek.com/10.0/toolbox/install-interface.html). Note that `MOSEK` has different versions among `Windows`, `Linux`, and `Mac OS`. Ensure that you are downloading the correct version. It is also important to obtain the `license` following the [intruction](https://docs.mosek.com/10.0/licensing/index.html). Note down the root directory of `MOSEK` as `MOSEK_DIR`.

#### The Tensor toolbox

Install the `Tensor toolbox` follow this [instruction](https://www.tensortoolbox.org). Note down the installation directory as `TENSOR_DIR`.

### 2. Run Tutorials


- Add all folder and sub folders to your path

- Run any tutorials from the root SySCoRe folder

Tested on macOS, with MATLAB R2022a including all standard MATLAB toolboxes.


- CarPark1D
- CarPark2D_RunningExample
- CarPark2D_interfaceOption
- PackageDelivery
- BAS
- VanderPol

## 3. Usage

### Build a model
Build a model as an object of the classes described in the folder Models:
- LinModel
- NonlinModel

### Build a specification & translate it to a DFA
- TranslateSpec

### Compute abstraction
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

