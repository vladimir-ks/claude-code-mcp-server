# Consumer and placement report

Stamp: 2026-08-24

## Consumer result

- Bounded filename-only/value-safe search covered `~/.claude`, `~/.config`, `~/.cursor`, Claude Desktop configuration, `~/.mcp.json`, `~/.claude.json`, `_claude-configs` MCP profiles/specialists/bin and `_pdaa/workspace.yaml`.
- Exact needles: repository basename, canonical absolute path and `@steipete/claude-code-mcp`.
- Matches in admitted configuration/runtime surfaces: zero.
- Global npm registration: absent (`npm ls -g --depth=0 @steipete/claude-code-mcp`).
- Internal consumers are relative/package contracts: `dist/server.js`, package bin `claude-code-mcp`, and mock test clients.
- Historical Codex session logs and editor project caches were excluded as evidence/history, not active configuration.
- This is bounded absence, not a claim about every byte under the home directory.

## Steward and destination

- Product authority: upstream `steipete/claude-code-mcp` plus maintained fork `vladimir-ks/claude-code-mcp-server`.
- Primary steward/class: `external-reference`, per PDAA repository evidence lines 1647–1658; fork maintenance remains attributable to `vladimir-ks` through the configured origin.
- Approved destination: `/Users/vmks/_external/claude-code-mcp-server`.
- Destination authority: `/Users/vmks/_pdaa/_refs/workspace-convergence/repository-evidence.yaml:1647`–`:1658`, which records `external-reference`, the exact desired contract, `source-only`, G0–G5, and the G5 rollback contract.
- Target collision: absent at rehearsal time. Source and target parent are on device `16777234`.

## Cutover condition

Relocation v3 must bind the certified pushed HEAD, preserve local markers, retain the four governing historical-source records behind the compatibility alias, prove target operation with the legacy path hidden, and execute rollback/reapply with exact identity and persistence parity.
