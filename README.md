# Legit Security — AI Guard for Claude Code

Protect your AI-assisted development with real-time security guardrails, directly in Claude Code.

## Features

- **Secrets Detection** — Prevents accidental leakage of API keys, tokens, and credentials in your prompts
- **Prompt Injection Prevention** — Blocks malicious prompt injection attempts before they reach the model
- **Hidden Character Detection** — Catches invisible and homoglyph characters that could be used for attacks
- **MCP Allow List Enforcement** — Controls which MCP tools Claude Code is permitted to use

## Installation

1. Add the marketplace in Claude Code:
   ```
   /plugin marketplace add Legit-Labs/claude-marketplace
   ```

2. Install the plugin:
   ```
   /plugin install vibeguard@legit-labs-claude-marketplace
   ```

3. Authenticate with your Legit Security account:
   ```bash
   legit auth
   ```

## Supported Platforms

| OS | Architecture |
|----|-------------|
| macOS | Apple Silicon (arm64), Intel (amd64) |
| Linux | amd64, arm64 |
| Windows | amd64, arm64 |

## How It Works

AI Guard runs automatically in the background after installation. It hooks into three points in the Claude Code lifecycle:

| Event | Protection |
|-------|-----------|
| **Session start** | Validates your configuration and connects to the Legit Security backend |
| **Before each prompt** | Scans for secrets, hidden characters, and prompt injection attempts |
| **Before tool use** | Enforces your MCP tool allow list policy |

If a threat is detected, Claude Code is blocked from proceeding and you'll see a clear explanation of what was caught.

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI
- A Legit Security account — [get started at legitsecurity.com](https://www.legitsecurity.com)

## Support

For issues or questions, reach out to [support@legitsecurity.com](mailto:support@legitsecurity.com).

## License

MIT
