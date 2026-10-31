# Complexity Synchronization in an Adaptive Predator–Prey Model

**MATLAB code, saved results, and figure-reproduction scripts** accompanying the manuscript *“Complexity synchronization and targeted restoration in an adaptive predator–prey model.”*

## Overview

This GitHub repository provides the original MATLAB scripts, while the linked Google Drive folder provides plotting-only scripts and supporting numerical results for investigating **complexity synchronization (CS)** in an adaptive predator–prey model. The study examines relationships among adaptive agent behavior, cooperation, and synchronization, including the effects of perturbations and targeted restoration.

The repository supports two ways of working with the results: running the original stochastic simulations and analyses, or regenerating figures directly from saved MATLAB data without repeating the computationally intensive simulations.

## Plotting-only MATLAB codes and saved data (Google Drive)

The original MATLAB simulation and analysis scripts are available in this GitHub repository. The **plotting-only scripts and corresponding saved `.mat` results are provided together in a separate Google Drive folder**, because the complete dataset is too large for convenient hosting on GitHub.

**[Open the PlotOnly codes and data folder on Google Drive](https://drive.google.com/drive/folders/1nsBMYfHT2zdiWQ-1FdK4kekL1ljbBBH5?usp=sharing)**

To reproduce a figure without rerunning the stochastic simulations, download the relevant `PLOT_ONLY_*.m` script and its matching `.mat` file from this folder. Keep the files in the expected local directory, update any hard-coded `matPath` in the script to the location of the downloaded `.mat` file, and run the script in MATLAB. Output images are saved in the directory specified by each script (often `Figures`). If a batch plotting script (`RUN_ALL_PLOTS.m`) is included, it may be used after checking its file paths and requirements.

**Note:** The Google Drive URL above points to a **folder**, not the previous `PlotOnly.zip` file link. Use this folder to locate the plotting scripts and their required data files together.

## Repository structure

```text
.
├── Fig2_Animation.m
├── Fig3_trajectories.m
├── Fig4a_CCpayvsRS.m
├── Fig4b_CCpayTime.m
├── Fig5a_CStimeMDEAgraph.m
├── Fig5b_CStimeDFAgraph.m
├── Fig6_CvsCS_MDEA.m
├── Fig7_CvsCS_DFA.m
├── Fig8_CSperturbation_MDEA.m
├── Fig9_CSperturbation_DFA.m
├── Fig10_11andS1andS2.m
├── FigS3_CrossCorrelationRaw.m
├── FigS4_RenewalTest.m
├── FigS5_AutocorrelationTaus.m

PlotOnly codes and saved results: hosted separately in the Google Drive folder linked above
    ├── PLOT_ONLY_*.m
    └── *.mat
```

*File extensions are shown explicitly for clarity; Windows may hide them. The `PLOT_ONLY_*.m` and `*.mat` entries represent the corresponding individual figure files.*

## Reproducing the figures

### Option 1 — Plot from saved results (recommended)

1. Open the [Google Drive folder](https://drive.google.com/drive/folders/1nsBMYfHT2zdiWQ-1FdK4kekL1ljbBBH5?usp=sharing) and download the matching plotting-only `.m` script and `.mat` data file(s).
2. Place the downloaded files in a local folder and open that folder in MATLAB.
3. Run the `PLOT_ONLY_*.m` script corresponding to the figure you want to reproduce, or review `RUN_ALL_PLOTS.m` for batch plotting.
4. Ensure that the script's MAT-file path points to the matching downloaded `.mat` file. Some scripts may require updating a local path.
5. Find the exported figure in the output directory specified by that script (typically a `Figures` subfolder).

These plotting-only scripts are intended to read saved numerical results rather than rerun the agent-based simulations or recompute MDEA/DFA analyses. If the downloaded folder includes a separate README, consult it for any additional script-specific instructions.

### Option 2 — Run the original simulations

Run the original figure-specific MATLAB `.m` files in the repository root. These scripts generate or analyze model results and may take substantially longer to execute. Depending on the script, additional MATLAB toolboxes or helper functions may be required; consult the script headers and code before running.

## Reproducibility and stochastic variation

The predator–prey model contains stochastic processes. Independent simulation runs can therefore produce numerical differences, even when the qualitative behavior is comparable. The `.mat` files in the linked Google Drive folder preserve saved results for direct figure reconstruction, avoiding the need to repeat lengthy simulations when the goal is simply to reproduce a plot.

**Important:** Each plotting-only script must be paired with its corresponding MAT file. A MAT file from a different analysis may contain different variables and cannot be used interchangeably.

## Citation

If you use these scripts or results, please cite the associated manuscript:

Mahmoodi, K., Kerick, S., Franaszczuk, P., Boothe, D., Grigolini, P., and West, B. *Complexity synchronization and targeted restoration in an adaptive predator–prey model.* Manuscript submitted to **PNAS Nexus**.

Please update the citation with the publication details and DOI if the paper is published.

## Questions and reuse

The code and data are shared to facilitate inspection, reproducibility, and further research on complexity synchronization in adaptive systems. Consult any license file in the repository for applicable reuse permissions; public availability alone does not establish a license.
