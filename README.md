# MFAC Trajectory Control Experiments

This repository contains the supplied simulation code and figures for **Nonlinear Trajectory Tracking of Unmanned Vehicle Climbing Based on Model-free Adaptive Control**.

The code studies a compact-format dynamic-linearization MFAC controller on a nonlinear discrete-time plant. It estimates the pseudo-partial derivative (PPD) from input/output data and updates the control input using the tracking error and a regularization term.

## What is included

- **Parameter sweeps** in `experiments/parameter_sweeps/` for the adaptive gain `eta`, reset denominator `mu`, control update factor `rho`, and regularization weight `lambda`.
- **Communication interruption scenarios** in `experiments/interruption_scenarios/` for a one-step interruption, an interval interruption, and random interruptions.
- **Python code generators** in `scripts/`. These generate the MATLAB experiment files and plotting code used by the supplied experiments.
- **Result figures** in `results/`, grouped to match the two experiment families.

The scripts model a scalar nonlinear discrete-time plant. The paper also discusses multi-agent trajectory tracking and network disturbances; the multi-agent topology simulations and the paper PDF are not part of this archive.

## Repository layout

```text
experiments/
  parameter_sweeps/       MATLAB scripts for eta, mu, rho, and lambda sweeps
  interruption_scenarios/ MATLAB scripts for interruption experiments
scripts/                  Python generators for the MATLAB files
results/                  Supplied PNG figures
```

## Requirements

- MATLAB R2018b or newer, or GNU Octave with compatible plotting functions.
- Python 3.9+ only if you want to regenerate the MATLAB source from the generators.

No third-party Python packages are required by the generators.

## Running the MATLAB experiments

Open MATLAB or Octave, change into one experiment directory, and run a script:

```matlab
cd experiments/parameter_sweeps
code_eta
code_mu
code_rho
code_lambda
```

For the interruption experiments:

```matlab
cd experiments/interruption_scenarios
code_lambda_1_one_step
code_lambda_2_range
code_lambda_3_random
```

Each script simulates 1,000 discrete time steps and opens three figures: tracking output, control input, and PPD estimation. The supplied PNG files are reference outputs from the original runs.

## Regenerating MATLAB files

The generators contain the parameter lists, plotting styles, and code templates used for the supplied scripts. Run them from the repository root:

```bash
python scripts/get_parameter_sweep_code.py
python scripts/get_interruption_scenario_code.py
```

The generators retain the original output-path settings used by the source archive. If you regenerate files on another machine, update those paths before running the scripts.

## Relation to the paper

The repository supports the parameter-tuning and packet-loss/interruption experiments described in the paper's experiments section. The source paper reports broader multi-agent simulations, theoretical analysis, and additional network disturbance cases. Those parts are documented for context only and are not claimed to be reproduced here.

## Citation

If you use this code, cite the associated paper:

> Yunhui Zhou, "Nonlinear Trajectory Tracking of Unmanned Vehicle Climbing Based on Model-free Adaptive Control," 2025 5th International Conference on Artificial Intelligence, Automation and High Performance Computing (AIAHPC).

## License

No license was provided with the source archive. Contact the author before redistributing modified versions or using the code in a commercial project.
