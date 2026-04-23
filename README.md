# Introduction

GitHub Copilot CLI Skill to automatically generate my manager's 1/1 meeting templates using WorkIQ and M365 Data

# Pre-Installation

## Install Git, GitHub CLI & GH Copilot CLI

```powershell
winget install --id Git.Git -e --source winget; winget install --id GitHub.cli -e --source winget; gh extension install github/gh-copilot
```

## Upgrade GitHub CLI & GH Copilot CLI if already installed

```powershell
winget upgrade --id GitHub.cli --id GitHub.cli.copilot
```

## Authenticate to GitHub CLI

```powershell
gh auth login
```

## Install skill for GitHub Copilot CLI
 
**This installs with user not project scope**

```powershell
gh skill install ng4567/one-on-one-skill one-on-one-prep --agent github-copilot --scope user
```

## Run With Copilot CLI

```powershell
copilot
```

Choose model

```powershell
/model
```

## Autoapprove all commands and run with selected model:

```powershell
copilot --autopilot --yolo --max-autopilot-continues 50 -s -p "/one-on-one-prep"
```