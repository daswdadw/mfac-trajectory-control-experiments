# MFAC Trajectory Control Experiments Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Publish the supplied MFAC simulation scripts and result figures as an independent, reproducible GitHub repository.

**Architecture:** Preserve the original MATLAB experiment scripts and Python code generators under `experiments/`, place supplied figures under `results/`, and add concise English documentation. The repository documents the scope accurately: scalar nonlinear discrete-system experiments are included; the paper's multi-agent extension is not included in this archive.

**Tech Stack:** MATLAB/Octave scripts, Python 3 code generators, Markdown, GitHub Git repository.

**Spec:** Approved chat design on 2026-10-16.

## Global Constraints

- Keep this project separate from FoodShutter and StudentInformationGUI.
- Do not upload the paper, application documents, credentials, or unrelated files.
- Preserve the supplied algorithm source and generated figures.
- Use English documentation and repository metadata.

---

### Task 1: Assemble the repository

- [ ] Copy the two experiment groups from `research-experiment-inspect/images` into the repository's `experiments/` and `results/` folders.
- [ ] Keep Python generators in `scripts/` with their original source preserved.

### Task 2: Document scope and execution

- [ ] Write an English README describing MFAC, parameter sweeps, interruption scenarios, file layout, prerequisites, and MATLAB/Octave run commands.
- [ ] Add a paper mapping note that distinguishes included scalar simulations from the paper's multi-agent extension.
- [ ] Add a root `.gitignore` for MATLAB and Python generated files.

### Task 3: Validate and publish

- [ ] Run Python compilation checks and inspect source for secrets and personal paths.
- [ ] Check repository size and Git status.
- [ ] Create an independent Git history on `main`.
- [ ] Create `daswdadw/mfac-trajectory-control-experiments` and upload the verified tree.
- [ ] Verify the remote default branch and key files through GitHub API.
