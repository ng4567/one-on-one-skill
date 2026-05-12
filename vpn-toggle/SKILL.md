---
name: vpn-toggle
description: "Ensures the Microsoft corporate VPN is connected before invoking any whitelisted MCP server (plugin) or tool. Reads the user-defined whitelist in vpn-toggle/whitelist.yaml, checks whether the MSFT-AzVPN-Manual connection is up, and runs `rasdial \"MSFT-AzVPN-Manual\"` to bring it up if it is not. Use whenever about to call a tool from a plugin/MCP server that requires corpnet access (e.g., mcaps-iq, msx)."
user-invocable: true
allowed-tools:
   - shell(rasdial)
   - shell(rasdial *)
license: MIT
---

# VPN Toggle

This skill guards corpnet-only MCP servers and tools. Before any tool call against a whitelisted plugin or tool name, it verifies the Microsoft VPN (`MSFT-AzVPN-Manual`) is connected and dials it if not.

## When to Use

Run this skill (or its check step) **before** invoking any tool from a plugin/MCP server listed in `vpn-toggle/whitelist.yaml`. It is safe to call repeatedly — it is a no-op when the VPN is already up.

By default the whitelist enables:
- `mcaps-iq` (MCAPS-IQ MCP plugin and all `mcaps-iq:*` tools)
- `msx` (MSX MCP server and all `msx-*` tools)

Add or remove entries by editing `vpn-toggle/whitelist.yaml`.

## Procedure

1. **Load the whitelist**
   - Read `vpn-toggle/whitelist.yaml` from this skill's folder.
   - Collect the set of whitelisted plugin names (`plugins:`) and tool names (`tools:`).

2. **Decide if a guard is needed**
   - If the next intended tool call's plugin OR tool name matches the whitelist, continue. Otherwise skip.

3. **Check VPN status**
   - Run: `rasdial`
   - Parse the output. If a line containing `MSFT-AzVPN-Manual` appears under "Connected to", the VPN is up — proceed with the original tool call.
   - If the output is `No connections` or does not list `MSFT-AzVPN-Manual`, go to step 4.

4. **Connect the VPN**
   - Run: `rasdial "MSFT-AzVPN-Manual"`
   - If the command exits 0, the VPN is up — proceed.
   - If it fails (e.g., requires interactive credentials, smart card, or MFA prompt), surface the exact stderr to the user and stop. Do not retry silently.

5. **Proceed**
   - Invoke the original whitelisted tool/plugin call.

## Notes

- This skill only runs `rasdial` and `rasdial "MSFT-AzVPN-Manual"`. It never disconnects the VPN.
- The whitelist file lives at `vpn-toggle/whitelist.yaml` relative to the installed skill directory.
- Plugin matching is by exact plugin name (e.g., `msx`, `mcaps-iq`). Tool matching is by exact tool name (e.g., `msx-get_milestones`) and overrides plugin-level rules when more specific.
- If `rasdial` is unavailable (non-Windows), report this to the user and stop — do not attempt a workaround.
