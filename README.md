# Introduction

This repository contains [GitHub Copilot CLI](https://github.com/github/copilot-cli) Skills that I use to automate parts of my workflow at my job at Microsoft.

# Skills Included

## one-on-one-prep

GitHub Copilot CLI Skill to automatically generate my manager's 1/1 meeting templates using WorkIQ and M365 Data

## vpn-toggle

Certain plugins and tools I use require being connected to the corporate VPN. This skill checks against a whitelist of user-defined plugins (including MCP servers) and tools and automatically turns on the VPN before invoking them if it is not turned on.

Note that this skill only works on Windows, as it uses `rasdial` to turn on the VPN. It does not matter weather the user uses Powershell 5,7 or cmd.

**Whitelist config:** `vpn-toggle/whitelist.yaml` (relative to the installed skill directory).

By default, the following are enabled in the whitelist:

- `mcaps-iq` plugin (MCAPS-IQ MCP server and all its tools)
- `msx` MCP server (and all `msx-*` tools)

Edit `vpn-toggle/whitelist.yaml` to add or remove plugins/tools. The file has two lists:
- `plugins:` — match by MCP server / plugin name (covers every tool the server exposes)
- `tools:` — match by individual tool name (for finer control or built-in tools)

# Pre-Installation Guide

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

## Install skills for GitHub Copilot CLI

**Installs with user not project scope. Run as a single chained command to install every skill in the repo:**

```powershell
gh skill install ng4567/ng-msft-workflow-skills one-on-one-prep --agent github-copilot --scope user; gh skill install ng4567/ng-msft-workflow-skills vpn-toggle --agent github-copilot --scope user
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
